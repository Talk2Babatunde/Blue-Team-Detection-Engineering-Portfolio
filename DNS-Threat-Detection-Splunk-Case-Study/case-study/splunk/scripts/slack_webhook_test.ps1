# Define the webhook URL
$webhookUrl = "https://your-webhook-endpoint.com/hook"

# Create a sample DNS log payload
$dnsLog = @{
    Timestamp = (Get-Date).ToString("o")
    ClientIP = "192.168.1.100"
    QueryName = "example.com"
    QueryType = "A"
    ResponseCode = "NOERROR"
    Action = "ALLOW"
} | ConvertTo-Json

# Send the payload to the webhook
Invoke-RestMethod -Uri $webhookUrl -Method Post -Body $dnsLog -ContentType "application/json"

Write-Host "Webhook test payload sent."
