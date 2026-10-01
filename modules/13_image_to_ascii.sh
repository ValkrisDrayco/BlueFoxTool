#!/data/data/com.termux/files/usr/bin/bash
# language: Bash, file: modules/13_image_to_ascii.sh
# Image → ASCII art — utilise chafa (meilleur rendu que jp2a)

clear
echo -e "\033[1;36m=== IMAGE TO ASCII ===\033[0m"
echo ""
echo "  Chemins possibles :"
echo "  ~/storage/pictures/ton_image.jpg"
echo "  /sdcard/Pictures/ton_image.jpg"
echo "  (donne termux-setup-storage si pas accès)"
echo ""
read -p "Chemin image > " IMG

[ -z "$IMG" ] && { echo "[!] vide"; read -p "Entrée..."; exit 0; }

# expand ~ et vérifie existence
IMG=$(eval echo "$IMG")
if [ ! -f "$IMG" ]; then
    echo -e "\033[1;31m[!] Fichier introuvable : $IMG\033[0m"
    read -p "Entrée..."; exit 0
fi

# installe chafa si absent
which chafa > /dev/null 2>&1 || {
    echo "[*] installation de chafa..."
    pkg install chafa -y
}

echo ""
read -p "Largeur en caractères (defaut 80) > " W
W=${W:-80}

read -p "Couleur ? (y/n, defaut y) > " C
C=${C:-y}

echo ""
echo "[*] rendu en cours..."
echo ""

if [ "$C" = "y" ]; then
    chafa --size "${W}x" "$IMG"
else
    chafa --size "${W}x" --colors 2 "$IMG"
fi

echo ""
read -p "Entrée pour revenir au menu..."
