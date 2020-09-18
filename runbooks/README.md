# deps.cloud Runbooks

## General

deps.cloud is composed of several backend systems.

- Extractor is a NodeJS gRPC server that handles the extraction of dependency information from manifest files.
- Gateway is a Golang HTTP/gRPC proxy that acts as an intermediary to the polyglot backend.
- Tracker is a Golang gRPC server that handles storing a dependency graph on top of SQL.

## Dashboards

We currently provide a very rudamentary dashboard in grafana.
Further dashboard work TBD.

## Production outage scenarios

- Extractor
- Gateway
  - [Gateway not ready](gateway-notready.md)
- Tracker
  - [Tracker not ready](tracker-notready.md)
