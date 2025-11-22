# Panel: DNS Query Volume Over Time

## Purpose
Shows overall DNS activity to establish baselines and identify spikes.

## SPL
index=dns sourcetype=dns:log
| timechart span=5m count as query_volume

## Visualization
Line Chart

## Why It Matters
- Detects anomalies in traffic
- Helps identify beaconing, malware, brute-force resolution
- Used as a baseline for other detections
