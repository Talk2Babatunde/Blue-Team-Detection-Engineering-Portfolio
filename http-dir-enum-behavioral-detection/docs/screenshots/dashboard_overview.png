HTTP Threat Dashboard – High-Risk Source IP Overview
This view summarizes HTTP traffic by source IP, highlighting abnormal request volume, high unique URI counts, and suspicious HTTP methods. It allows SOC analysts to quickly identify potential reconnaissance activity and prioritize investigation based on behavioral indicators.


{
  "title": "HTTP Threat Detection – SOC Analysis Dashboard",
  "description": "SOC dashboard for detecting reconnaissance, follow-on attacks, and triage decisions from HTTP logs",
  "panels": [
    {
      "title": "High-Risk Source IP Overview",
      "type": "table",
      "search": {
        "query": "index=http sourcetype=HTTP_Threat_Detection | rex field=_raw \"^(?<clientip>\\d{1,3}(?:\\.\\d{1,3}){3})\" | rex field=_raw \"\\s(?<http_method>GET|POST|HEAD)\\s\" | rex field=_raw \"\\s(?<uri>/[^\\s]*)\" | rex field=_raw \"\\s(?<status>\\d{3})\\s\" | stats count as total_requests dc(uri) as unique_uris values(http_method) as methods values(status) as status_codes by clientip | where total_requests > 50 | sort - total_requests"
      }
    },
    {
      "title": "Follow-On Attack Analysis",
      "type": "table",
      "search": {
        "query": "index=http sourcetype=HTTP_Threat_Detection | rex field=_raw \"^(?<clientip>\\d{1,3}(?:\\.\\d{1,3}){3})\" | rex field=_raw \"\\s(?<http_method>GET|POST|HEAD)\\s\" | rex field=_raw \"\\s(?<uri>/[^\\s]*)\" | rex field=_raw \"\\s(?<status>\\d{3})\\s\" | eval attack_phase=case(http_method=\"HEAD\" AND status=404,\"Reconnaissance\", http_method=\"GET\" AND status=404,\"Enumeration\", http_method=\"POST\" AND like(uri,\"/login%\"),\"Authentication Attempt\") | stats count as request_count by clientip attack_phase uri status | sort - request_count"
      }
    },
    {
      "title": "SOC Triage Decision Table",
      "type": "table",
      "search": {
        "query": "index=http sourcetype=HTTP_Threat_Detection | rex field=_raw \"^(?<clientip>\\d{1,3}(?:\\.\\d{1,3}){3})\" | rex field=_raw \"\\s(?<http_method>GET|POST|HEAD)\\s\" | rex field=_raw \"\\s(?<uri>/[^\\s]*)\" | rex field=_raw \"\\s(?<status>\\d{3})\\s\" | stats count as total_requests dc(uri) as unique_uris values(http_method) as methods values(status) as status_codes by clientip | eval triage_decision=case(match(methods,\"HEAD\") AND match(methods,\"POST\"),\"Pre-Exploitation Activity\", match(methods,\"HEAD\"),\"Reconnaissance Only\", match(methods,\"POST\"),\"Authentication Abuse\") | table clientip total_requests unique_uris methods status_codes triage_decision | sort - total_requests"
      }
    }
  ]
}
