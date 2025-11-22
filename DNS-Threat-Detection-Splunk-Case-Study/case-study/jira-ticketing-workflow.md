# Jira Ticketing Workflow

Each alert triggers a Jira ticket containing:

- Alert name
- Source IP
- Suspicious domain
- Timestamp
- Evidence link
- Recommended analyst actions

Prefilled Jira link template:
https://yourjira.atlassian.net/secure/CreateIssueDetails!init.jspa?pid=KAN&issuetype=10001&summary=[DNS Alert] Suspicious Activity&description=SRC:%20$src_ip$%0ADomain:%20$domain$%0ATime:%20$time$
