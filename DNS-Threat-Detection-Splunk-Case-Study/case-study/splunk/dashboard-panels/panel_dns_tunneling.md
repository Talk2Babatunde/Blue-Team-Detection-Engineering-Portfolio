# Panel: Long Domain Query Detector (DNS Tunneling)

## SPL
index=dns sourcetype=dns:log
| eval domain_len=len(domain)
| where domain_len > 60
| stats count by src_ip domain domain_len
