# deps.cloud

[deps.cloud] is a tool to help understand how projects relate to one another.
It works by detecting dependencies defined in common [manifest files] (`pom.xml`, `package.json`, `go.mod`, etc).
Using this information, we’re able to answer questions about project dependencies.

- What versions of _k8s.io/client-go_ do we depend on?
- Which projects use _eslint_ as a non-dev dependency?
- What open source libraries do we use the most?

[deps.cloud]: https://deps.cloud
[manifest files]: https://deps.cloud/docs/concepts/manifests/

## Introduction

This chart bootstraps a depscloud deployment on a [Kubernetes] cluster using the [Helm] package manager.

[kubernetes]: https://kubernetes.io
[helm]: https://helm.sh

Current chart version is `0.2.32`

## Source Code

- <https://github.com/depscloud/depscloud>
- <https://github.com/depscloud/deploy>

## Prerequisites

- Kubernetes 1.15+
- Helm 3.0+

## Installing the Chart

To install the chart with the release name `depscloud`:

```bash
$ helm repo add depscloud https://depscloud.github.io/deploy/charts
$ helm install depscloud depscloud/depscloud
```

The command deploys depscloud on the Kubernetes cluster using the default configuration.
The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm search repo --versions`

## Uninstalling the Chart

To uninstall/delete the `depscloud` deployment:

```bash
$ helm delete depscloud
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Requirements

| Repository                         | Name       | Version |
| ---------------------------------- | ---------- | ------- |
| file://../extractor                | extractor  | 0.2.32  |
| file://../gateway                  | gateway    | 0.2.32  |
| file://../indexer                  | indexer    | 0.2.32  |
| file://../tracker                  | tracker    | 0.2.32  |
| https://charts.bitnami.com/bitnami | mysql      | 7.1.0   |
| https://charts.bitnami.com/bitnami | postgresql | 9.8.12  |
| https://mjpitz.github.io/charts/   | beacon     | 0.0.2   |

## Parameters

The following table lists the configurable parameters of the depscloud chart and their default values.

| Key                                    | Type   | Default            | Description                                                                                                                                                                                                  |
| -------------------------------------- | ------ | ------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| beacon.config.applicationName          | string | `"depscloud"`      | Preconfigured.                                                                                                                                                                                               |
| beacon.config.applicationVersion       | string | `"0.2.32"`         | Preconfigured.                                                                                                                                                                                               |
| beacon.config.trackingID               | string | `"UA-143087272-3"` | Preconfigured.                                                                                                                                                                                               |
| beacon.config.userID                   | string | `""`               | Currently unsupported.                                                                                                                                                                                       |
| beacon.enabled                         | bool   | `true`             | Deploy a beacon for version reporting. See comment in `values.yaml` for more information.                                                                                                                    |
| extractor.enabled                      | bool   | `true`             | Deploy the extractor process.                                                                                                                                                                                |
| gateway.enabled                        | bool   | `true`             | Deploy the gateway process.                                                                                                                                                                                  |
| gateway.extractor.address              | string | `""`               | Configures the connection string for the extractor.                                                                                                                                                          |
| gateway.tracker.address                | string | `""`               | Configures the connection string for the tracker.                                                                                                                                                            |
| global.labels                          | object | `{}`               | Common labels added to all resources.                                                                                                                                                                        |
| global.metrics.serviceMonitor.enabled  | bool   | `false`            | Create a Prometheus ServiceMonitor.                                                                                                                                                                          |
| global.metrics.serviceMonitor.interval | string | `"10s"`            | Configure the scrape interval used by the monitor.                                                                                                                                                           |
| global.service.topology                | list   | `[]`               | Configure the routing topology. Requires ServiceTopology feature gate and ClusterIP.                                                                                                                         |
| indexer.enabled                        | bool   | `true`             | Deploy the indexer process.                                                                                                                                                                                  |
| indexer.extractor.address              | string | `""`               | Configures the connection string for the extractor.                                                                                                                                                          |
| indexer.schedule                       | string | `""`               | When `""`, the indexer will run as a one-time job. Otherwise, it will run on the specified cron schedule.                                                                                                    |
| indexer.tracker.address                | string | `""`               | Configures the connection string for the tracker.                                                                                                                                                            |
| ingress.annotations                    | object | `{}`               | Specify any ingress-controller specific annotations. The CLI requires gRPC to work properly. Be sure your networking stack supports it. Should you need help for your provider, don't hesitate to reach out. |
| ingress.backend.serviceName            | string | `""`               | The name of the service to target. Defaults to "{{ .Release.Name }}-gateway".                                                                                                                                |
| ingress.backend.servicePort            | string | `"http"`           | The port to target.                                                                                                                                                                                          |
| ingress.enabled                        | bool   | `false`            | Expose depscloud using an ingress controller. Must support gRPC.                                                                                                                                             |
| ingress.hosts                          | list   | `[]`               |                                                                                                                                                                                                              |
| ingress.tls                            | list   | `[]`               |                                                                                                                                                                                                              |
| mysql.enabled                          | bool   | `false`            | Deploy a copy of MySQL alongside deps.cloud. Useful for quick testing. Not recommended for production.                                                                                                       |
| postgres.enabled                       | bool   | `false`            | Deploy a copy of PostgreSQL alongside deps.cloud. Useful for quick testing. Not recommended for production.                                                                                                  |
| tracker.enabled                        | bool   | `true`             | Deploy and configure the tracker process.                                                                                                                                                                    |
