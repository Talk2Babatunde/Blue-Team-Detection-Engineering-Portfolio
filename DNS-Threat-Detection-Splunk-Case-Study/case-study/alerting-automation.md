# Alerting & Automation

This project includes 4 Splunk alerts:

1. Large DNS Query Length (Tunneling)
2. NXDOMAIN Spike Detection
3. Suspicious TLD Detection
4. High-Frequency Domain Queries

Alert actions:
- Email notifications
- Slack incoming webhook JSON payload
- Jira ticket auto-generation using prefilled URL parameters

Alert definitions stored in:
splunk/saved-searches/dns_alerts.conf