# Detection Engineering

This project includes multiple advanced DNS analytics:

## 1. DNS Tunneling Detection
index=dns sourcetype=dns:log
| where len(domain) > 50
| stats count by src_ip domain

<img width="967" height="586" alt="image28" src="https://github.com/user-attachments/assets/349ae4ee-86fb-4c66-a3f2-60c7b1e7da01" />

      **This result shows a list of DNS queries where the domain length is unusually long more than 50 characters ** 

## 2. NXDOMAIN Spike Detection


index=dns sourcetype=dns:log response_code="NXDOMAIN"
| timechart span=1h count by src_ip

<img width="989" height="556" alt="image35" src="https://github.com/user-attachments/assets/1ac759fe-dfff-4717-b4ef-58fce0e2a769" />

      **Identify hosts with frequent failed lookups — signs of DGA, misconfiguration, or beaconing**


## 3. Suspicious TLD Detection/Malware Callback Detection


     **index=dns sourcetype=dns:log
| search domain=".xyz" OR domain=".top" OR domain="*.cn"**

<img width="960" height="422" alt="image17" src="https://github.com/user-attachments/assets/3bf6c0b1-2c62-4184-85be-fe8e2bcd9ff0" />

     **Splunk returned no matching events, meaning there were no DNS queries to these suspicious TLDs in the dataset**






## 4. Beaconing Detection (>5000 queries)


index=dns sourcetype=dns:log
| stats count by domain
| where count > 5000

<img width="958" height="440" alt="image8" src="https://github.com/user-attachments/assets/51f0e7a3-b11b-4754-a555-0afb9498e43a" />

    ** Splunk search for high-frequency DNS queries—no domains exceeded the 5,000 query threshold, indicating no abnormal or beaconing activity detected during the selected period**

## 5. DNS Query Volume Baseline


index=dns sourcetype=dns:log
| timechart count
