# Alert: NXDOMAIN Spike Detected

## SPL
index=dns sourcetype=dns:log response_code="NXDOMAIN"
| timechart span=10m count
| eventstats avg(count) as baseline stdev(count) as sd
| eval threshold = baseline + (3 * sd)
| where count > threshold

## Why Trigger?
DGA / Malware Botnet trying randomized domains.
