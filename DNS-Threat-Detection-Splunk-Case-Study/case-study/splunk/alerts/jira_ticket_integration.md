# Jira Automated Ticketing

## Steps
1. Go to Jira Cloud → API Tokens
2. Base64 encode: email:token
3. Use alert webhook (POST)
4. Sample JSON:
{
 "fields": {
   "project": { "key": "SOC" },
   "summary": "DNS Tunneling Detected",
   "description": "Suspicious domain: $result.domain$",
   "issuetype": { "name": "Incident" }
 }
}
