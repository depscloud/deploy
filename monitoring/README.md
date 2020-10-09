
### Scratch notes

Useful cheatsheet for grpc status codes: https://grpc.github.io/grpc/cpp/md_doc_http-grpc-status-mapping.html

Availability

```
sum(rate(grpc_server_handled_total{grpc_code!="Unavailable",grpc_code!="Unknown",JOB_FILTER}[30d])) /
sum(rate(grpc_server_handled_total{JOB_FILTER}[30d]))
```

SLIs

requests:
sum(rate(grpc_server_handled_total{JOB_FILTER}[5m])) by (grpc_service, grpc_method)

error rates:
sum(rate(grpc_server_handled_total{grpc_code="Unavailable",JOB_FILTER}[5m])) by (grpc_service, grpc_method) /
sum(rate(grpc_server_handled_total{JOB_FILTER}[5m])) by (grpc_service, grpc_method)

duration:
histogram_quantile(0.95, sum(rate(grpc_server_handling_seconds_bucket{JOB_FILTER}[5m])) by (le,grpc_service,grpc_method))


Dashboards:
- overview
    - availability
    - links out to other dashboards
- indexer
    - failures at stage
    - cpu, memory, goroutines
- extractor
    - availability
    - slis
    - cpu, memory, eventloop lag (p90,p99)
- tracker
    - availability
    - slis
    - cpu, memory, goroutines
- gateway
    - availability
    - slis
    - cpu, memory, goroutines

