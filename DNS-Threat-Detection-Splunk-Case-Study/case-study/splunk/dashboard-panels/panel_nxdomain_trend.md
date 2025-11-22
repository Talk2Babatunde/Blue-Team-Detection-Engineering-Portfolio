# Panel: NXDOMAIN Trend

## SPL
index=dns sourcetype=dns:log response_code="NXDOMAIN"
| timechart span=10m count

## Why It Matters
- Detect DGA malware
- Detect DNS misconfiguration
