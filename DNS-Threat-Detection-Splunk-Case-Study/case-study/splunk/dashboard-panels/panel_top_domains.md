# Panel: Top Queried Domains

## SPL
index=dns sourcetype=dns:log
| top limit=20 domain

## Visualization
Bar Chart

## Use Cases
- Detect trending malicious domains
- Identify unusual domains with high traffic
