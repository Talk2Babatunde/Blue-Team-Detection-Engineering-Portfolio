# Slack Webhook Integration

## Steps
1. Go to Slack → Apps → Create Incoming Webhook
2. Get the Webhook URL
3. Put it in Splunk Alert Actions
4. Use JSON payload:
{
  "text": "🚨 DNS Tunneling Detected: $result.domain$ from $result.src_ip$"
}

## Test Command:
curl -X POST -H 'Content-type: application/json' --data '{"text":"Test alert"}' <your_webhook>
