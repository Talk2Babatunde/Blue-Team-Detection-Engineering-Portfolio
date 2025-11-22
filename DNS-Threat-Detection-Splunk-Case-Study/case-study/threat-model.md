# DNS Threat Model

This project focuses on threats commonly observed in DNS layers:

## Key DNS Threats
- DNS Tunneling (data exfiltration)
- DGA-based malware callbacks
- High-frequency beaconing
- Suspicious TLD lookups
- NXDOMAIN spikes
- Misconfigured or malicious DNS clients

## Adversary Objectives
- Evade traditional firewalls
- Maintain covert C2 channels
- Randomized domain pivoting (DGA)
- Leak data through DNS query fields

## Detection Focus
The detections in this project target behavior, not signatures, enabling discovery of zero-day DNS abuse patterns.
