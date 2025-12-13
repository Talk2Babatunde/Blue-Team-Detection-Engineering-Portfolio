HTTP logs were ingested through Splunk Universal Forwarder into index=http and sourcetype=HTTP_Threat_Detection.

Field extraction included:
- clientip
- http_method
- uri
- status
- user_agent

Regex-based extractions were applied using Splunk's 'rex' command. Clean fields improve detection accuracy and dashboard readability.

