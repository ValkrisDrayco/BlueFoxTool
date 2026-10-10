#!/data/data/com.termux/files/usr/bin/bash
# language: Bash, file: modules/05_token_checker.sh
# Vérifie une liste de tokens Discord — 1 token par ligne

R='\033[1;31m'
G='\033[1;32m'
Y='\033[1;33m'
C='\033[1;36m'
N='\033[0m'

clear
echo -e "${C}=== TOKEN CHECKER ===${N}"
echo ""
echo "  Format du fichier : 1 token par ligne"
echo "  Exemple : ~/tokens.txt"
echo ""
read -p "Chemin du fichier > " FILE

FILE=$(eval echo "$FILE")

[ ! -f "$FILE" ] && { echo -e "${R}[!] Fichier introuvable : $FILE${N}"; read -p "Entrée..."; exit 0; }

TOTAL=0
VALID=0
INVALID=0
OUTPUT="$HOME/valides.txt"
> "$OUTPUT"

echo ""
echo -e "${Y}[*] Vérification en cours...${N}"
echo ""

while IFS= read -r TOKEN; do
    [ -z "$TOKEN" ] && continue
    TOTAL=$((TOTAL + 1))

    RESP=$(curl -s -H "Authorization: $TOKEN" "https://discord.com/api/v10/users/@me")

    if echo "$RESP" | grep -q '"id"'; then
        INFO=$(echo "$RESP" | python -c "import sys,json; d=json.load(sys.stdin); print(d.get('username','?'), '|', d.get('id','?'), '|', d.get('email','non'))")
        echo -e "${G}[+] VALIDE${N} : $INFO"
        echo "$TOKEN | $INFO" >> "$OUTPUT"
        VALID=$((VALID + 1))
    else
        echo -e "${R}[-] INVALIDE${N}"
        INVALID=$((INVALID + 1))
    fi

    sleep 0.5
done < "$FILE"

echo ""
echo -e "${C}=== RÉSULTAT ===${N}"
echo "  Total     : $TOTAL"
echo -e "  ${G}Valides   : $VALID${N}"
echo -e "  ${R}Invalides : $INVALID${N}"
echo ""
echo -e "${G}[*] Tokens valides sauvegardés dans : $OUTPUT${N}"
echo ""
read -p "Entrée pour revenir au menu..."
