#!/data/data/com.termux/files/usr/bin/bash
# language: Bash, file: modules/07_phone_lookup.sh
# Phone lookup via numverify-like gratuit (parse manuel + libphonenumber)

clear
echo -e "\033[1;36m=== PHONE LOOKUP ===\033[0m"
echo ""
echo "  Tape un numéro avec indicatif pays."
echo "  Ex : +33612345678  ou  +15145551234"
echo ""
read -p "Numéro > " NUM

[ -z "$NUM" ] && { echo "[!] vide"; read -p "Entrée..."; exit 0; }

# retire les espaces, tirets, parenthèses
CLEAN=$(echo "$NUM" | tr -d ' -().')

echo ""
echo "[*] analyse de $CLEAN..."

# utilise libphonenumber de Google via Python (plus fiable que les API payantes)
pip show phonenumbers > /dev/null 2>&1 || pip install phonenumbers > /dev/null 2>&1

python - "$CLEAN" << 'EOF'
import sys
import phonenumbers
from phonenumbers import geocoder, carrier, timezone, number_type, PhoneNumberType

num = sys.argv[1]

try:
    parsed = phonenumbers.parse(num, None)
except Exception as e:
    print(f"[!] Impossible de parser : {e}")
    sys.exit(1)

if not phonenumbers.is_valid_number(parsed):
    print("[!] Numéro invalide")
    sys.exit(1)

types = {
    PhoneNumberType.MOBILE: "Mobile",
    PhoneNumberType.FIXED_LINE: "Fixe",
    PhoneNumberType.FIXED_LINE_OR_MOBILE: "Fixe ou mobile",
    PhoneNumberType.TOLL_FREE: "Numéro gratuit",
    PhoneNumberType.PREMIUM_RATE: "Numéro surtaxé",
    PhoneNumberType.VOIP: "VoIP",
    PhoneNumberType.PERSONAL_NUMBER: "Personnel",
    PhoneNumberType.PAGER: "Pager",
    PhoneNumberType.UAN: "UAN",
    PhoneNumberType.VOICEMAIL: "Messagerie vocale",
    PhoneNumberType.UNKNOWN: "Inconnu",
}

print()
print("\033[1;32m=== INFOS NUMÉRO ===\033[0m")
print(f"  Format international : {phonenumbers.format_number(parsed, phonenumbers.PhoneNumberFormat.INTERNATIONAL)}")
print(f"  Format E.164         : {phonenumbers.format_number(parsed, phonenumbers.PhoneNumberFormat.E164)}")
print(f"  Indicatif pays       : +{parsed.country_code}")
print(f"  Numéro national      : {parsed.national_number}")
print(f"  Pays                 : {geocoder.description_for_number(parsed, 'fr') or geocoder.description_for_number(parsed, 'en')}")
print(f"  Région               : {geocoder.description_for_number(parsed, 'en')}")
print(f"  Opérateur            : {carrier.name_for_number(parsed, 'en') or 'inconnu'}")
print(f"  Type de ligne        : {types.get(number_type(parsed), 'inconnu')}")
print(f"  Fuseaux horaires     : {', '.join(timezone.time_zones_for_number(parsed))}")
EOF

echo ""
read -p "Entrée pour revenir au menu..."
