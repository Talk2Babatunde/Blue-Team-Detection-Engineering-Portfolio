Overview
This folder contains lookup files used in Splunk searches for HTTP and DNS threat detection. These lookup files enrich raw log events with threat intelligence, reputation data, and contextual metadata, enabling analysts to quickly identify high-risk activities and prioritize alerts.
By integrating these lookups with SPL queries and dashboards, we can:
Detect suspicious IPs, domains, and URLs


Identify brute-force login attempts and directory scans


Correlate threat data with client IPs for faster investigation


Support proactive security monitoring in a SOC environment



Folder Structure
lookups/
├── threat_ip_lookup.csv
├── malicious_domains.csv
├── suspicious_user_agents.csv
└── README.md

threat_ip_lookup.csv – Contains IP addresses flagged for malicious activity with associated threat type, severity, and description.


malicious_domains.csv – Lists known malicious domains and categorizes them based on malware, phishing, or C2 communication.


suspicious_user_agents.csv – Includes automated scanner and bot user-agent signatures (e.g., DirBuster, legacy browser impersonations) to detect abnormal web traffic.


Key Columns & Definitions
Column
Description
clientip
Source IP address of the request
threat_type
Type of malicious activity (e.g., DirBuster scan, suspicious login)
severity
Threat level (low, medium, high)
description
Detailed description of the threat or behavior
user_agent
User agent string of suspicious traffic
domain
Malicious domain or URL

These columns are standardized for SPL enrichment using lookup commands, allowing seamless integration into dashboards and alerts
