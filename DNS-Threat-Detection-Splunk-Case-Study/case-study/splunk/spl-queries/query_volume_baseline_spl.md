# DNS Volume Baseline SPL

index=dns sourcetype=dns:log
| timechart span=1h count
| eventstats avg(count) as avg stdev(count) as stdev
| eval upper_bound = avg + (2 * stdev)
| eval lower_bound = avg - (2 * stdev)
