# DNS General Hunt Queries

## Top talkers
index=dns sourcetype=dns:log
| top src_ip limit=20

## Top domains
index=dns sourcetype=dns:log
| top domain limit=50

## Most queried TLDs
index=dns sourcetype=dns:log
| rex field=domain "\.(?<tld>[^.]+)$"
| top tld

## Pivot by IP
index=dns sourcetype=dns:log src_ip="X.X.X.X"
| stats count by domain
