# High-Fidelity Detection

This visualization identifies Directory Enumeration by calculating the Distinct Count (dc) of URIs per source IP. While a legitimate user typically accesses a limited set of pages, an attacker utilizing a wordlist (e.g., DirBuster) will attempt to access thousands of unique paths in a short window. This statistical disparity is a high-fidelity indicator used to distinguish automated scanners from human traffic.

## SPL Query
index=http sourcetype=HTTP_Threat_Detection
| rex field=_raw "^(?<ts>\S+)\s+(?<uid>\S+)\s+(?<clientip>\d{1,3}(?:\.\d{1,3}){3})\s+\S+\s+\S+\s+\S+\s+\S+\s+(?<http_method>\S+)\s+\S+\s+(?<uri>\S+)\s+\S+\s+\S+\s+\S+\s+\S+\s+(?<status>\d{3})"
| stats dc(uri) as "Unique URIs Accessed" by clientip
| sort - "Unique URIs Accessed"
| head 10

<img width="1000" height="389" alt="image" src="https://github.com/user-attachments/assets/90026064-499d-4b59-a4cc-b1990efed75b" />


### 🔍 Detection Deep-Dive: URI Diversity
![Unique URIs Column Chart](<img width="1000" height="389" alt="image" src="https://github.com/user-attachments/assets/939ccd18-7ae2-4b2d-94d2-199fa7c5ae0e" />
)
*Figure 2: Statistical identification of Directory Enumeration. The outlier IP shows a unique URI count 500% higher than the baseline average.*

<img width="998" height="385" alt="image" src="https://github.com/user-attachments/assets/d7cc9fd3-202a-4653-883e-cf426f17ecc8" />

