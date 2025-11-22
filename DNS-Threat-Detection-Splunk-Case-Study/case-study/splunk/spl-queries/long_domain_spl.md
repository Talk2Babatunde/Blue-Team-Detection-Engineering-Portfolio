# Long Domain Query SPL

index=dns sourcetype=dns:log
| eval domain_len=len(domain)
| where domain_len > 60
| table _time src_ip domain domain_len
