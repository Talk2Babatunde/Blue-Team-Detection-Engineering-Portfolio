# Beaconing Detection SPL

index=dns sourcetype=dns:log
| stats count dc(src_ip) by domain
| where count > 3000
| sort - count
