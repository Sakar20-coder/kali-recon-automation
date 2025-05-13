#!/bin/bash
echo -e "${YELLOW}[*] Starting Nmap scan...${NC}"
echo -n "Enter target IP/host: "
read target
nmap -sV -T4 -oA -n -Pn -o results/scans/nmap_scan $target
echo -e "${GREEN}[+] Scan saved to results/scans/${NC}"
