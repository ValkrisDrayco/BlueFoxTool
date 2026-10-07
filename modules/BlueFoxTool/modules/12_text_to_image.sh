#!/data/data/com.termux/files/usr/bin/bash
# language: Bash, file: modules/12_text_to_image.sh
# Texte → image PNG — utilise ImageMagick (convert)

clear
echo -e "\033[1;36m=== TEXT TO IMAGE ===\033[0m"
echo ""
echo "  Utile pour : logs de tokens, mots de passe, notes sensibles"
echo "  → transforme en image, plus discret qu'un fichier texte."
echo ""
read -p "Texte à convertir > " TEXT

[ -z "$TEXT" ] && { echo "[!] vide"; read -p "Entrée..."; exit 0; }

read -p "Nom du fichier de sortie (defaut: out.png) > " OUT
OUT=${OUT:-out.png}

read -p "Couleur du texte (blanc/noir/rouge/cyan, defaut: blanc) > " COLOR
COLOR=${COLOR:-white}

read -p "Fond (noir/transparent/blanc, defaut: noir) > " BG
BG=${BG:-black}

read -p "Taille police (defaut: 30) > " SIZE
SIZE=${SIZE:-30}

# installe imagemagick si absent
which convert > /dev/null 2>&1 || {
    echo "[*] installation de imagemagick..."
    pkg install imagemagick -y
}

# dossier de sortie
OUTDIR="$HOME/storage/downloads"
mkdir -p "$OUTDIR"
OUTPATH="$OUTDIR/$OUT"

echo ""
echo "[*] génération de l'image..."

convert -size 1200x400 xc:"$BG" \
    -fill "$COLOR" -pointsize "$SIZE" -gravity center \
    -annotate +0+0 "$TEXT" \
    "$OUTPATH"

if [ -f "$OUTPATH" ]; then
    echo -e "\033[1;32m[+] Image créée : $OUTPATH\033[0m"
    echo ""
    read -p "Afficher l'aperçu ASCII ? (y/n) > " PREVIEW
    if [ "$PREVIEW" = "y" ]; then
        which chafa > /dev/null 2>&1 || pkg install chafa -y
        chafa --size 60x "$OUTPATH"
    fi
else
    echo -e "\033[1;31m[!] Échec de génération\033[0m"
fi

echo ""
read -p "Entrée pour revenir au menu..."
