# DNS Field Map

src_ip      → Client that issued DNS request  
domain      → Queried domain  
tld         → Extracted using rex  
query_type  → A, AAAA, TXT  
response_code → NXDOMAIN, SERVFAIL, NOERROR  
