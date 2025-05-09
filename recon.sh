#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Menu
echo -e "${GREEN}\nKali Recon Automation Tool${NC}"
echo "1. Network Scan (nmap)"
echo "2. DNS Enumeration"
echo "3. Web Scan"
echo "4. OSINT"
echo -n "Select option: "
read choice

case $choice in
  1) ./modules/network_scan.sh ;;
  2) ./modules/dns_enum.sh ;;
  3) ./modules/web_scan.sh ;;
  4) ./modules/osint.sh ;;
  *) echo -e "${RED}Invalid option${NC}" ;;
esac
