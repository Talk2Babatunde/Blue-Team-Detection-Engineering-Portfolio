# Detection Engineering

This project includes multiple advanced DNS analytics:

## 1. DNS Tunneling Detection
index=dns sourcetype=dns:log
| where len(domain) > 50
| stats count by src_ip domain


## 2. NXDOMAIN Spike Detection


index=dns sourcetype=dns:log response_code="NXDOMAIN"
| timechart span=1h count by src_ip


## 3. Suspicious TLD Detection


index=dns sourcetype=dns:log
| search domain=".xyz" OR domain=".top" OR domain="*.cn"


## 4. Beaconing Detection (>5000 queries)


index=dns sourcetype=dns:log
| stats count by domain
| where count > 5000


## 5. DNS Query Volume Baseline


index=dns sourcetype=dns:log
| timechart count
