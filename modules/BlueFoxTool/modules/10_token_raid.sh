#!/data/data/com.termux/files/usr/bin/bash
# language: Bash, file: modules/10_token_raid.sh
# Actions en masse via token Discord — USAGE TEST UNIQUEMENT

clear
echo -e "\033[1;31m=== TOKEN RAID ===\033[0m"
echo -e "\033[1;33m[!] Actions traçables. Compte de TEST uniquement.${N}"
echo ""
read -p "Token Discord > " TOKEN
[ -z "$TOKEN" ] && { echo "[!] vide"; read -p "Entrée..."; exit 0; }

# vérifie le token
ME=$(curl -s -H "Authorization: $TOKEN" "https://discord.com/api/v10/users/@me")
if echo "$ME" | grep -q '"message"'; then
    echo -e "\033[1;31m[!] Token invalide${N}"
    read -p "Entrée..."; exit 0
fi

UNAME=$(echo "$ME" | python -c "import sys,json; print(json.load(sys.stdin).get('username','?'))")
echo -e "\033[1;32m[+] Connecté en tant que : $UNAME${N}"
echo ""

echo "  1) Changer pseudo en boucle"
echo "  2) Spam DM aux amis"
echo "  3) Rejoindre un serveur via invite"
echo "  4) Supprimer tous tes messages d'un salon"
echo "  0) Retour"
echo ""
read -p "Choix > " ACTION

case $ACTION in
    1)
        read -p "Nouveau pseudo > " NAME
        read -p "Nombre de changements > " N
        N=${N:-10}
        for i in $(seq 1 "$N"); do
            curl -s -X PATCH "https://discord.com/api/v10/users/@me" \
                -H "Authorization: $TOKEN" \
                -H "Content-Type: application/json" \
                -d "{\"username\": \"${NAME}_$i\"}" > /dev/null
            echo "[$i/$N] pseudo → ${NAME}_$i"
            sleep 2
        done
        ;;
    2)
        read -p "Message à envoyer > " MSG
        read -p "Delay entre DMs (s) > " D
        D=${D:-3}
        echo "[*] récupération de tes amis..."
        # récupère les DM channels
        DMS=$(curl -s -H "Authorization: $TOKEN" "https://discord.com/api/v10/users/@me/channels")
        IDS=$(echo "$DMS" | python -c "
import sys, json
try:
    data = json.load(sys.stdin)
    for c in data:
        if c.get('type') == 1:  # DM
            for r in c.get('recipients', []):
                print(r['id'])
except: pass
")
        COUNT=$(echo "$IDS" | grep -c .)
        echo "[*] $COUNT destinataires"
        I=0
        for UID in $IDS; do
            I=$((I+1))
            # ouvre le DM
            CH=$(curl -s -X POST "https://discord.com/api/v10/users/@me/channels" \
                -H "Authorization: $TOKEN" \
                -H "Content-Type: application/json" \
                -d "{\"recipient_id\": \"$UID\"}" | python -c "import sys,json; print(json.load(sys.stdin).get('id',''))")
            [ -z "$CH" ] && continue
            curl -s -X POST "https://discord.com/api/v10/channels/$CH/messages" \
                -H "Authorization: $TOKEN" \
                -H "Content-Type: application/json" \
                -d "{\"content\": \"$MSG\"}" > /dev/null
            echo "[$I/$COUNT] envoyé à $UID"
            sleep "$D"
        done
        ;;
    3)
        read -p "Code invite (ex: abc123) > " INV
        read -p "Nombre de tentatives > " N
        N=${N:-1}
        for i in $(seq 1 "$N"); do
            RESP=$(curl -s -X POST "https://discord.com/api/v10/invites/$INV" \
                -H "Authorization: $TOKEN")
            echo "[$i/$N] $RESP"
            sleep 2
        done
        ;;
    4)
        read -p "ID du salon > " CH
        read -p "Nombre max de messages à supprimer > " N
        N=${N:-100}
        echo "[*] récupération des messages..."
        MSGS=$(curl -s -H "Authorization: $TOKEN" "https://discord.com/api/v10/channels/$CH/messages?limit=$N")
        IDS=$(echo "$MSGS" | python -c "
import sys, json
try:
    data = json.load(sys.stdin)
    for m in data:
        print(m['id'])
except: pass
")
        COUNT=$(echo "$IDS" | grep -c .)
        echo "[*] $COUNT messages trouvés"
        I=0
        for MID in $IDS; do
            I=$((I+1))
            curl -s -X DELETE "https://discord.com/api/v10/channels/$CH/messages/$MID" \
                -H "Authorization: $TOKEN" > /dev/null
            echo "[$I/$COUNT] supprimé $MID"
            sleep 1
        done
        ;;
esac

echo ""
echo "[+] terminé"
read -p "Entrée pour revenir au menu..."
