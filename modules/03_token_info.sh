#!/data/data/com.termux/files/usr/bin/bash
# language: Bash, file: modules/03_token_info.sh
# Discord token info via API — GET /users/@me puis /users/@me/guilds

clear
echo -e "\033[1;36m=== TOKEN INFO ===\033[0m"
echo ""
read -p "Token Discord > " TOKEN

[ -z "$TOKEN" ] && { echo "[!] vide"; read -p "Entrée..."; exit 0; }

echo ""
echo "[*] requête /users/@me..."
USER=$(curl -s -H "Authorization: $TOKEN" "https://discord.com/api/v10/users/@me")

# vérifie si erreur
if echo "$USER" | grep -q '"message"'; then
    echo -e "\033[1;31m[!] Token invalide ou expiré\033[0m"
    echo "$USER"
    read -p "Entrée pour revenir au menu..."
    exit 0
fi

echo "$USER" | python -m json.tool
echo ""

echo "[*] requête /users/@me/guilds..."
GUILDS=$(curl -s -H "Authorization: $TOKEN" "https://discord.com/api/v10/users/@me/guilds")

# affiche juste le nom et l'ID de chaque serveur
echo "$GUILDS" | python -c "
import sys, json
try:
    data = json.load(sys.stdin)
    if isinstance(data, list):
        print(f'[{len(data)} serveurs]')
        for g in data[:20]:
            print(f\"  - {g.get('name','?')}  ({g.get('id','?')})\")
        if len(data) > 20:
            print(f'  ... et {len(data)-20} autres')
    else:
        print(data)
except Exception as e:
    print('erreur parse:', e)
"

echo ""
read -p "Entrée pour revenir au menu..."
