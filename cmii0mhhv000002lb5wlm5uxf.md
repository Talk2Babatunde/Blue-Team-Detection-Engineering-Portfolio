---
title: "Behavioral DNS Threat Detection & Automated Incident Response (Splunk, Slack, Jira)"
datePublished: Thu Nov 27 2025 22:38:52 GMT+0000 (Coordinated Universal Time)
cuid: cmii0mhhv000002lb5wlm5uxf
slug: end-to-end-dns-threat-detection-dashboarding-and-automated-incident-response-using-splunk-slack-and-jira
ogImage: https://cdn.hashnode.com/res/hashnode/image/upload/v1764283105204/93a31d31-9f57-4c91-97eb-cace59b99c00.jpeg
tags: slack, dashboard, splunk, ticketing, jira-automation, threatmonitoring, dns-logs

---

In modern cybersecurity operations, DNS traffic is often an overlooked channel for data exfiltration, malware beaconing, and command-and-control communications and so on.

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1763937620325/f441eba7-997d-4420-8658-e016921e8991.png align="center")

In this project, i demonstrates a complete hands-on workflow for DNS threat detection and incident response, leveraging Splunk Enterprise, Slack, email alerts, and Jira ticketing to simulate a professional SOC environment.

The main purpose of this project is to bridge the gap between raw log data and actionable security intelligence, highlighting how a SOC analyst transforms large-scale DNS logs into real-time, automated detection and response mechanisms which is my core goals on this project.

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1763932083936/854c0d57-ae47-4476-87d5-84276c976388.png align="center")

*Figure 1: Image showing the top 20 most frequently queried domains to help detect suspicious or potentially malicious DNS activity.*

Creating an automated dashboard provides me with real-time visibility into DNS activities across the environment, helping detect unusual domain queries, DNS tunneling behaviors, misconfigurations, NXDOMAIN spikes, and early indicators of compromise which i have extensively analyse and discussed in this article.

You can catch me on [Github](https://github.com/Talk2Babatunde/Blue-Team-Detection-Engineering-Portfolio)  
You can reached me on [Linkedln](http://www.linkedin.com/in/babatunde-qodri-27716b1a5) or [Twitter](https://twitter.com/_BabatundeQodri)

## **End-to-End SOC Workflow Breakdown**

1. **Detection:** DNS logs are ingested into Splunk and analyzed for anomalies, including suspicious TLD queries, NXDOMAIN spikes, large query lengths, and repeated domain flood patterns.
    
2. **Visualization:** A custom DNS Monitoring & Threat Detection Dashboard was built, providing clear, actionable panels that allow analysts to quickly identify and prioritize potential threats.
    
3. **Automation & Response:** Alerts are automatically generated when thresholds are exceeded. These alerts trigger email notifications, Slack messages, and pre-filled Jira tickets, mimicking real-world SOC workflows for rapid incident response.
    
4. **Evidence & Documentation:** All analysis is backed by raw event data, screenshots, and structured reporting, demonstrating attention to detail and evidence-based investigation.
    
5. **Portfolio Impact:** This project is designed to showcase the end-to-end skills expected from a junior SOC analyst, combining log analysis, dashboarding, alerting, and ticketing in a single, cohesive workflow.
    
    ## **Key Highlights & What This Project Demonstrates**
    
    * Real-time DNS monitoring and threat detection at scale
        
    * Interactive dashboards with actionable, analyst-friendly panels
        
    * Automated alerting and incident response via Email, Slack, and Jira
        
    * Evidence-backed analysis supported by raw logs and screenshots
        
    * Demonstrates core SOC analyst skills used in real-world environments
        
    * Ability to monitor DNS traffic at scale and detect anomalies
        
    * Experience building Splunk dashboards for threat hunting
        
    * Translating raw logs into clear, actionable security insights
        
    
    ## **1\. Tools & Technologies**
    
    * **Ubuntu Server** – Host for Splunk Enterprise, log ingestion, and dashboard management
        
    * **Splunk Enterprise** – Log ingestion, dashboards, and alerting
        
    * **Windows VM** – Source of DNS logs and test environment
        
    * **Email Alerts** – Automated notifications to SOC team
        
    * **Slack** – Instant alerting and team collaboration
        
    * **Jira Cloud** – Incident tracking and ticket automation
        

## **2\. Environment Setup**

In preparation for my environment, i set up Splunk components, verify log forwarding, and create indexes for dns logs and others.

**1\. Verify Splunk services**

sudo /opt/splunk/bin/splunk status

You should see: splunkd is running as seen in the screenshot below:

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1763935674269/af844e1a-db24-4f57-a319-a48b83ae5424.png align="center")

**2\. Verify Universal Forwarder connection (Windows VM):**

& "C:\\Program Files\\SplunkUniversalForwarder\\bin\\splunk.exe" list forward-server

Expected output:

Active forwards:

&lt;Splunk\_Server\_IP&gt;:9997  (active)

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1763936015448/0fb8f788-eda1-422d-96b2-2bb6bd102e04.png align="center")

**3\. I create indexes for each log type starting with dns log  
<mark><br></mark>**<mark>sudo /opt/splunk/bin/splunk add index dns</mark>

sudo /opt/splunk/bin/splunk add index ssh

sudo /opt/splunk/bin/splunk add index dhcp

sudo /opt/splunk/bin/splunk add index http

sudo /opt/splunk/bin/splunk add index smtp

sudo /opt/splunk/bin/splunk add index ftp

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1763936430221/ede27fc7-534d-4be4-81b9-c8d4355e4939.png align="center")

*image showing indexes\_created*  
I’ve just created dedicated Splunk indexes for six log types to simulate enterprise SOC workflows. Each index represents a log source, enabling targeted searches, anomaly detection, and cross-log correlation. Let’s go!

*After installing* *Splunk Enterprise, on a Windows VM* *to ingest and analyze DNS logs.*  
**Created a folder for my SplunkData and saved:**  
*Logs stored at: C:\\SplunkData*

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1763936900467/12657dfb-2754-4822-8da9-33ed07d66f4f.png align="center")

***Sample DNS log file: C:\\SplunkData\\dns.log***

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1763936850646/7b112ec0-ea29-4ea6-98e7-979b5912f5e5.png align="center")

*Splunk environment ready with DNS log file extracted*

*This setup ensures I had a controlled environment to practice log ingestion, analysis, and dashboarding.*

## **3\. Creating Custom Indexes (DNS Log Separation)**

To keep DNS logs separate from other log types, I created a dedicated Splunk index, To ensure clean and efficient searches for DNS logs with the following command line::

sudo /opt/splunk/bin/splunk add index dns

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764278116123/783dc4d8-efa6-47fb-b439-3f372ed8d20c.png align="center")

*Custom index “dns” successfully created in Splunk\*\*Segregating DNS logs enables clean searches, faster queries, and focused threat detection.*

