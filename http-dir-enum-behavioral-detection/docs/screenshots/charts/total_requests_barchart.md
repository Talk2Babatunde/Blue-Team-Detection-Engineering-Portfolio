### 📊 Data Analysis: Volumetric Outliers
![Total Requests Bar Chart](./docs/screenshots/total_requests_barchart.png)
*Figure 1: Identification of Top 10 Source IPs by Request Volume. The leading outlier exhibits a request frequency consistent with automated discovery tools.*

index=http sourcetype=HTTP_Threat_Detection
| rex field=_raw "^(?<ts>\S+)\s+(?<uid>\S+)\s+(?<clientip>\d{1,3}(?:\.\d{1,3}){3})\s+\S+\s+\S+\s+\S+\s+\S+\s+(?<http_method>\S+)\s+\S+\s+(?<uri>\S+)\s+\S+\s+\S+\s+\S+\s+\S+\s+(?<status>\d{3})"
| stats count as "Total Requests" by clientip
| sort - "Total Requests"
| head 10

<img width="998" height="387" alt="image" src="https://github.com/user-attachments/assets/8a8ba72e-1f3c-4fb2-856f-33376f7daa5a" />

Visualizing the top 10 source IPs to identify high-volume outliers. The extreme disparity between the leading IP and the baseline suggests the use of automated scanning scripts rather than human browsing behavior.

<img width="1003" height="420" alt="image" src="https://github.com/user-attachments/assets/b3d48f8b-8148-45f1-b1f2-318cb5bab7c3" />

