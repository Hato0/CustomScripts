# CustomScripts
Multiple single scripts

One project, here for development and single script usage. Will be merge into a new repo once done and fully opérationnal

## Recon Bounty Project (sumup)
Will only go for passiv recon as much as possible for the v1
V2 will contain more active recon
## Available functions
### Whois Information
Script available at : whoisMod.py
This script is devided in two mode :
* Get whois data for multiple domains
* Check the availability of a domain with different TLD (usefull for phishing setup)
### Subdomains
Script available at : crtMod.py
This script allow you to search for the following information:
* Retrieve subdomains for a given domain (using certificate database)
* Retrieve certificates issuer to establish potential non compliant subdomains websites
Second method will be available in v2.
### Dir info
Will be available in the v2
### S3 Buckets
Will be available in the v2
### social accounts
Script available at : socialsMod.py
This script allow you to retrieve open source information for a given company using LinkedIn.
You will need a LinkedIn cookie to use it. 
### API Endpoints
### emails
### Vhosts
### Backend IP address
### Open Ports / Services running
### Service version info (if applicable)
### server banners
### directory listings
Script available at : linkMod.sh
This script can extract every link available on a given website (local and remote).
This will help you to indentify potential connections to external services and identify potential file of interest.
### presence security headers
### WAF (+ WAF type)

#### Reference

Automations done using the following [link](https://infosecwriteups.com/guide-to-basic-recon-bug-bounties-recon-728c5242a115). 
This script has been build to automate the recon phase as much as possible during your BB operations. 


# Requiments 
## Apt package
jq
## Platform
Should be compatible with Mac/Linux