# **4\. Uploading DNS Log File to Splunk**

### **Steps:**

1. Go to **Settings → Add Data**
    
2. Choose **Upload**
    
3. Select your file:  
    <mark>Dns.log</mark>
    
4. Set appropriate **sourcetype** (dns:log, ssh:auth, etc.)
    

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1763937689836/162f3081-bd12-4ff7-97af-c67c6556c860.png align="center")

After this, splunk will associate your uploaded DNS logs with the **dns:log** sourcetype, making searches, field extractions, and dashboards easier.

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1763938139790/2920cacb-a64d-4fc0-bc40-65c910e10b3b.png align="center")

5. **Set:**
    

* **Source Type:** dns:log
    
* **Host:** ubuntuserver
    
* **Index:** dns
    

This tells splunk how to interpret and store the file.

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1763938463238/d570edea-ab61-4791-b667-e2ba90a41e05.png align="center")

source="dns.log" host="ubuntuserver" index="dns" sourcetype="dns:log"

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1763938429787/822dddbd-32cd-40f2-a160-c39b7c64b2c5.png align="center")

*DNS log file manually uploaded with sourcetype dns:log.*

*This ensured Splunk correctly interpreted and stored the log fields properly.  I included this step to show how to manually ingest logs.*

## **4\. Initial DNS Log Analysis/ Searching DNS Logs in Splunk**

**Basic Search:**

I created and launched a basic search and the result returned **422,130 events**, confirming successful ingestion.

index=dns sourcetype=dns:log

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1763969126710/50f534f1-e292-49d0-be5d-14557cd30ae1.png align="center")

Screenshot showing raw DNS log ingestion in Splunk, with 422,130 events successfully indexed for analysis.

***Table View for Exploration:***

*index=dns sourcetype=dns:log*

*| table time srcip dest\_ip domain query\_type response\_code*

***Field Explanation:***

* *src\_ip → Client machine making DNS queries*
    
* *dest\_ip → DNS server*
    
* *domain → Domain being queried*
    
* *query\_type → Record type (A, AAAA, PTR, TXT, etc.)*
    
* \*response\_code → SUCCESS / NXDOMAIN / REFUSED
    

## **5\. Creating a Table View for Analysis**

Since we have successfully view our raw logs, let’s create a table view to understand the raw log and for Initial event exploration through the following SPL queries:

index=dns sourcetype=dns:log

| table *time src*ip dest\_ip domain query\_type response\_code

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1763970490614/7aa1d010-d5d8-4f6b-b4b7-8ea340d23d63.png align="center")

*Initial DNS event breakdown to understand log structure.*

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1763970563843/7ff726d2-0fdd-4ba4-aa78-6f6d1a1c1f3c.png align="center")

*Initial DNS event breakdown using table view to understand log structure*  
**Outputs:**

* **src\_ip** → Client machine making DNS queries
    
* **dest\_ip** → DNS server
    
* **domain** → Domain being resolved
    
* **query\_type** → A, AAAA, PTR, TXT, etc.
    
* **response\_code** → SUCCESS / NXDOMAIN / REFUSED
    

## **6. Visualizing DNS Activity**

### **6.1 Top Queried Domains (Pie Chart)**

To understand the baseline behavior of the environment, I started by identifying the most frequently queried domains. This helps distinguish normal traffic from potential anomalies, since malware often communicates with unusual or rarely queried domains.

**I ran the following SPL search:**

index=dns sourcetype=dns:log

| stats count by domain

| sort - count

| head 10

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1763973148878/c58d4f47-2b37-46c0-8cd1-b8edf126592e.png align="center")

\*Top 10 most-queried domains (baseline visibility of DNS activity).\*This query returns the **top 10 domains most frequently requested** within the dataset.

**Why This Matters (SOC Perspective)**

* It helps establish what *normal* DNS query patterns look like.
    
* It allows me to quickly spot unfamiliar or suspicious domains.
    
* If a strange domain appears in the top list, it often signals malware, tunneling, or misconfigurations.
    
* This panel acts as an early-detection layer for command-and-control (C2) behaviors.
    

### **Visualization**

I converted the results into a **Pie Chart** to give a clear, visual snapshot of domain distribution. Pie charts make it easy to compare volumes at a glance and see if any domain stands out unexpectedly.

## **6.2. NXDOMAIN Trend by Source IP (Column Chart)**

To strengthen DNS threat detection in my environment, I analyzed **NXDOMAIN responses grouped by source IP**. This helps me quickly identify which hosts are repeatedly generating failed DNS requests — a strong indicator of:

* Malware using **Domain Generation Algorithms (DGAs)**
    
* Scripted attacks attempting random subdomains
    
* Misconfigured applications sending repeated invalid queries
    
* Hidden C2 (Command & Control) beaconing
    

Instead of just tracking overall NXDOMAIN volume, I wanted to pinpoint **exactly which hosts** were responsible for suspicious activity. So I used the following SPL query:

index=dns sourcetype=dns:log response\_code="NXDOMAIN"

| timechart count by src\_ip span=1h

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1763974342417/27b4e773-37cb-4613-b10b-f9406e8178d3.png align="center")

*Column chart showing NXDOMAIN activity per source IP over 1-hour intervals.*

**Outputs:** *Used to identify hosts exhibiting suspicious DNS behavior.*  
This query breaks down NXDOMAIN events **per host (src\_ip)**, grouped into **1-hour intervals**, making spikes and abnormal hosts immediately visible.

1. **Host Attribution**
    
    * I can instantly see which endpoints are generating the most NXDOMAIN traffic.
        
    * If one IP repeatedly hits non-existent domains, it becomes a prime investigation target.
        
2. **Behavioral Anomaly Detection**
    
    * A sudden hourly spike from a host can indicate automated malware behavior.
        
    * Normal systems rarely generate high NXDOMAIN counts.
        
3. **Threat Hunting Insight**
    
    This visualization helps identify **DGA-based malware**, which often tries dozens or hundreds of random domains per hour.
    

### **Visualization**

* **Chart Type:** Column Chart
    

**Reason:** Columns give clear hour-by-hour visibility, making it easy to spot abnormal spikes and compare different hosts directly.

## **6.3. DNS Query Volume Over Time**

To understand overall DNS activity patterns, I built a timechart showing the total number of DNS queries over time. This visualization helps reveal spikes, drops, or unusual traffic trends that could indicate suspicious activity or misconfigurations. It also establishes a clear baseline for what normal DNS behavior looks like in the environment. To understand overall DNS activity patterns, I ran a simple time-based aggregation to track how many DNS queries were generated within the environment.

**SPL Query Used:**

index=dns sourcetype=dns:log

| timechart count

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1763974820251/8ffc89b9-b199-4eb1-880d-85728343e7b1.png align="center")

*DNS query activity trend showing fluctuations in total DNS requests over time.*

