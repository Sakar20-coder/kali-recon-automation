#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Auto-create dirs
mkdir -p results/reports/dns

# Check tools
command -v host >/dev/null 2>&1 || { echo -e "${RED}[!] 'host' command missing. Install with: sudo apt install dnsutils${NC}"; exit 1; }
command -v dnsrecon >/dev/null 2>&1 || { echo -e "${RED}[!] dnsrecon missing. Install with: sudo apt install dnsrecon${NC}"; exit 1; }

# Get target
clear
echo -e "${YELLOW}[*] DNS ENUMERATION MODE${NC}"
echo -n "Enter domain (e.g., example.com): "
read domain

# Validate input
if [[ -z "$domain" ]]; then
  echo -e "${RED}[!] No domain specified${NC}"
  sleep 2
  exit 1
fi

# Run scans
echo -e "\n${GREEN}[1] Running host lookups...${NC}"
host -t any "$domain" > "results/reports/dns/host_$domain.txt"
cat "results/reports/dns/host_$domain.txt"

echo -e "\n${GREEN}[2] Running dnsrecon...${NC}"
dnsrecon -d "$domain" -t std >> "results/reports/dns/dnsrecon_$domain.txt"
tail -n 10 "results/reports/dns/dnsrecon_$domain.txt"

echo -e "\n${GREEN}[3] Checking WHOIS...${NC}"
whois "$domain" >> "results/reports/dns/whois_$domain.txt"
head -n 10 "results/reports/dns/whois_$domain.txt"

# Show summary
echo -e "\n${YELLOW}=== SCAN COMPLETE ==="
echo -e "Results saved to:${NC}"
echo -e "- Host records: results/reports/dns/host_$domain.txt"
echo -e "- Full DNS recon: results/reports/dns/dnsrecon_$domain.txt"
echo -e "- WHOIS data: results/reports/dns/whois_$domain.txt"

# Wait for user
echo -e "\nPress [Enter] to return to main menu..."
read