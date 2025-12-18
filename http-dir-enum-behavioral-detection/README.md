# Behavioral HTTP Threat Detection: Directory Enumeration (DirBuster-Style Reconnaissance)

## Overview

This repository demonstrates a **SOC‑style, detection‑driven incident response workflow** for identifying and validating **HTTP directory enumeration attacks** using behavioral analysis in Splunk. The project focuses on early‑stage web reconnaissance activity (pre‑exploitation) and shows how analysts detect, triage, enrich, correlate, and respond to suspicious behavior before compromise occurs.

The detection logic is intentionally **behavior‑based and tool‑agnostic**, enabling identification of automated scanners such as **OWASP DirBuster** even when attacker tooling or signatures change.

---

## Why This Project Matters

Directory enumeration is often the **first observable phase** of a web attack lifecycle. If left undetected, it commonly precedes:

* Credential brute‑force attempts
* Exploitation of hidden endpoints
* Web shell deployment or data exposure

This project demonstrates how a SOC analyst:

* Detects reconnaissance early
* Confirms malicious intent using multiple indicators
* Avoids false positives
* Documents incidents professionally
* Defines clear escalation and response criteria

---

## Threat Scenario

**Attack Type:** Web Reconnaissance / Directory Enumeration
**Common Tools:** DirBuster, Gobuster, Nikto
**Attack Phase:** Pre‑Exploitation (MITRE ATT&CK – Reconnaissance)

Observed attacker behavior includes:

* High‑volume HTTP requests from a single source IP
* Large numbers of **unique URI paths**
* Excessive **HEAD and GET** requests
* Predominantly **404 / 403** response codes
* Suspicious or known scanning User‑Agents

---

## Detection Philosophy

This project uses **behavioral HTTP threat detection**, meaning alerts are triggered by **how traffic behaves over time**, not by static signatures or known payloads.

Key behavioral indicators:

* Request volume anomalies
* URI diversity anomalies
* HTTP method misuse
* Error‑heavy response patterns
* Absence of legitimate POST workflows

Threat‑intelligence enrichment is applied to **increase confidence and reduce noise**.

---

## SOC Detection Workflow

### 1. Log Ingestion & Validation

* HTTP access logs ingested into Splunk (`sourcetype=HTTP_Threat_Detection`)
* Field validation performed before detection logic is applied

### 2. Enumeration Detection

* Identify source IPs with abnormal request volume
* Correlate high request counts with high unique URI access
* Filter to reconnaissance‑specific methods (HEAD / GET)

### 3. Validation & Triage

* Confirm response code patterns (404 / 403 dominance)
* Review User‑Agent behavior
* Compare against known‑good browsing patterns

### 4. Threat Intelligence Enrichment

* Enrich source IPs using a custom threat lookup
* Apply threat classification and severity

### 5. Correlation & Follow‑On Analysis

* Pivot to detect authentication abuse (POST /login)
* Correlate reconnaissance with brute‑force attempts
* Assess for attack progression or coordination

### 6. Response Decision

* Block malicious IPs when required
* Monitor for escalation indicators
* Escalate only if exploitation evidence appears

---

## Incident Response Playbook

This repository includes a **SOC Incident Response Playbook** for HTTP reconnaissance:

**Response Options:**

* **Block:** Firewall / WAF / Reverse proxy
* **Monitor:** Short‑term observation for escalation
* **Escalate:** Only upon exploitation indicators

Clear escalation triggers are defined to prevent over‑reaction while ensuring rapid containment if attacker behavior progresses.

---

## MITRE ATT&CK Mapping

* **TA0043 – Reconnaissance**
* **T1595.001 – Active Scanning: Web Content Discovery**
* **T1083 – File and Directory Discovery**
* **T1110 – Brute Force** (correlated follow‑on activity)

---

## Repository Structure

```
├── docs/           # Reports, screenshots, charts, walkthrough video
├── detections/     # Splunk SPL detection and correlation queries
├── intel/          # Threat intelligence lookups and IOC lists
├── data/           # Sample HTTP logs (simulated for practice)
├── references/     # MITRE, tool documentation, best practices
```

Each directory mirrors how detections and investigations are stored in a real SOC environment.

---

## Tools & Technologies

* **Splunk Enterprise** – Log ingestion, correlation, alerting
* **HTTP Access Logs** – Primary telemetry source
* **Threat Intelligence Lookups** – IP‑based enrichment
* **MITRE ATT&CK Framework** – Threat mapping
* **Linux (Ubuntu)** – Lab environment

---

## Key Outcomes

* High‑confidence directory enumeration detection
* Reduced false positives through baselining and enrichment
* Correlation of reconnaissance with credential abuse attempts
* Clear documentation of **no‑exploitation** outcomes
* SOC‑ready incident reporting and response logic

---

## Analyst Takeaway (Interview‑Ready)

> "This project demonstrates how I detect and validate web reconnaissance using behavioral indicators, enrich alerts with threat intelligence, and correlate activity across the attack lifecycle to enable early containment before exploitation occurs."

---

## Disclaimer

The log data used in this repository is **simulated for training purposes**. All detection logic, analysis methodology, and incident response decisions reflect **real‑world SOC practices**.

---

## Author
BABATUNDE QODRI

**SOC Detection & Incident Response Portfolio Project**
