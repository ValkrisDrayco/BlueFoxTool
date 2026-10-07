#!/data/data/com.termux/files/usr/bin/bash
# language: Bash, file: modules/04_nitro_gen.sh
# Générateur de codes Nitro au format valide (NON fonctionnels)

clear
echo -e "\033[1;36m=== NITRO GENERATOR ===\033[0m"
echo -e "\033[1;33m[!] Codes au FORMAT valide uniquement. Aucun ne marche.${N}"
echo ""
read -p "Nombre de codes à générer (defaut 5) > " N
N=${N:-5}

echo ""
echo "[*] génération..."

# caractères utilisés par Discord pour les codes Nitro
CHARS="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

for i in $(seq 1 "$N"); do
    # génère 16 caractères aléatoires
    CODE=""
    for j in $(seq 1 16); do
        IDX=$((RANDOM % ${#CHARS}))
        CODE="${CODE}${CHARS:$IDX:1}"
    done
    echo -e "  \033[1;32mhttps://discord.gift/${CODE}\033[0m"
done

echo ""
echo "[+] $N codes générés."
echo "[*] Rappel : ces codes sont FAUX. Discord les rejettera."
read -p "Entrée pour revenir au menu..."
