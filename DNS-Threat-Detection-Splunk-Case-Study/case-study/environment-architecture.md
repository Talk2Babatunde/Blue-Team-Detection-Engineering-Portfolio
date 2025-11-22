# Environment Architecture

Components:
- Splunk Enterprise running on Ubuntu Server
- Windows VM generating DNS logs
- Splunk Forwarder sending data into Splunk indexers
- Custom indexes: dns, ssh, http, dhcp, smtp, ftp
- Slack Incoming Webhook for real-time alerting
- Jira Cloud for incident ticket creation

Flow:
Windows VM → Splunk UF → Splunk Index (dns) → Dashboard → Alerts → Slack/Jira
