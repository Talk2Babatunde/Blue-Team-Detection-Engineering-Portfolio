# DNS Tunneling Detection SPL

index=dns sourcetype=dns:log
| eval domain_length=len(domain)
| where domain_length > 50
| stats count avg(domain_length) by src_ip domain
| sort - avg(domain_length)