This query produced a clean line-based trend showing how DNS requests fluctuate over time. In my case, the chart revealed clear spikes and drops in query volume, which helps identify unusual traffic bursts that may require further investigation—especially during non-business hours.

## **6.4. DNS Tunneling Detection (High-Value Query)**

To identify potential DNS tunneling activity, I inspected logs for unusually long domain queries—an indicator that attackers may be exfiltrating data through DNS packets.

**SPL Query Used:**

index=dns sourcetype=dns:log

| where len(domain) &gt; 50

| stats count by src\_ip domain

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1763975260245/43e30be3-659e-489e-882b-98be151f1906.png align="center")

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1763975338839/5d2a2fb3-ddcc-4bef-b886-6eb8e3d8692b.png align="center")

*Detection of hosts generating unusually large DNS queries, commonly associated with DNS tunneling behavior.*

This query highlights any source IP generating oversized DNS requests, helping me quickly pinpoint suspicious hosts or encoded domain patterns that require deeper investigation.

This result shows a list of DNS queries where the **domain length is unusually long** (more than 50 characters). These domains were extracted using:

“Detected abnormal DNS activity by identifying hosts querying extremely long or malformed domains. Results pointed to potential malware/DGA behavior, enabling targeted host investigation.”  
**The table highlights:**

* **Source IP addresses** making these abnormal DNS queries
    
* **Suspicious domains** (long, encoded, null-filled, or reverse IPv6 lookups)
    
* **Counts**, showing how frequently each host attempted those queries
    

**Many domains contain:**

* \*\\x00\\x00\\x00… → **null bytes**, common in malformed DNS packets or malware traffic
    
* Extremely long .ip6.arpa reverse lookup chains → often associated with misconfigured IPv6, embedded devices, or DGA-based malware behavior
    

Hosts like **192.168.202.108, 110, 115** show *high counts*, which is a strong indicator of abnormal DNS behavior worth investigating.

\*\*what I Found:  
\*\*The results revealed multiple internal hosts making DNS queries to **abnormally long or malformed domains**, including:

* Domains containing **null bytes (\\x00)**, which are not normal in DNS traffic
    
* Very long .ip6.arpa reverse lookup chains
    
* Repeated queries from specific hosts (e.g., 192.168.202.108, 192.168.202.110, 192.168.202.115)
    

**Why This Matters:**  
\*\*Long or malformed domains are commonly associated with:

* **DGA-based malware** generating random domain name
    
* **DNS tunneling** for covert communication
    
* Corrupted or misconfigured endpoint DNS software
    
* **Beaconing behavior** attempting to reach external command-and-control servers
    

By identifying which internal IPs generated these suspicious queries, I can prioritize them for deeper investigation or correlation with endpoint logs.

**Security Value:**  
This detection adds an important layer of **DNS threat visibility** by flagging unusual query patterns that traditional signature-based tools may miss.

## **7.2. Malware Callback Detection**

This outcome is positive—there were no signs of network devices, users, or processes attempting to reach suspicious or potentially malicious domains commonly abused by threat actors for malware callbacks. The system did not detect any network indicators of compromise related to these TLDs at this time.

index=dns sourcetype=dns:log

| search domain="\*.xyz" OR domain="\*.top" OR domain="\*.cn"

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764018348748/2697811e-6856-4ab3-ab33-9fa7dc9c8d2d.png align="center")

## **7.2 Malware Callback Detection (Suspicious TLD Query Check)**

**Objective:** Detect external DNS callbacks to high-risk TLDs often used by malware, such as .xyz, .top, and .cn.

\*\*Result:  
\*\*Splunk returned **no matching events**, meaning there were **no DNS queries** to these suspicious TLDs in the dataset.

\*\*Security Value:  
\*\*Even though no hits were found, this search demonstrates a **valid detection technique** used in real SOC environments to identify malware beaconing attempts. In production, these TLD-based detections often help identify phishing malware, botnet callbacks, or DGA-generated domains.

## 8.3. **Brute-Force DNS Beaconing Detection (High-Frequency Domain Queries)**

The goal of this search is to identify domains within DNS logs that have been queried extremely frequently (more than 5,000 times). Excessive repeated queries to specific domains can indicate beaconing behavior by malware or compromised hosts, which attempt to maintain persistent connections with command-and-control servers.

Objective: Identify potential malware beaconing or DNS tunneling by finding domains queried at extremely high frequency.

**Search Query:**

index=dns sourcetype=dns:log

| stats count by domain

| where count &gt; 5000

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764019535409/5210a57c-5ebd-4024-8cc6-90249505f704.png align="center")

*"Splunk search for high-frequency DNS queries—no domains exceeded the 5,000 query threshold, indicating no abnormal or beaconing activity detected during the selected period."*

This search aggregates all DNS queries by domain and isolates any domain queried over 5,000 times within the dataset.​

* Domains exceeding this threshold should be investigated for automated, suspicious, or malicious activity.
    

**Result:**  
No domains met the repeated query threshold (&gt;5000) in the selected time range. This means there were no notable signs of automated DNS beaconing, brute-force callbacks, or excessive domain activity that could indicate malware or tunneling attempts.  
**Security Value:**  
\*\*This detection method is commonly used in enterprise SOC environments to identify malware families that generate repetitive domain lookups (e.g., DGAs, botnets, persistent beaconing).  
Even with no results, it reflects a documented detection approach and demonstrates my ability to check for high-frequency DNS anomalies.

## **9\. Building the DNS Threat Detection Dashboard**

Once I completed the individual DNS log queries, I combined all visualizations into a single Splunk dashboard.

My goal was to create a central command view where an analyst can instantly spot normal behavior, anomalies, and early signs of DNS-based attacks.

**The dashboard presents:**

* DNS activity baselines
    
* High-risk anomalies
    
* Top talkers and suspicious domains
    
* Indicators of tunneling, DGA behavior, or misconfigurations
    

To keep it clean and USER-friendly, I designed the dashboard and layout as follows:

### **1) Create a New Dashboard**

1. In Splunk: **Dashboards &gt; Create New Dashboard**
    
2. Name: DNS Monitoring & Threat Detection Dashboard
    
3. Permissions: set to *app-level* and *readable by team* (or public for portfolio demo)
    

Layout: choose **Grid / 3-column** (gives flexibility and looks clean in screenshots)

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764021001247/579beb6c-d91b-45ba-85d3-fe778e4c3d2d.png align="center")

### **Panel list + exact queries + visualization + why it’s important**

Use these exact search strings. For each panel I show: query → visualization → purpose → screenshot advice.

### **Panel A — DNS Query Volume (Timechart)**

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764021350217/d1ba7b63-7db7-4679-a428-eaa9c23f01a3.png align="center")

Next»»

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764021224827/1a1fd608-a4e4-424d-a017-bd192b6b3ef7.png align="center")

