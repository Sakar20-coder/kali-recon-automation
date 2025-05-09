#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Auto-create dirs
mkdir -p results/osint

# Check for tools
command -v theHarvester >/dev/null 2>&1 || {
    echo -e "${RED}[!] theHarvester not found! Install with:${NC}"
    echo "sudo apt install theharvester"
    exit 1
}

# Clear screen and show header
clear
echo -e "${BLUE}"
echo "   ___  ____  ___ _____  _   _ "
echo "  / _ \/ ___|_ _|_   _|/ \ | |"
echo " | | | \___ \| |  | | / _ \| |"
echo " | |_| |___) | |  | |/ ___ \ |"
echo "  \___/|____/___| |_/_/   \_\_|"
echo -e "${NC}"
echo -e "${YELLOW}=== OSINT HARVESTING MODE ===${NC}"

# Get target
echo -n "Enter domain (e.g., example.com): "
read domain

if [[ -z "$domain" ]]; then
    echo -e "${RED}[!] No domain specified${NC}"
    sleep 2
    exit 1
fi

# Run tools
echo -e "\n${GREEN}[1] Running theHarvester (this may take 2-3 minutes)...${NC}"
theHarvester -d "$domain" -b google,linkedin -f "results/osint/harvest_$domain.html" > /dev/null
echo -e "${GREEN}✓ Harvest complete${NC}"

echo -e "\n${GREEN}[2] Running WHOIS lookup...${NC}"
whois "$domain" > "results/osint/whois_$domain.txt"
head -n 15 "results/osint/whois_$domain.txt"

# Show results
echo -e "\n${YELLOW}=== RESULTS ===${NC}"
echo -e "HTML report: results/osint/harvest_$domain.html"
echo -e "WHOIS data: results/osint/whois_$domain.txt"

# Keep window open
echo -e "\n${BLUE}Press [Enter] to return to main menu...${NC}"
read
