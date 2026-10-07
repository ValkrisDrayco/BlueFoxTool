#!/data/data/com.termux/files/usr/bin/bash
# language: Bash, file: modules/11_obfuscator.sh
# Obfuscation Python — renomme vars, encode strings, compresse

clear
echo -e "\033[1;36m=== OBFUSCATOR ===\033[0m"
echo ""
echo "  1) Obfusquer un fichier .py"
echo "  2) Obfusquer du code collé direct"
echo "  0) Retour"
echo ""
read -p "Choix > " C

case $C in
    1)
        read -p "Chemin du fichier .py > " SRC
        SRC=$(eval echo "$SRC")
        [ ! -f "$SRC" ] && { echo "[!] introuvable"; read -p "Entrée..."; exit 0; }
        CODE=$(cat "$SRC")
        OUT="${SRC%.py}_obf.py"
        ;;
    2)
        echo "Colle ton code, termine par une ligne vide puis CTRL+D :"
        CODE=$(cat)
        OUT="$HOME/storage/downloads/obf_$(date +%s).py"
        ;;
    *)
        exit 0
        ;;
esac

echo ""
echo "[*] obfuscation..."

python - "$CODE" "$OUT" << 'EOF'
import sys, zlib, base64, random, string

code = sys.argv[1]
out = sys.argv[2]

# 1. compresse le code source
compressed = zlib.compress(code.encode())
# 2. encode en base64
b64 = base64.b64encode(compressed).decode()

# 3. génère un nom de variable aléatoire
def rname():
    return ''.join(random.choices(string.ascii_lowercase, k=8))

V1, V2 = rname(), rname()

obf = f'''import zlib as {V1}, base64 as {V2}
exec(zlib.decompress({V2}.b64decode({b64!r})).decode())
'''

with open(out, 'w') as f:
    f.write(obf)

print(f'[+] écrit : {out}')
print(f'[+] taille originale : {len(code)} octets')
print(f'[+] taille obfusquée : {len(obf)} octets')
EOF

echo ""
read -p "Voir le résultat ? (y/n) > " V
[ "$V" = "y" ] && cat "$OUT"

echo ""
read -p "Entrée pour revenir au menu..."

