#!/data/data/com.termux/files/usr/bin/bash
# language: Bash, file: modules/09_webhook_info.sh
# Discord webhook info — GET sur l'URL du webhook

clear
echo -e "\033[1;36m=== WEBHOOK INFO ===\033[0m"
echo ""
read -p "URL webhook > " URL

[ -z "$URL" ] && { echo "[!] vide"; read -p "Entrée..."; exit 0; }

echo ""
echo "[*] requête..."
RESP=$(curl -s "$URL")

# vérifie si erreur
if echo "$RESP" | grep -q '"message"'; then
    echo -e "\033[1;31m[!] Webhook invalide\033[0m"
    echo "$RESP"
    read -p "Entrée pour revenir au menu..."
    exit 0
fi

echo -e "\033[1;32m[+] Webhook valide\033[0m"
echo ""
echo "$RESP" | python -m json.tool

echo ""
read -p "Entrée pour revenir au menu..."
