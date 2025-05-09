#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Banner
echo -e "${BLUE}"
echo "   ___  ____  ___ _____  _   _ "
echo "  / _ \/ ___|_ _|_   _|/ \ | |"
echo " | | | \___ \| |  | | / _ \| |"
echo " | |_| |___) | |  | |/ ___ \ |"
echo "  \___/|____/___| |_/_/   \_\_|"
echo -e "${NC}"

# Check if target is provided
if [ -z "$1" ]; then
    echo -e "${RED}[!] Usage: ./osint.sh <domain>${NC}"
    exit 1
fi

DOMAIN=$1
DATE=$(date +"%Y-%m-%d")
OUTPUT_DIR="results/osint/$DOMAIN"
mkdir -p $OUTPUT_DIR

echo -e "${YELLOW}[+] Starting OSINT on $DOMAIN${NC}"

# 1. Email/Subdomain Enumeration (theHarvester)
echo -e "\n${GREEN}[1] Running theHarvester${NC}"
theHarvester -d $DOMAIN -b all -f $OUTPUT_DIR/theHarvester_$DOMAIN.html
echo -e "Results saved to: $OUTPUT_DIR/theHarvester_$DOMAIN.html"

# 2. DNS Recon (dnsrecon)
echo -e "\n${GREEN}[2] Running DNSRecon${NC}"
dnsrecon -d $DOMAIN -t std,axfr -j $OUTPUT_DIR/dnsrecon_$DOMAIN.json
echo -e "Results saved to: $OUTPUT_DIR/dnsrecon_$DOMAIN.json"

# 3. WHOIS Lookup
echo -e "\n${GREEN}[3] Running WHOIS${NC}"
whois $DOMAIN > $OUTPUT_DIR/whois_$DOMAIN.txt
echo -e "Results saved to: $OUTPUT_DIR/whois_$DOMAIN.txt"

# 4. Recon-ng (Lightweight)
echo -e "\n${GREEN}[4] Running Recon-ng${NC}"
recon-ng -r $OUTPUT_DIR/recon-ng_$DOMAIN.results -m "recon/domains-hosts/google_site_web" -c "set SOURCE $DOMAIN" -x
echo -e "Results saved to: $OUTPUT_DIR/recon-ng_$DOMAIN.results"

# 5. Metadata Extraction (metagoofil)
echo -e "\n${GREEN}[5] Searching for Public Documents${NC}"
metagoofil -d $DOMAIN -t pdf,doc,xls -l 5 -n 5 -o $OUTPUT_DIR/metadata_$DOMAIN -f $OUTPUT_DIR/metadata_$DOMAIN.html
echo -e "Results saved to: $OUTPUT_DIR/metadata_$DOMAIN/"

# 6. Maltego (Manual Launch)
echo -e "\n${YELLOW}[!] For graphical OSINT, run manually:${NC}"
echo "maltego '$DOMAIN'"

# Compress results
zip -r $OUTPUT_DIR/osint_$DOMAIN.zip $OUTPUT_DIR/* > /dev/null

echo -e "\n${GREEN}[+] OSINT completed! All results saved to: $OUTPUT_DIR/${NC}"