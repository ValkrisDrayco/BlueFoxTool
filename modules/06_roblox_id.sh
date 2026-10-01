#!/data/data/com.termux/files/usr/bin/bash
# language: Bash, file: modules/06_roblox_id.sh
# Roblox user info via API publique — users.roblox.com + thumbnails

clear
echo -e "\033[1;36m=== ROBLOX ID LOOKUP ===\033[0m"
echo ""
read -p "ID Roblox (ex: 1) ou pseudo > " INPUT

[ -z "$INPUT" ] && { echo "[!] vide"; read -p "Entrée..."; exit 0; }

# si c'est un pseudo, on cherche l'ID d'abord
if echo "$INPUT" | grep -qE '^[0-9]+$'; then
    UID="$INPUT"
else
    echo ""
    echo "[*] recherche de l'ID pour '$INPUT'..."
    RESP=$(curl -s -X POST "https://users.roblox.com/v1/usernames/users" \
        -H "Content-Type: application/json" \
        -d "{\"usernames\": [\"$INPUT\"], \"excludeBannedUsers\": false}")
    UID=$(echo "$RESP" | python -c "import sys,json; d=json.load(sys.stdin); print(d['data'][0]['id'] if d.get('data') else '')")
    if [ -z "$UID" ]; then
        echo -e "\033[1;31m[!] Compte introuvable\033[0m"
        read -p "Entrée..."; exit 0
    fi
    echo "[+] ID trouvé : $UID"
fi

echo ""
echo "[*] requête infos utilisateur..."
INFO=$(curl -s "https://users.roblox.com/v1/users/$UID")

# check si compte existe
if echo "$INFO" | grep -q '"errors"'; then
    echo -e "\033[1;31m[!] Compte inexistant\033[0m"
    echo "$INFO"
    read -p "Entrée..."; exit 0
fi

echo ""
echo -e "\033[1;32m=== INFOS COMPTE ===\033[0m"
echo "$INFO" | python -m json.tool

echo ""
echo "[*] avatar..."
AVATAR=$(curl -s "https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=$UID&size=420x420&format=Png&isCircular=false")
echo "$AVATAR" | python -c "
import sys, json
try:
    d = json.load(sys.stdin)
    url = d['data'][0]['imageUrl'] if d.get('data') else '?'
    print('Avatar :', url)
except Exception as e:
    print('Avatar : erreur', e)
"

echo ""
echo "[*] followers..."
FOLLOW=$(curl -s "https://friends.roblox.com/v1/users/$UID/followers/count")
echo "$FOLLOW" | python -c "
import sys, json
try:
    d = json.load(sys.stdin)
    print('Followers :', d.get('count', '?'))
except Exception as e:
    print('Followers : erreur', e)
"

echo ""
read -p "Entrée pour revenir au menu..."