Next»»»

index=dns sourcetype=dns:log

| timechart span=1h count as "DNS Events"

**Visualization:** Timechart (Area or Line)  
**Purpose:** Baseline of DNS traffic; quick indicator of spikes or outages.

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764021668581/19fcde44-e1ee-4589-b796-e047dd2398ff.png align="center")

The dashboard helps security teams track DNS activity and quickly identify anomalies such as unexpected traffic surges, which may indicate potential threats or misconfigurations. The pronounced spike could signal malicious activity or bulk operations and should be investigated further. This monitoring approach improves visibility into network traffic for threat detection and incident response.

Proceed to **Save as»**

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764022705930/c892d203-90d4-4a77-803d-355902861d8e.png align="center")

### **Panel B — Top Domains (by query count)**

**Query**

index=dns sourcetype=dns:log

| stats count by domain

| sort -count

| head 20

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764022878120/3e6e8b6a-edd6-45f6-acf8-23083bae57ae.png align="center")

**Visualization:** Bar chart (horizontal) or Table  
**Purpose:** Surfaces most queried domains — useful to spot suspicious or accidental mass lookups.

### **Panel C — Top Clients (Top src\_ip)**

**Query**

index=dns sourcetype=dns:log

| stats count by src\_ip

| sort -count

| head 20

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764024025373/05a9811d-72d1-4387-b2ef-a61d7e242530.png align="center")

*Image showing a statistics tab (table with src\_ip and count).*  
**Purpose:** Prioritize hosts generating the most DNS traffic (candidate for investigation).  
**Outputs:**

The Splunk search identifies the top 20 source IP addresses generating the highest number of DNS log events within the selected time range. The bar chart visualizes these IPs ranked by event count, helping you quickly spot hosts with unusually high DNS activity, which may indicate misconfigurations, automated processes, or potential suspicious behavior such as DNS tunneling or malware communication.

### **Panel D — NXDOMAIN Trend (Column Chart)**

**Query**

index=dns sourcetype=dns:log response\_code="NXDOMAIN"

| timechart span=1h count by src\_ip

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764024358109/0d576acb-91e6-4ec3-a22c-ba48e4897b97.png align="center")

**Purpose:** Identify hosts with frequent failed lookups — signs of DGA, misconfiguration, or beaconing.  
**Output:**  
This visualization shows an hourly timechart of NXDOMAIN DNS responses, grouped by source IP. It highlights which hosts are generating the most failed DNS queries (NXDOMAIN) over time. A large spike from specific IPs indicates unusual or excessive DNS failures, which may point to misconfigurations, unreachable domains, or potential malicious activity such as DNS tunneling or malware performing repeated lookups to non-existent domains.

### **Panel E — Suspicious TLD Queries**

**Query**

index=dns sourcetype=dns:log

| search domain="\*.xyz" OR domain="\*.top" OR domain="\*.cn" OR domain="\*.ru" OR domain="\*.pw"

| stats count by domain src\_ip

| sort -count

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764024872119/a8571951-416c-4167-ba41-2a78b5d70208.png align="center")

“This panel shows top queries for high-risk TLDs, helping identify potentially malicious activity on the network.”

**Visualization:** Table (or bar chart if few results)  
**Purpose:** Detect external callbacks to high-risk TLDs often abused by malware.

### **Panel F — Large DNS Query Length (Tunneling Detection)**

**Query**

index=dns sourcetype=dns:log

| where len(domain) &gt; 50

| stats count by src\_ip domain

| sort -count

| head 50

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764025254290/872e5c0b-5c18-4f4b-8bc3-1ef1e5086e75.png align="center")

Perfect! This query is designed to detect unusually long domain names, which can be an indicator of DNS tunneling or exfiltration attempts. Here’s how to add it professionally as a panel to your DNS Monitoring & Threat Detection dashboard:

### **Panel G — Repeated Domain Flood (Brute-Force Beaconing)**

**Query**

index=dns sourcetype=dns:log

| stats count by domain

| where count &gt; 5000

| sort -count

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764025580074/bae38d24-42a4-40d3-98ad-bb361cfc5cdb.png align="center")

I lower the **temporarily lower the threshold**, e.g., | where count &gt; 1000, so a chart renders for demonstration. Although real threshold is 5000+

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764025665688/13ea1481-5a6b-465a-ad3e-e04d95c3b1cc.png align="center")

**Visualization:** Table  
**Purpose:** Flag domains queried at extremely high frequency (potential automated beaconing or misconfig).  **Purpose:** Detect DNS tunneling/DGA or malformed queries (long, encoded strings).

You can see the full PDF [DNS Monitoring & Threat Detection Dashboard](https://1drv.ms/b/c/b3322d5b87e2e949/IQC0rrkqDF3JQZCTlMxmluDQASeA4G8AjRTk3COcxqsfhkI?e=KMlEd6):

## **4)** Dashboard Structure & Analyst UX Optimization

Top row (full width): **DNS Query Volume** (wide timechart) — sets baseline.

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764057226515/e28114e0-938f-4415-b469-1829f56f7032.png align="center")

Second row (three columns): **Top Domains | Top Clients | NXDOMAIN Trend**.

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764057801906/edfdc913-f000-4028-bda2-890ec1510cb2.png align="center")

Third row (two columns): **Suspicious TLDs | Large Query Length** (tables).

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764058084007/ec87bcba-da70-4b6d-9b68-6b9c2f4f5bfc.png align="center")

* Bottom row (narrow): **Notes / Last Updated / Dataset Range** — a small text panel with search timeframe, data window, and contact.
    

Third row (two columns)

1. Add Suspicious TLDs (table) on left, Large Query Length (table) on right.
    
2. Use table column widths so domain and src\_ip are readable.
    

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764058599699/03c0d46f-0b7e-49c2-a712-a64e603fa3ce.png align="center")

The visualization highlights unusually high DNS query volumes from several domains, with one domain generating over 4,000 requests—significantly higher than the others. This pattern is indicative of potential brute-force or beaconing behavior, where a host repeatedly contacts the same domain in short intervals. Such activity may signal malware callbacks, automated scanning, or command-and-control communication and should be investigated for malicious intent.

