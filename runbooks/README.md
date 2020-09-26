# deps.cloud Runbooks

deps.cloud is composed of several backend systems.

- [Extractor](extractor/README.md) is a NodeJS gRPC server that handles the extraction of dependency information from manifest files.
- [Gateway](gateway/README.md) is a Golang HTTP/gRPC proxy that acts as an intermediary to the polyglot backend.
- [Tracker](tracker/README.md) is a Golang gRPC server that handles storing a dependency graph on top of SQL.

In addition to these components, there is an independent storage tier that needs to be configured and managed.
Due to the high-degree of variability, our runbooks focus on the core elements of deps.cloud.
