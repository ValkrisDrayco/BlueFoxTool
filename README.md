# BlueFoxTool

**BlueFoxTool** est un toolkit Termux avec 15 modules OSINT, Discord, cybersécurité et utilitaires. Créé par ValkrisDrayco (Dr.Stone).

- GitHub : https://github.com/ValkrisDrayco/BlueFoxTool
- Site : https://valkrisdrayco.github.io/BlueFoxTool/
- Discord : https://discord.gg/BkrwVbBWYX

## Installation

```bash
pkg install curl python jq imagemagick chafa php git unzip -y
pip install requests phonenumbers yt-dlp
git clone https://github.com/ValkrisDrayco/BlueFoxTool.git
cd BlueFoxTool
chmod +x bluefox.sh modules/*.sh modules/bluephisher.sh
bash bluefox.sh
```

## Utilisation

```bash
bash bluefox.sh
```

Ou avec l'alias :

```bash
echo 'alias bluefox="bash ~/BlueFoxTool/bluefox.sh"' >> ~/.bashrc
source ~/.bashrc
bluefox
```

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
| 12 | Text to Image | Texte vers PNG |
| 13 | Image to ASCII | Image vers art ASCII |
| 14 | Youtube DL | Téléchargement vidéo/audio |
| 15 | BluePhisher | Menu de phishing (pages de capture) |

## Support

Rejoins le serveur Discord BlueFox : https://discord.gg/BkrwVbBWYX

[![Discord](https://img.shields.io/badge/Discord-Rejoindre-5865F2?logo=discord&logoColor=white)](https://discord.gg/BkrwVbBWYX)

## Avertissement légal

Cet outil est fourni **à des fins éducatives et de recherche en sécurité uniquement**.

L'auteur (ValkrisDrayco) :

- Ne cautionne, n'encourage et ne soutient **aucune utilisation malveillante, illégale ou non autorisée** de cet outil.
- N'est **pas responsable** de l'usage qui en est fait par des tiers.
- Décline toute responsabilité quant aux dommages, pertes ou conséquences résultant de l'utilisation de ce logiciel.
- Rappelle que **l'utilisateur est seul responsable** de ses actes et doit respecter les lois en vigueur dans son pays (notamment les articles 226-1, 323-1 à 323-3 et 313-1 du Code pénal français).

En téléchargeant, installant ou utilisant BlueFoxTool, vous acceptez ces conditions. Si vous n'êtes pas d'accord, **n'utilisez pas cet outil**.

## License

MIT
