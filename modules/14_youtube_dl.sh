#!/data/data/com.termux/files/usr/bin/bash
# language: Bash, file: modules/14_youtube_dl.sh
# Wrapper yt-dlp — télécharge vidéos/audio YouTube et 1000+ sites

clear
echo -e "\033[1;36m=== YOUTUBE DL ===\033[0m"
echo ""
echo "  Formats disponibles :"
echo "  1) Vidéo MP4 (meilleure qualité)"
echo "  2) Vidéo MP4 720p"
echo "  3) Audio MP3"
echo "  4) Audio M4A (meilleure qualité)"
echo ""
read -p "Choix > " FORMAT

read -p "URL (YouTube, Insta, TikTok, Twitter, etc.) > " URL

[ -z "$URL" ] && { echo "[!] URL vide"; read -p "Entrée..."; exit 0; }

# installe yt-dlp si absent
which yt-dlp > /dev/null 2>&1 || {
    echo "[*] installation de yt-dlp..."
    pip install -U yt-dlp
}

# dossier de sortie
OUTDIR="$HOME/storage/downloads/yt"
mkdir -p "$OUTDIR"

cd "$OUTDIR" || exit 1

echo ""
echo "[*] téléchargement en cours..."

case $FORMAT in
    1)
        yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" \
            --merge-output-format mp4 \
            "$URL"
        ;;
    2)
        yt-dlp -f "bestvideo[height<=720][ext=mp4]+bestaudio[ext=m4a]/best[height<=720][ext=mp4]/best" \
            --merge-output-format mp4 \
            "$URL"
        ;;
    3)
        yt-dlp -x --audio-format mp3 --audio-quality 0 "$URL"
        ;;
    4)
        yt-dlp -f "bestaudio[ext=m4a]/bestaudio" "$URL"
        ;;
    *)
        echo "[!] Choix invalide"
        read -p "Entrée..."; exit 0
        ;;
esac

echo ""
echo -e "\033[1;32m[+] Téléchargement terminé\033[0m"
echo "  Fichiers dans : $OUTDIR"
ls -lh "$OUTDIR" | tail -5

echo ""
read -p "Entrée pour revenir au menu..."
