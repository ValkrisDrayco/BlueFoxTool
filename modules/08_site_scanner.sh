#!/data/data/com.termux/files/usr/bin/bash
# language: Bash, file: modules/08_site_scanner.sh
# Site scanner — headers HTTP + techno détectée + ports communs

clear
echo -e "\033[1;36m=== SITE SCANNER ===\033[0m"
echo ""
read -p "Domaine (ex: example.com) > " DOMAIN

[ -z "$DOMAIN" ] && { echo "[!] vide"; read -p "Entrée..."; exit 0; }

# retire http:// et https:// si présents
DOMAIN=$(echo "$DOMAIN" | sed 's|^https\?://||' | sed 's|/.*$||')

echo ""
echo "[*] résolution DNS..."
IP=$(getent hosts "$DOMAIN" 2>/dev/null | awk '{print $1}' | head -1)
if [ -z "$IP" ]; then
    IP=$(nslookup "$DOMAIN" 2>/dev/null | awk '/^Address: / {print $2}' | head -1)
fi

if [ -z "$IP" ]; then
    echo -e "\033[1;31m[!] Domaine introuvable\033[0m"
    read -p "Entrée..."; exit 0
fi
echo -e "\033[1;32m[+] IP : $IP\033[0m"

echo ""
echo "[*] headers HTTP..."
curl -sI "https://$DOMAIN" 2>/dev/null | head -20

echo ""
echo "[*] techno détectée (headers + body)..."

BODY=$(curl -sL "https://$DOMAIN" 2>/dev/null | head -200)
HEADERS=$(curl -sI "https://$DOMAIN" 2>/dev/null)

detect() {
    local pattern="$1"
    local name="$2"
    if echo "$HEADERS $BODY" | grep -qi "$pattern"; then
        echo -e "  \033[1;32m[+]\033[0m $name"
    fi
}

detect "wp-content\|wordpress" "WordPress"
detect "react\|__REACT" "React"
detect "next.js\|_next/" "Next.js"
detect "vue.js\|__vue__" "Vue.js"
detect "angular" "Angular"
detect "jquery" "jQuery"
detect "bootstrap" "Bootstrap"
detect "cloudflare" "Cloudflare"
detect "nginx" "Nginx"
detect "apache" "Apache"
detect "php" "PHP"
detect "shopify" "Shopify"
detect "woocommerce" "WooCommerce"
detect "google-analytics" "Google Analytics"
detect "facebook\|fbq" "Facebook Pixel"

echo ""
echo "[*] ports communs ouverts (via curl rapide)..."
for PORT in 21 22 23 25 53 80 110 143 443 445 3306 3389 5432 8080; do
    timeout 2 bash -c "echo > /dev/tcp/$DOMAIN/$PORT" 2>/dev/null && \
        echo -e "  \033[1;32m[+]\033[0m port $PORT ouvert"
done

echo ""
echo "[*] scan terminé."
read -p "Entrée pour revenir au menu..."

