#!/data/data/com.termux/files/usr/bin/bash
R='\033[1;31m'
N='\033[0m'

banner() {
    clear
    echo -e "${R}"
    cat << 'EOF'
  ██████╗ ██╗     ██╗   ██╗███████╗███████╗ ██████╗ ██╗  ██╗
  ██╔══██╗██║     ██║   ██║██╔════╝██╔════╝██╔═══██╗╚██╗██╔╝
  ██████╔╝██║     ██║   ██║█████╗  █████╗  ██║   ██║ ╚███╔╝
  ██╔══██╗██║     ██║   ██║██╔══╝  ██╔══╝  ██║   ██║ ██╔██╗
  ██████╔╝███████╗╚██████╔╝███████╗██║     ╚██████╔╝██╔╝ ██╗
  ╚═════╝ ╚══════╝ ╚═════╝ ╚══════╝╚═╝      ╚═════╝ ╚═╝  ╚═╝
EOF
    echo -e "${N}"
    echo ""
}

menu() {
    echo -e "${R}┌─────────────────────────────────────────────────────────────────────────┐${N}"
    echo -e "${R}│${N}  BlueFox Tool  |  v1.0  |  [0] > Dr.Stone      [ - ] [ □ ] [ X ]  ${R}│${N}"
    echo -e "${R}├─────────────────────────────────────────────────────────────────────────┤${N}"
    echo -e "${R}│${N}                                                                         ${R}│${N}"
    echo -e "${R}│${N}  [01] > IP Lookup          [08] > Site Scanner                         ${R}│${N}"
    echo -e "${R}│${N}  [02] > Webhook Spam       [09] > Webhook Info                         ${R}│${N}"
    echo -e "${R}│${N}  [03] > Token Info         [10] > Token Raid                           ${R}│${N}"
    echo -e "${R}│${N}  [04] > Nitro Generator    [11] > Obfuscator                           ${R}│${N}"
    echo -e "${R}│${N}  [05] > Token Checker      [12] > Text to Image                        ${R}│${N}"
    echo -e "${R}│${N}  [06] > Roblox ID          [13] > Image to ASCII                       ${R}│${N}"
    echo -e "${R}│${N}  [07] > Phone Lookup       [14] > Youtube DL                           ${R}│${N}"
    echo -e "${R}│${N}  [15] > BluePhisher                                                    ${R}│${N}"
    echo -e "${R}│${N}                                                                         ${R}│${N}"
    echo -e "${R}└─────────────────────────────────────────────────────────────────────────┘${N}"
    echo ""
}

run_mod() {
    local f="$HOME/BlueFoxTool/modules/$1"
    if [ -f "$f" ]; then
        bash "$f"
    else
        echo -e "${R}[!] Module introuvable : $1${N}"
        read -p "Entrée pour continuer..."
    fi
}

while true; do
    banner
    menu
    echo -ne "${R}Choice >> ${N}"
    read choice
    case $choice in
        1|01)   run_mod "01_ip_lookup.sh" ;;
        2|02)   run_mod "02_webhook_spam.sh" ;;
        3|03)   run_mod "03_token_info.sh" ;;
        4|04)   run_mod "04_nitro_gen.sh" ;;
        5|05)   run_mod "05_token_checker.sh" ;;
        6|06)   run_mod "06_roblox_id.sh" ;;
        7|07)   run_mod "07_phone_lookup.sh" ;;
        8|08)   run_mod "08_site_scanner.sh" ;;
        9|09)   run_mod "09_webhook_info.sh" ;;
        10)     run_mod "10_token_raid.sh" ;;
        11)     run_mod "11_obfuscator.sh" ;;
        12)     run_mod "12_text_to_image.sh" ;;
        13)     run_mod "13_image_to_ascii.sh" ;;
        14)     run_mod "14_youtube_dl.sh" ;;
        15)     run_mod "bluephisher.sh" ;;
        0|q|exit) echo -e "${R} bye.${N}"; exit 0 ;;
        *)      echo -e "${R}[!] Choix invalide${N}"; sleep 1 ;;
    esac
done