READ THE FULL PDF DASHBOARD [HERE:](https://1drv.ms/b/c/b3322d5b87e2e949/IQD9foh40fUORKk4lR0RNA4fAaYmXGtCfG85xBsQDoXozao?e=fSaJNU)

This dashboard provides insights into DNS traffic, anomalies, and threat indicators.

## **Interactive Drilldown Search for Rapid Incident Investigation**

To enhance the dashboard’s investigative capability, I configured drilldowns that allow an analyst to click on any IP address and instantly pivot into deeper log analysis. When an IP is clicked, Splunk runs the following SPL to fetch all recent events associated with that host across multiple data sources:

“index=dns OR index=ssh OR index=http OR index=dhcp OR index=smtp sourcetype=\*

(src\_ip="$click.value$" OR src="$click.value$" OR dest="$click.value$" OR src\_ip="$click.token$" OR src="$click.token$")

| sort - \_time

| table *time index sourcetype host src*ip dest\_ip domain url user response\_code message”

**How It Works:**

$click.value$ automatically captures the field value clicked by the analyst.

Splunk uses this value to search across multiple indexes — DNS, SSH, HTTP, DHCP, and SMTP.

This instantly surfaces all correlated events involving that IP, making it much easier to identify lateral movement, scanning, or suspicious communications.

This drilldown transforms the dashboard from a simple visualization into an interactive investigation workspace, similar to what real SOC teams use for triage.

### Configuring Drilldown Interaction (Step-by-Step)

After preparing the drilldown SPL, I enabled interactive investigation directly from the dashboard. This allows me to click on any IP address in a panel and immediately pivot into a deeper multi-index search.

**B — Setting Up the Drilldown**

Open the dashboard → Edit

Click the Top Clients panel → Edit Panel (pencil icon)

Select Drilldown → choose Open in New Window (recommended)

Paste the drilldown SPL into the Drilldown Search field

When Splunk asks which token to pass:

**Default:** $click.value$

If the field is named (e.g., src\_ip), use $row.src\_ip$

**Save the panel**

**Result:** Clicking an IP now launches a full correlated search across DNS, SSH, HTTP, DHCP, and SMTP logs.

**C — Testing the Drilldown**

Open the dashboard

Click any IP under Top Clients

A new search window should automatically open

The SPL will inject the selected IP and display related events from all configured indexes

📸 drilldown\_top\_clients.png  
*Caption: Successful drilldown pivot showing correlated events across multiple log sources.*

### Drilldown Confirm Configuration

To confirm that the drilldown is configured correctly, the following SPL is used inside the Search String box:

index=dns sourcetype=dns:log src\_ip="$row.src\_ip$"

When an analyst clicks an IP address in the Top Clients panel, Splunk automatically replaces the token $row.src\_ip$ with the actual IP value.

## Example Output After Click:

index=dns sourcetype=dns:log src\_ip="192.168.202.183"

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764102556709/4615f136-0d1c-4609-b883-e79d9f780bcb.png align="center")

*Screenshot shows the auto-populated SPL and the resulting event table*

This proves that the drilldown successfully populated the selected IP (192.168.202.183) into the SPL, allowing an analyst to immediately investigate all related DNS activity.

### Drilldown Output Example

When the analyst clicks an IP in the Top Clients panel, Splunk opens a new search tab and automatically injects that IP into the SPL. This search displays all DNS events related to the selected IP across your DNS logs.

Screenshot Confirmation:

## **Drilldowns, Alerts & Actions (operationalize the dashboard)**

I enabled drilldown actions in the dashboard so I can click an IP address and automatically pivot to a deeper search across multiple log sources. This transforms the dashboard from “just visuals” into a real SOC investigation tool.

**Why It Matters:**

* Enables instant threat pivoting
    
* Reduces investigation time
    
* Mirrors real SOC analyst workflow
    
* Helps correlate cross-log activity in seconds
    

## **6\. How I Configured the Drilldown (Implementation Steps)**

* Add **drilldown** on Top Clients: click an IP -&gt; open a detailed search for that src\_ip across endpoints/logs.
    
* Configure **Saved Searches** for the high-confidence detections (Large Query Length, Suspicious TLDs) and wire them to **email/Slack** alerts.
    
* Add a “Create Ticket” link that prefills an incident template (if your environment supports it) — shows practical SOC workflow.
    

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764060827119/515fb0ae-2882-464f-b946-55033fb7a1da.png align="center")

* **Link to Search**
    
* This option allows you to open Search with a pre-filled SPL.
    

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764061539182/89973169-1083-49e9-8206-2a460ad1c39f.png align="center")

## **Step 5 — Paste the Drilldown SPL**

Inside the “Search String” or “Search Query” box:

1. Paste the SPL
    
2. Ensure the **token** matches what Splunk introduces
    

Common token options Splunk offers automatically:

* $click.value$ → for charts & tables
    
* $row.src\_ip$ → for tables with field names
    
* $row.client\_ip$ → if your field is named differently
    

**Tip:** If your Top Clients panel uses a field named src\_ip, then use:

src\_ip="$row.src\_ip$"  
If unsure, keep $click.value$ — it works 98% of the time.

## **Step 6 — Test the Drilldown**

1. Click **Apply**
    
2. Save the dashboard
    
3. Exit editing mode
    
4. Click any IP in the Top Clients panel
    

Splunk should automatically open a new Search tab with your SPL and begin loading results.

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764061795748/38eee390-a13d-4843-bf18-de4f70b3ef24.png align="center")

*Successful drilldown pivot showing correlated events across multiple log sources.*

**Each of the above graph is clickable for user to investigate the ip**

1. For tables (Top Domains, Suspicious TLDs, Top Clients) enable **drilldown** so clicking a domain or IP opens a detailed Search with that entity token.
    
2. In Studio, configure panel actions → Drilldown → Open in Search with token substitution (e.g., domain=$row.domain$).
    

This demonstrates operational maturity — a SOC analyst can pivot quickly.

### Drilldown Implementation

I configured interactive drilldowns on the Top Clients panel so that when an analyst clicks any IP address, Splunk automatically launches a cross-index investigation search using predefined SPLs across DNS, SSH, HTTP, DHCP, and SMTP logs.

This enables a fast pivot workflow where the analyst can immediately view all recent events associated with the selected IP, including timestamps, hosts, domains visited, URLs, response codes, and raw log messages.

For a video walkthrough on adding drilldowns, watch here: [https://tinyurl.com/2725gz43](https://tinyurl.com/2725gz43)

## **Building High-Fidelity Security Alerts in Splunk: A Step-by-Step Implementation Guide**

High-confidence alerts are essential for reducing noise and ensuring SOC analysts respond only to meaningful threats. In this guide, you’ll learn how to build a reliable Splunk alert that detects **large and repeated DNS query lengths**, a common indicator of **DNS tunneling**, covert data exfiltration, or malware beaconing.

This step-by-step process walks you through opening Splunk Search, running the SPL, validating results, and converting the search into a production-ready scheduled alert. By the end, you’ll have an automated detection that enriches your monitoring pipeline and helps your SOC identify stealthy threat activity with greater accuracy.

### **STEP 1 — Open Search & Reporting**

1. In Splunk, click **Search & Reporting**
    
2. Clear your search bar
    

### **STEP 2 — Paste the SPL**

Paste this SPL exactly:

index=dns sourcetype=dns:log

| eval domain\_length = len(domain)

| where domain\_length &gt; 50

| stats count by src\_ip domain domain\_length

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764103654154/382c3e85-484b-461f-ae84-d204736952be.png align="center")

