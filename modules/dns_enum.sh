#!/bin/bash
echo -e "${YELLOW}[*] Enumerating DNS...${NC}"
echo -n "Enter domain: "
read domain
echo -e "\n=== DNS Records ===" > results/reports/dns_$domain.txt
host -t any $domain >> results/reports/dns_$domain.txt
echo -e "\n=== WHOIS ===" >> results/reports/dns_$domain.txt
whois $domain >> results/reports/dns_$domain.txt
echo -e "${GREEN}[+] Report saved to results/reports/dns_$domain.txt${NC}"