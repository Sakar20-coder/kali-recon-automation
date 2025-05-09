#!/bin/bash
echo -e "${YELLOW}[*] Scanning web app...${NC}"
echo -n "Enter URL (e.g., http://example.com): "
read url
nikto -h $url -o results/reports/nikto_scan.html
echo -e "${GREEN}[+] Nikto report saved to results/reports/${NC}"