*Shows SPL pasted in search bar with example results highlighting suspicious long domains.*

**What this SPL does:**

* Calculates length of each domain queried
    
* Flags any domain &gt; 50 characters
    
* Checks if the same host did this ≥5 times
    
* Helps detect DNS tunneling behavior
    

Run it once to confirm results.

### **STEP 3 — Save As Alert**

1. At the top-right click: **Save As → Alert**
    
2. Fill out:
    

### **Title**

**ALERT - Large DNS Query Length (Tunneling Suspected)**

### **Permissions**

**Shared in App (Search & Reporting)**

### **STEP 4 — Choose Alert Type**

Select:

### **Scheduled Alert (Recommended)**

* Cron = **Every 5 minutes**
    

Or use **Run every 5 minutes** (GUI mode)

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764104220730/53f31c0f-2b1f-49cb-80f4-5a747e116b8c.png align="center")

*Image showing scheduled alert configuration with cron schedule.*

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764104510183/bff6c88a-d059-4a47-b829-91026782a32d.png align="center")

Image *showing trigger condition configuration in Splunk*

### **STEP 7 — Configure Actions (Email + Slack)**

**A. Email Action**

* Enable email notifications.
    
* To: SOC mailbox ([soc-alerts@example.com](mailto:soc-alerts@example.com))
    
* Subject: ALERT: Large DNS Query Length Detected from $result.src\_ip$
    
* Include tokens in message body: $result.domain$, $result.domain\_length$, $result.count$
    

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764104874876/d6d820bb-76dd-4728-bc27-3a529af866bd.png align="center")

Shows email action configuration with dynamic tokens

**Create a Slack Incoming Webhook**

1. Go to your Slack workspace.
    
2. Navigate to **Apps → Manage Apps → Custom Integrations → Incoming Webhooks**.
    
3. Click **Add to Slack**.
    
4. Choose the channel you want the alerts to post to.
    

Slack generates a **Webhook URL**, something like:

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764105429094/9b07e46d-a7ac-4ea9-9078-910184cc39b6.png align="center")

Added slack and input webhook url

*Shows throttling settings enabled in the alert configuration.*  
              *This prevents the same host from triggering too many alerts in a short period.*

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764106534445/82d4c5f8-8211-42e1-8805-42a61586d323.png align="center")

Added slack incoming webhook on the webhook url

Real-time alerts can overwhelm Splunk and are harder to manage. Scheduled is best practice for SOC.  Shows email action configuration with dynamic tokens.

## **Triggering Slack Alert via PowerShell Simulation**

To ensure your alert is properly formatted and delivered, you can simulate it before it goes live. This is a key step to verify **readability, dynamic tokens, and payload structure**.

### **STEP 1 — Enable Webhook**

* Turn the webhook **ON** in your alert configuration.
    
* Paste your **Slack Incoming Webhook URL** (from Slack → App Integrations → Incoming Webhook).
    
* ![](data:image/png;base64,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1ghQHxIggRxOgEZIDr8BWH0SIAESIAESIAESIIGcQsB26kkjxHbagpqQAAmQAAmQAAmQAAmQQI4gQCMkRzQzK2kmwDMJkAAJkAAJkAAJkEDWE6ARkvVtQA1IgARIILsTYP1IgARIgARIIA4BGiFxcNBDAiRAAiRAAiRAAtmFAOtBArZLgEaI7bYNNSMBEiABEiABEiABEiCBbEkgWxsh2bLFWCkSIAESIAESIAESIAESsHMCNELsvAGpPgnYIAGqRAIkQAIkQAIkQALJEqARkiweRpIACZAACZCAvRCgniRAAiRgPwRohNhPW1FTEiABEiABEiABEiABWyNAfR6LAI2Qx8LGTCRAAiRAAiRAAiRAAiRAAo9LgEbI45JjPjMBnkmABEiABEiABEiABEggTQRohKQJFxOTAAmQgK0QoB4kQAIkQAIkYL8EHKOjY2B0D+23FtScBEiABEiABEiABDKDAMsgARJIFwKOzs5OMLpc6SKQQkiABEiABEiABEiABEiABEggOQJpnY6VnCzGkQAJkAAJkAAJkAAJkAAJkECKBGiEpIiICUjAFghQBxIgARIgARIgARLIPgRohGSftmRNSIAESIAE0psA5ZEACZAACWQIARohGYKVQkmABEiABEiABEiABB6XAPNlfwI0QrJ/G7OGJEACJEACJEACJEACJGBTBGiE2FRzmJXhmQRIgARIgARIgARIgASyLwEaIdm3bVkzEiCBtBJgehIgARIgARIggUwhQCMkUzCzEBIgARIgARIggaQIMJwESCDnEaARkvPanDUmARIgARIggf+zdy9wNd//H8BflaILq5iyktvcfpjZ3Dbm8hs2l01srouZy4YpC811DJm5/REjM5eNuV/3CxPGKGKMJExzDxUqdD2p/t/P95yTbnKqU51v59Wjz/d7vt/P/fn9Ptbn7XvOGQUoQAEKlKgAg5AS5WfnFKAABShAAQpQgALGI8CZagUYhGgluKeADgJmJoCVmQ4Fi7CI6F+Mowi7YNMUoAAFKEABClCgSAUYhBQpLxvPLqD045csgLoVTPDhkTR0OFT8SfQr+hfjULolx08BClCAAhSggPEKMAgx3mvPmRdAoJo10L+GCcbUN8XEBsWfRL+ifzGOAgyfVYxXgDOnAAUoQAEKGJQAgxCDuhwcjCEL3LoTiYvnQxF/NRRlboeibHjxJ9Gv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 align="left")
    

Shows the Slack webhook URL field enabled in Splunk.

### **STEP 2 — Prepare Example Payload**

Splunk auto-fills dynamic fields in JSON format:

{

"text": "ALERT: Large DNS Query Length detected\\nSRC IP: $result.src\_ip$\\nDomain: $result.domain$"

}

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764108667896/ce6a173b-db92-4b81-a55e-179d2c1bc33d.png align="center")

**Walkthrough:**

* $result.src\_ip$ and $result.domain$ are dynamically replaced with actual event data when the alert fires.
    
* The payload ensures the Slack message is readable and contains all relevant info for SOC analysts.
    

### **STEP 3 — Simulate Alert with PowerShell**

* Use PowerShell to mimic the Splunk alert payload.
    

Confirm the Slack message appears correctly in your channel before live deployment.

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764109168975/9991c585-e8ab-43fe-a8f3-e227d8944ad9.png align="center")

* Shows PowerShell script executing the test payload and the resulting Slack alert in the channel.
    

**Walkthrough:**

* Verifies formatting, token replacement, and Slack delivery.
    
