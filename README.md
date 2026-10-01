# BlueFox Toolkit

Menu interactif pour Termux — outils OSINT, Discord, et utilitaires.

## Installation

\`\`\`bash
pkg install curl python jq imagemagick chafa -y
pip install requests phonenumbers yt-dlp
git clone https://github.com/ValkrisDrayco/BlueFoxTool.git
cd BlueFoxTool
chmod +x bluefox.sh modules/*.sh
\`\`\`

## Utilisation

\`\`\`bash
bash bluefox.sh
\`\`\`

Ou avec l'alias :
\`\`\`bash
echo 'alias bluefox="bash ~/BlueFoxTool/bluefox.sh"' >> ~/.bashrc
source ~/.bashrc
bluefox
\`\`\`

## Modules

| # | Nom | Description |
|---|-----|-------------|
| 1 | IP Lookup | Géolocalisation IP/domaine |
| 2 | Webhook Spam | Envoi en boucle sur un webhook Discord |
| 3 | Token Info | Infos d'un token Discord |
| 4 | Nitro Generator | Génère des codes Nitro (format valide, non fonctionnels) |
| 5 | Token Grabber | Launcher du logger Discord |
| 6 | Roblox ID | Infos d'un compte Roblox |
| 7 | Phone Lookup | Infos d'un numéro de téléphone |
| 8 | Site Scanner | Headers + techno + ports |
| 9 | Webhook Info | Infos d'un webhook Discord |
| 10 | Token Raid | Actions en masse via token (test uniquement) |
| 11 | Obfuscator | Obfuscation Python |
| 12 | Text to Image | Texte → PNG |
| 13 | Image to ASCII | Image → art ASCII |
| 14 | Youtube DL | Téléchargement vidéo/audio |

## Support

Rejoins le serveur Discord BlueFox : https://discord.gg/BkrwVbBWYX

[![Discord](https://img.shields.io/badge/Discord-Rejoindre-5865F2?logo=discord&logoColor=white)](https://discord.gg/BkrwVbBWYX)

## Disclaimer

Usage éducatif et personnel uniquement. N'utilisez ces outils que sur des cibles autorisées.

## License

MIT
