#!/data/data/com.termux/files/usr/bin/bash
# language: Bash, file: modules/01_ip_lookup.sh
# GeoIP lookup via ip-api.com — gratuit, 45 req/min

clear
echo -e "\033[1;36m=== IP LOOKUP ===\033[0m"
echo ""
read -p "IP ou domaine > " target

[ -z "$target" ] && { echo "[!] vide"; read -p "Entrée..."; exit 0; }

echo ""
echo "[*] requête..."
curl -s "http://ip-api.com/json/$target?fields=status,message,country,regionName,city,zip,lat,lon,timezone,isp,org,as,query" | python -m json.tool

echo ""
read -p "Entrée pour revenir au menu..."