* Ensures real-time alerting works without errors or duplicates.
    

### **C. Add to Triggered Alerts**

Enable:

* **Add to Triggered Alerts**
    

So the alert shows in the Splunk Alerts page.

### **STEP 8 — Save**

Click **Save** at the bottom.

Your first high-confidence alert is fully operational.

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764109713737/cc557d57-ce2e-4025-aa75-f067168349e9.png align="center")

**Run the Alert Immediately (Manual Trigger)**

Splunk lets you **run your alert instantly**.

### **Step 1 — Go to Alerts Page**

1. In Splunk
    
2. Go to **Activity → Triggered Alerts**
    
3. Or  
    **Settings → Searches, Reports, Alerts**
    

### **Step 2 — Find Your Alert**

Look for:

**ALERT - Large DNS Query Length (Tunneling Suspected)**

### **Step 3 — Click “Run Alert” or “Run Search Now”**

Depending on Splunk version:

* Some show **Run Alert**
    
* Others show **Run** (which executes the search)
    

This immediately evaluates the SPL and triggers actions (email/Slack) **if results exist**.

## **HOW TO CHECK EMAIL & SLACK NOTIFICATIONS**

Once you trigger the alert (via method 1 or method 2):

### **Check Email**

1. Open your mailbox
    

Look for subject:  
**“ALERT: Large DNS Query Length Detected from &lt;IP&gt;”**

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764110764908/a810741e-cfca-4936-974d-ae594933a104.png align="center")

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764110288623/e926e7f2-09bf-4081-941e-adc69d424c2f.png align="center")

**You can view the** [**full pdf alert here**](https://1drv.ms/b/c/b3322d5b87e2e949/IQCrhmxmdpXBSbXKCqtfGt2TAdEFoZJ3AuQFDyqXTqqfV5Y?e=MF50vt)\*\*  
Check Slack\*\*

You should see a message in your selected Slack channel:

ALERT: Large DNS Query Length detected

SRC IP: 10.0.0.10

Domain: exampleverylongdomainthatexceedsfiftycharacters123.com

If Slack webhook is correct, the message appears in seconds.

**3) Configure Slack notifications (Webhook) for alerts**

If you want Slack notifications, create an incoming webhook in Slack, then use Splunk’s **Webhook** alert action.For example

### **A — Create Slack Incoming Webhook**

1. In Slack, go to **Apps → Incoming Webhooks** (or admin app management).
    
2. Create a new webhook for the channel where alerts should post.
    
3. Copy the **Webhook URL** (example \[https://hooks.slack.com/services/T000/B000/XXXXX).
    
    \](https://hooks.slack.com/services/T000/B000/XXXXX).)
    

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764155679408/6170a3e5-e909-44e7-af60-06fb25e37fd5.png align="center")

### **B — Add Slack webhook in Splunk alert (per-alert)**

When configuring the Alert Action (Edit Alert → Actions):

1. Enable **Webhook**.
    
2. In the **Webhook URL** field, paste the Slack webhook URL.
    
3. **Payload** — Slack expects JSON; paste this sample payload (adjust tokens):
    

{

"text": "\*ALERT:\* Large DNS Query Length detected",

"attachments": \[

{

"color": "#ff0000",

"title": "Large DNS Query Length - $result.src\_ip$",

"fields": \[

{"title": "Host", "value": "$result.src\_ip$", "short": true},

{"title": "Domain", "value": "$result.domain$", "short": true},

{"title": "Count", "value": "$result.count$", "short": true}

\],

"footer": "Splunk Alert"

}

\]

}

Splunk will substitute $result.FIELD$ tokens for the top result fields. Test once and adjust.

### **C — Alternatively add a global webhook action (admin)**

* Admins can configure webhook alert actions centrally in **Settings → Server settings → Alert actions → Webhook**.
    

---

## **4) Add a “Create Ticket” link (prefill incident template)**

You can add a clickable link in the dashboard footer or in the alert email that opens a prefilled ticket form. Options:

### **Option A — Simple: mailto: link (works everywhere)**

Create a mailto link that opens the email client with subject/body prefilled.

Example link (use in Markdown/Single Value panel):

&lt;a href="[mailto:soc@yourorg.com?subject=Incident%20-%20DNS%20Alert%20%7C%20$src\_ip$&body=Alert%20Details%3A%0A-%20Alert%20Name%3A%20Large%20DNS%20Query%20Length%0A-Host%3A%20$src\_ip%0A-Domain%3A%20$domain%0A-Timestamp%3A%20$time%0A-Notes%3A%20"&gt;Create](mailto:soc@yourorg.com?subject=Incident%20-%20DNS%20Alert%20%7C%20$src_ip$&body=Alert%20Details%3A%0A-%20Alert%20Name%3A%20Large%20DNS%20Query%20Length%0A-Host%3A%20$src_ip%0A-Domain%3A%20$domain%0A-Timestamp%3A%20$time%0A-Notes%3A%20%22%3ECreate) Ticket (Email)&lt;/a&gt;

* Replace $src\_ip$ etc. with variables when used in alert emails (Splunk expands tokens).
    

## **DNS Security Alerts — Jira Ticket Integration**

For each DNS alert I generated from the Splunk DNS Monitoring & Threat Detection Dashboard, I created a Jira ticket to track and manage the incident. Each ticket captures all relevant details of the alert, including: Automatically create Jira tickets from Splunk DNS alerts to track, manage, and escalate incidents efficiently. This models a real SOC workflow from detection to incident tracking.

I structured the ticket to provide clear guidance for investigation, documenting the detection context, recommended response steps, and escalation criteria. I also included supporting evidence such as dashboard screenshots, raw event logs, CSV exports, and threat intelligence results from VirusTotal, AlienVault OTX, and MITRE ATT&CK mapping when applicable.

This approach allowed me to link Splunk detections directly to actionable Jira tickets, ensuring a repeatable, auditable workflow for incident response and demonstrating practical SOC operations skills in my project.

If you want to further operationalize or manage the alert, here are the main navigation actions you can take from this page:

* **Alert Type**
    
* **Source IP**
    
* **Domain Queried**
    
* **Timestamp**
    
* **Event Count**
    
* **Triggered Panel**
    
* **Search Query**
    

**Out of the four  4 DNS detections, i used :**

* NXDOMAIN Spike
    
* Suspicious TLD Request
    
* DNS Query Volume Spike
    
* Possible DNS Tunneling
    

### **STEP 1 — Configure Jira Ticket Link**

* Generate a **prefilled Create Issue URL** using your Jira project ID and issue type:
    

[https://yourjira.atlassian.net/secure/CreateIssueDetails!init.jspa](https://yourjira.atlassian.net/secure/CreateIssueDetails!init.jspa)?

pid=KAN&

issuetype=10001&

summary=\[DNS Alert\] Suspicious Activity&

description=Alert generated from Splunk dashboard panel $panel\_name$%0ASource IP:$src\_ip$%0ADomain:$domain$%0ATime:$time$

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764145717332/904914c5-53ea-4b8e-b78b-a134efa9ea5a.png align="center")

