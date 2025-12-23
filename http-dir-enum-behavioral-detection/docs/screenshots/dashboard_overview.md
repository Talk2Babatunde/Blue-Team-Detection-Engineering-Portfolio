##HTTP Threat Dashboard – High-Risk Source IP Overview
This view summarizes HTTP traffic by source IP, highlighting abnormal request volume, high unique URI counts, and suspicious HTTP methods. It allows SOC analysts to quickly identify potential reconnaissance activity and prioritize investigation based on behavioral indicators.

index=http sourcetype=HTTP_Threat_Detection
| rex field=_raw "^(?<ts>\S+)\s+(?<uid>\S+)\s+(?<clientip>\d{1,3}(?:\.\d{1,3}){3})\s+\S+\s+\S+\s+\S+\s+\S+\s+(?<http_method>\S+)\s+\S+\s+(?<uri>\S+)\s+\S+\s+\S+\s+\S+\s+\S+\s+(?<status>\d{3})"
| stats 
    count as total_requests,
    dc(uri) as unique_uris,
    values(http_method) as methods,
    values(status) as status_codes
    by clientip
| where total_requests > 50
| sort - total_requests
<img width="1016" height="644" alt="image8" src="https://github.com/user-attachments/assets/49e20796-0e75-4a1c-b700-5b9948bcfd5c" />

<img width="1016" height="644" alt="image11" src="https://github.com/user-attachments/assets/a29cc9a2-3209-4270-a4e0-49342abfcbd3" />

<img width="1010" height="351" alt="image17" src="https://github.com/user-attachments/assets/d04056e7-f308-4e3f-925b-57896f4e8871" />

