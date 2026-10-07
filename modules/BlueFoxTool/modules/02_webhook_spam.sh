#!/data/data/com.termux/files/usr/bin/bash
# language: Bash, file: modules/02_webhook_spam.sh
# Envoie en boucle des messages sur un webhook Discord — respecte le rate limit 5 req/2s

clear
echo -e "\033[1;36m=== WEBHOOK SPAM ===\033[0m"
echo ""
read -p "URL webhook > " URL
read -p "Message > " MSG
read -p "Nombre d'envois (defaut 10) > " COUNT
read -p "Delay entre envois en s (defaut 1) > " DELAY

[ -z "$URL" ] && { echo "[!] URL vide"; read -p "Entrée..."; exit 0; }
[ -z "$MSG" ] && MSG="spam"
COUNT=${COUNT:-10}
DELAY=${DELAY:-1}

echo ""
echo "[*] envoi de $COUNT messages..."
echo ""

for i in $(seq 1 "$COUNT"); do
    RESP=$(curl -s -o /dev/null -w "%{http_code}" -X POST "$URL" \
        -H "Content-Type: application/json" \
        -d "{\"content\": \"$MSG [$i/$COUNT]\"}")
    
    if [ "$RESP" = "204" ] || [ "$RESP" = "200" ]; then
        echo -e "\033[1;32m[$i/$COUNT]\033[0m envoyé (HTTP $RESP)"
    else
        echo -e "\033[1;31m[$i/$COUNT]\033[0m échec (HTTP $RESP)"
    fi
    sleep "$DELAY"
done

echo ""
echo -e "\033[1;32m[+] terminé\033[0m"
read -p "Entrée pour revenir au menu..."
