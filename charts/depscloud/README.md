# deps.cloud

deps.cloud is a tool to help understand how projects relate to one another.
It works by detecting dependencies defined in common [manifest files] (`pom.xml`, `package.json`, `go.mod`, etc).
Using this information, we’re able to answer questions about project dependencies.

* What versions of _k8s.io/client-go_ do we depend on?
* Which projects use _eslint_ as a non-dev dependency?
* What open source libraries do we use the most? 

[manifest files]: https://deps.cloud/docs/concepts/manifests/

## Introduction

This chart bootstraps the deps.cloud ecosystem on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.15+
- Helm 3.0+

## Installing the Chart

To install the chart with the release name `depscloud`:

```bash
$ helm repo add depscloud https://depscloud.github.io/deploy/charts
$ helm install depscloud depscloud/depscloud
```

The command deploys deps.cloud on the Kubernetes cluster in the default configuration.
The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm search repo --versions`

## Uninstalling the Chart

To uninstall/delete the `depscloud` deployment:

```bash
$ helm delete depscloud
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

The following table lists the configurable parameters of the Extractor chart and their default values.

| Parameter                                | Description                                                             | Default                       |
|------------------------------------------|-------------------------------------------------------------------------|-------------------------------|
| `global.labels`                          | Labels applied to all deps.cloud resources                              | `{}`                          |
| `global.service.topology`                | Provides control over the network topology for all deps.cloud resources | `[]`                          |
| `global.metrics.serviceMonitor.enabled`  | Enables Prometheus service monitors for all deps.cloud resources        | `false`                       |
| `global.metrics.serviceMonitor.interval` | The default interval metrics should be pulled on                        | `10s`                         |
| `mysql.enabled`                          | (optional) Deploy a copy of MySQL alongside deps.cloud                  | `false`                       |
| `postgres.enabled`                       | (optional) Deploy a copy of PostgreSQL alongside deps.cloud             | `false`                       |
| `extractor.enabled`                      | Whether the `extractor` process should be deployed                      | `true`                        |
| `extractor.*`                            | Set configuration for the `extractor` chart                             | See the `extractor` chart     |
| `gateway.enabled`                        | Whether the `gateway` process should be deployed                        | `true`                        |
| `gateway.*`                              | Set configuration for the `gateway` chart                               | See the `gateway` chart       |
| `indexer.enabled`                        | Whether the `indexer` process should be deployed                        | `true`                        |
| `indexer.*`                              | Set configuration for the `indexer` chart                               | See the `indexer` chart       |
| `tracker.enabled`                        | Whether the `tracker` process should be deployed                        | `true`                        |
| `tracker.*`                              | Set configuration for the `tracker` chart                               | See the `tracker` chart       |
