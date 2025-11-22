# NXDOMAIN Spike SPL

index=dns sourcetype=dns:log response_code="NXDOMAIN"
| timechart span=5m count as nxdomain_count
| eventstats avg(nxdomain_count) as avg stdev(nxdomain_count) as stdev
| eval threshold = avg + (3 * stdev)
| where nxdomain_count > threshold
