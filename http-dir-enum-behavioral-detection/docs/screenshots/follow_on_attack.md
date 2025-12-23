### Follow-On Attack Analysis – Reconnaissance to Authentication Attempts

This analysis correlates directory enumeration activity (HEAD and GET requests resulting in 404 responses) with authentication attempts (POST requests targeting login endpoints).  
The results support **attack-chain analysis**, demonstrating how reconnaissance behavior can progress toward **initial access attempts**.

index=http sourcetype=HTTP_Threat_Detection
| rex field=_raw "^(?<ts>\S+)\s+(?<uid>\S+)\s+(?<clientip>\d{1,3}(?:\.\d{1,3}){3})\s+\S+\s+\S+\s+\S+\s+\S+\s+(?<http_method>\S+)\s+\S+\s+(?<uri>\S+)\s+\S+\s+\S+\s+\S+\s+\S+\s+(?<status>\d{3})"
| eval attack_phase = case(
    http_method="HEAD" AND status=404, "Reconnaissance",
    http_method="GET" AND status=404, "Enumeration",
    http_method="POST" AND like(uri, "/login%"), "Authentication Attempt",
    true(), "Other"
)
| stats count as request_count by clientip attack_phase uri status
| where attack_phase!="Other"
| sort - request_count

follow_on_attack_recon_to_authentication.

<img width="1016" height="644" alt="image3" src="https://github.com/user-attachments/assets/d8c01607-a13e-4611-bc36-daf6da91804b" />

<img width="1016" height="644" alt="image13" src="https://github.com/user-attachments/assets/d03ab816-2845-4836-9ac0-879f7f53712f" />

<img width="238" height="534" alt="image5" src="https://github.com/user-attachments/assets/96a412bc-0e2e-41a1-968a-f41c0054d61f" />

<img width="1016" height="644" alt="image15" src="https://github.com/user-attachments/assets/168f23ca-033a-4bb0-85c6-f4924a6e0d0f" />


<img width="1007" height="356" alt="image9" src="https://github.com/user-attachments/assets/f463bf21-447d-4016-9058-154003142c89" />




