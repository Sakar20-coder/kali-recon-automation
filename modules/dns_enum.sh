#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Auto-create dirs
mkdir -p results/reports/dns

# Check if tools exist
command -v host >/dev/null 2>&1 || { echo -e "${RED}[!] 'host' command not found. Install bind-utils/dnsutils.${NC}"; exit 1; }
command -v dnsrecon >/dev/null 2>&1 || { echo -e "${RED}[!] dnsrecon not found. Install with 'sudo apt install dnsrecon'.${NC}"; exit 1; }

# Get target
echo -e "${YELLOW}[*] Starting DNS Enumeration${NC}"
echo -n "Enter domain (e.g., example.com): "
read domain

# Validate input
if [[ -z "$domain" ]]; then
  echo -e "${RED}[!] No domain specified${NC}"
  exit 1
fi

# Run tools
echo -e "\n${GREEN}[1] Running host...${NC}"
host -t any "$domain" > "results/reports/dns/host_$domain.txt"

echo -e "\n${GREEN}[2] Running dnsrecon...${NC}"
dnsrecon -d "$domain" -t std > "results/reports/dns/dnsrecon_$domain.txt"

echo -e "\n${GREEN}[3] Checking WHOIS...${NC}"
whois "$domain" >> "results/reports/dns/whois_$domain.txt"

# Verify output
if [[ -s "results/reports/dns/host_$domain.txt" ]]; then
  echo -e "\n${YELLOW}[+] Results saved to:${NC}"
  echo -e "- Host records: results/reports/dns/host_$domain.txt"
  echo -e "- DNS recon: results/reports/dns/dnsrecon_$domain.txt"
  echo -e "- WHOIS: results/reports/dns/whois_$domain.txt"
else
  echo -e "${RED}[!] No DNS records found for $domain${NC}"
fi
