#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Auto-create directories (critical fix)
mkdir -p results/scans results/reports results/osint

# Menu system
while true; do
    clear
    echo -e "${BLUE}Kali Recon Automation Tool${NC}"
    echo -e "${GREEN}=========================${NC}"
    echo "1. Network Scan (nmap)"
    echo "2. DNS Enumeration"
    echo "3. Web Scan"
    echo "4. OSINT"
    echo "5. Exit"
    echo -n "Select option: "
    read choice

    case $choice in
        1)
            echo -e "${YELLOW}[*] Starting Nmap scan...${NC}"
            echo -n "Enter target IP/host: "
            read target
            nmap -sV -T4 -oN "results/scans/nmap_$target.txt" "$target"
            echo -e "${GREEN}[+] Scan saved to results/scans/nmap_$target.txt${NC}"
            read -p "Press [Enter] to continue..."
            ;;
        2)
            ./modules/dns_enum.sh
            ;;
        3)
            ./modules/web_scan.sh
            ;;
        4)
            ./modules/osint.sh
            ;;
        5)
            exit 0
            ;;
        *)
            echo -e "${RED}[!] Invalid option${NC}"
            sleep 1
            ;;
    esac
done