*Image showing a prefilled Jira “Create Issue” page with dynamic tokens.*

**Walkthrough:**

* pid=KAN → Jira project ID.
    
* issuetype=10001 → Task or incident type.
    
* summary → Ticket title.
    
* description → Prefilled details for analyst context.
    

See the correct version of the prefilled jira *“Create Issue” page i created* [*here.*](https://babatunde-qodri.atlassian.net/secure/CreateIssueDetails!init.jspa?pid=10000&issuetype=10001&summary=%5BDNS)

### **STEP 2 — Add Ticket Link to Splunk Alerts**

* In Splunk, go to **Settings → Searches, Reports, and Alerts → Edit Alert → Actions → Send Email**.
    
* Add the Jira link in the email body or dashboard panel HTML:
    

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764155467291/90fe42bc-514a-427b-ad02-d820d8653a38.png align="center")

Click here to create a Jira ticket for this alert:

&lt;a href="[https://yourjira.atlassian.net/secure/CreateIssueDetails!init.jspa?..."&gt;Create](https://yourjira.atlassian.net/secure/CreateIssueDetails!init.jspa?...%22%3ECreate) Jira Ticket&lt;/a&gt;

**Walkthrough:**

* Ensures analysts can quickly create a ticket directly from the alert email or dashboard.
    

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764146498674/07046885-09ff-439b-b82e-c2eedfa3e57d.png align="center")

Image showing an email alert template with Jira ticket link embedded.

## Creating a **Gmail filter** for your Splunk alert emails

This ensures that your **SOC alert emails are organized, visible, and easy to track** — perfect for documentation and showcasing to recruiters.

Here’s a **ready-to-use Gmail filter setup** for your Splunk DNS alerts:

### **Step 1 — Create the filter**

In Gmail, click the Settings gear → See all settings → Filters and Blocked Addresses → Create a new filter. You’re now configuring a Gmail filter, so Gmail can automatically label, highlight, or forward Splunk alert emails.

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764147541432/760cef01-889c-4583-b6b5-b3f6db95017d.png align="center")

### **Step 2. Fill in the search criteria:**

| **Field** | **Value** |
| --- | --- |
| **From** | (your Splunk alert sender email, e.g., [splunk-alerts@yourdomain.com](mailto:splunk-alerts@yourdomain.com)) |
| **Subject** | DNS Alert |
| **Has the words** | Optional: $panel\_name$ OR $src\_ip$ (if you want to match dynamic tokens) |
| **Leave other fields blank unless you want more filtering** |  |

### **Step 3: Click Create filter**

3. ![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764148999823/f17962ce-dc74-4571-9f25-f6dcb0f37638.png align="center")
    

### **Step 4- Configure filter actions**

Check the following boxes:

* **Apply the label:** Splunk Alerts (create this label if it doesn’t exist)
    
* **Never send it to Spam**
    
* **Star it** (optional, for visibility)
    
* **Skip the Inbox (Archive it)** (optional, if you only want it in the label folder)
    
    ![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764148402154/61b57329-748e-426c-be0d-57b5639386e9.png align="center")
    
    *image showing Gmail filter setup for alert organization*
    

Leave all other options unchecked.

Check **“Also apply filter to matching conversations”** if you want existing alerts organized as well.

### **Step 3 — Save the filter**

* Click **Create filter**.
    
* All future DNS alert emails from Splunk will now be:
    
    * Labeled Splunk Alerts
        
    * Never go to spam
        
    * Optionally starred or archived
        
        ![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764147462168/9fa1ab97-8a4d-48fc-ab53-e66afab6cc77.png align="center")
        

**Splunk dashboarding**, **alerting**, **email automation**, and **incident tracking with Jira**.

### **STEP 4 — Test & Verify**

* Click the Jira ticket link from an alert email or dashboard panel.
    
    ![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764150053181/1d47cdcf-7063-4685-94c1-db355b751881.png align="center")
    
    ![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764150154555/5aaefc45-60a3-4876-92ab-37babe996fed.png align="center")
    

Confirm the ticket opens with **prefilled source IP, domain, timestamp, and panel name**.

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764152509010/71a54243-988f-4fd7-b6e6-70350cb20897.png align="center")

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764152349996/a1a62e6b-0cd4-4989-9578-baffee8af882.png align="center")

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1764152301140/29dee586-4d5c-422f-9e96-d3bef7527375.png align="center")

Here is the video for [alerts and ticketing successfully created with jira](https://www.awesomescreenshot.com/video/46514822?key=09be5c91ce47b6f18f37f209c8f48135)  
You can find  [evidence attachment pdf here](https://1drv.ms/b/c/b3322d5b87e2e949/IQCrhmxmdpXBSbXKCqtfGt2TAdEFoZJ3AuQFDyqXTqqfV5Y?e=nvw8fw):  
You can find the  [evidence attachment docs csv](https://1drv.ms/x/c/b3322d5b87e2e949/IQAv7oMcqkWqR4vlNGH4GaR2AUSk53EzczFLHJq_QUnAIy0?e=dEb961) here.  
You can fidnd the [pre-filled jira ticket simulation here.](https://babatunde-qodri.atlassian.net/browse/KAN-1)  
You can also give star on my [github](https://github.com/Talk2Babatunde) repository if you enjoy this.

## **Conclusion**

This project successfully demonstrates my ability to design and implement a complete SOC alerting and incident-response workflow using Splunk, Slack, Gmail, Jira, and custom dashboards. Throughout the lab, I built an end-to-end detection pipeline — from data onboarding, real-time monitoring, alert creation, webhook integrations, automated ticketing, and visualization — all mapped to practical SOC analyst responsibilities.

By configuring DNS-based detections, brute-force login alerts, Slack notifications, and Jira auto-ticketing, I recreated how modern security teams respond to threats at scale. I also strengthened my documentation, dashboard-building skills, alert tuning, and my understanding of how SOC workflows connect across SIEM, collaboration tools, and ticketing systems.

Additionally, this hands-on project not only sharpened my technical capabilities but also reflects my readiness to operate in a real SOC environment — from threat detection to escalation and communication. It demonstrates my ability to think like an analyst, automate like an engineer, and document like a professional.

Going forward, I will continue improving this lab by adding new detections, integrating threat intelligence (OTX/MITRE ATT&CK), and refining alert fidelity.

NOTE: This documentation reflects my commitment to continuous learning, operational excellence, and building practical SOC skills that translate directly into impact in any security team.

Thank you for reading, you can follow me on [Linkedln](http://www.linkedin.com/in/babatunde-qodri-27716b1a5) & [X](https://twitter.com/_BabatundeQodri) here.