# Panel: Suspicious TLD Lookup

## SPL
index=dns sourcetype=dns:log
| regex domain="\.xyz$|\.top$|\.cn$|\.ru$|\.work$"
| stats count by src_ip domain
