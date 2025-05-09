# Kali Recon Automation Tool 🔍

A one-command recon tool using **built-in Kali Linux tools** (no installations needed). Perfect for:
- Quick network scans (`nmap`, `nikto`)
- OSINT harvesting (`theHarvester`, `dnsrecon`)
- Automated reporting

## 🚀 Get Started in 10 Seconds

### 1. Clone the Repository
```bash
git clone https://github.com/YOUR_USERNAME/kali-auto-recon.git
cd kali-auto-recon

./recon.sh

nano config/target_list.txt  # Replace 'example.com' with your target

✨ Features
Option	       Command	    Output Location
Quick Scan	 nmap + nikto	results/scans/
OSINT Mode	 theHarvester	results/osint/
DNS Recon	   dnsrecon	    results/reports/

🌟 Pro Tips
Run in GitHub Codespaces: No setup needed—just clone and execute!

Local Kali Linux? Works out-of-the-box.

First scan? Try the pre-loaded example.com target.

⚠️ Legal Notice
Only scan targets you own or have permission to test.



