# Gateway not ready

The gateway can become unhealthy if it is unable to communicate with the extractor or tracker.
Without those services, the gateway can only perform a subset of work.

## Symptoms

The gateway process does not appear to be running or handling traffic from end user requests.

### Context

The gateway process acts as an intermediary to the backend gRPC services.
It provides both HTTP 1.1 interfaces via REST anbd gRPC support as a thin proxy.
Without the gateway, end users are unable to query the graph for information.

### Troubleshooting

Unlike the other gRPC services, Gateway provides a `/healthz` endpoint that can provide some initial troubleshooting.
This will provide some JSON that describes which checks in the system seem to be failing.
These mostly test the read-only endpoints that do not manipulate or mutate data.

If the health check shows everything is OK, then the system should be stable.
Otherwise, further investigation into appropriate services are required.

## Remediation Steps

_Faiure of the `extraction` check_

If gateway cannot perform an extraction logic, there is likely an issue with the configuration for the extractor process.
Check and ensure the extractor process is configured appropriately.

_Faiure of the `modules` check_

If gateway cannot lookup modules, there is likely an issue with the configuration for the tracker process.
Check and ensure the tracker process is configured appropriately.

_Faiure of the `sources` check_

If gateway cannot lookup sources, there is likely an issue with the configuration for the tracker process.
Check and ensure the tracker process is configured appropriately.

## Next Steps

If the gateway appears to be configured properly and able to reach the backend services, you may need to further investigate dependent systems.

- [Tracker not ready](tracker-notready.md)
