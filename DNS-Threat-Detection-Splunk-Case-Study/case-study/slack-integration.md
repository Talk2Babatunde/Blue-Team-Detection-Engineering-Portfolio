# Slack Integration

Slack notifications sent via incoming webhook.

Example payload:
{
  "text": "ALERT: Large DNS Query Detected",
  "attachments": [
    {"title": "Source IP", "text": "$result.src_ip$"},
    {"title": "Domain", "text": "$result.domain$"}
  ]
}

Webhook tested using:
scripts/slack_webhook_test.ps1
