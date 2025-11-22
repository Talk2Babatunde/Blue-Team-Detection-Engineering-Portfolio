# Alert: Possible DNS Tunneling Detected

## SPL
index=dns sourcetype=dns:log
| eval domain_len=len(domain)
| where domain_len > 60
| stats count by src_ip domain domain_len

## Trigger Condition
- More than 10 long-domain queries per 5 minutes

## Actions
- Send Slack Webhook Alert
- Auto-create Jira Ticket
- Email SOC Mailbox
