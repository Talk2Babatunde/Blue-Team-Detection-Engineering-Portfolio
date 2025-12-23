### SOC Triage Summary – Pre-Exploitation Classification

This triage assessment evaluates request volume, URI diversity, HTTP methods, and HTTP response codes to determine incident severity.  
The activity was classified as **pre-exploitation**, indicating confirmed reconnaissance and authentication abuse with **no evidence of successful exploitation**.

index=http sourcetype=HTTP_Threat_Detection
| rex field=_raw "^(?<ts>\S+)\s+(?<uid>\S+)\s+(?<clientip>\d{1,3}(?:\.\d{1,3}){3})\s+\S+\s+\S+\s+\S+\s+\S+\s+(?<http_method>\S+)\s+\S+\s+(?<uri>\S+)\s+\S+\s+\S+\s+\S+\s+\S+\s+(?<status>\d{3})"
| stats 
    count as total_requests, 
    dc(uri) as unique_uris, 
    values(http_method) as methods, 
    values(status) as status_codes 
    by clientip
| eval high_request_volume = if(total_requests > 100, "Yes", "No")
| eval high_unique_uris = if(unique_uris > 20, "Yes", "No")
| eval recon_behavior = if(match(methods, "HEAD"), "Yes", "No")
| eval auth_attempts = if(match(methods, "POST"), "Yes", "No")
| eval triage_decision = case(
    recon_behavior="Yes" AND auth_attempts="Yes", "⚠️ Pre-Exploitation Activity",
    recon_behavior="Yes", "🟡 Reconnaissance Only",
    auth_attempts="Yes", "🟠 Authentication Abuse",
    true(), "Normal"
)
| table clientip total_requests unique_uris methods status_codes triage_decision
| sort - total_requests

<img width="1016" height="644" alt="image14" src="https://github.com/user-attachments/assets/49246715-6569-42f5-b3ba-9e6283903220" />


<img width="1016" height="644" alt="image2" src="https://github.com/user-attachments/assets/a5529caf-7eb8-40c2-850a-be2e508305be" />

<img width="1016" height="644" alt="image16" src="https://github.com/user-attachments/assets/fe6eebb2-8a61-4c14-bab2-33abb5e6600b" />


<img width="1016" height="644" alt="image10" src="https://github.com/user-attachments/assets/afc567b8-58c2-48e8-a585-933a4deceb0f" />


<img width="1009" height="357" alt="image4" src="https://github.com/user-attachments/assets/c46c146b-fa15-4e61-9589-249ce4bb4f6b" />


