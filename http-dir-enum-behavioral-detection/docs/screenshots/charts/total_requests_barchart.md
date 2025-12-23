#  Data Analysis: Volumetric Outliers
This bar chart identifies the 'Top Talkers' within the dataset. By aggregating total HTTP request counts per clientip, we can visually isolate statistical outliers. A massive spike in volume from a single source—as seen here—is a primary indicator of automated reconnaissance or a potential Denial of Service (DoS) attempt.

## SPL Query:

index=http sourcetype=HTTP_Threat_Detection
| rex field=_raw "^(?<ts>\S+)\s+(?<uid>\S+)\s+(?<clientip>\d{1,3}(?:\.\d{1,3}){3})\s+\S+\s+\S+\s+\S+\s+\S+\s+(?<http_method>\S+)\s+\S+\s+(?<uri>\S+)\s+\S+\s+\S+\s+\S+\s+\S+\s+(?<status>\d{3})"
| stats count as "Total Requests" by clientip
| sort - "Total Requests"
| head 10

<img width="998" height="387" alt="image" src="https://github.com/user-attachments/assets/8a8ba72e-1f3c-4fb2-856f-33376f7daa5a" />

![Total Requests Bar Chart](<img width="998" height="387" alt="image" src="https://github.com/user-attachments/assets/8a8ba72e-1f3c-4fb2-856f-33376f7daa5a" />)
*Figure 1: Identification of Top 10 Source IPs by Request Volume. The leading outlier exhibits a request frequency consistent with automated discovery tools.*


<img width="1003" height="420" alt="image" src="https://github.com/user-attachments/assets/b3d48f8b-8148-45f1-b1f2-318cb5bab7c3" />






