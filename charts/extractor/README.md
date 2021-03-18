# Extractor

Extractor is one component of the [deps.cloud](https://deps.cloud) ecosystem.
It handles matching, parsing, and extracting dependency information from manifest files (like `package.json`, `pom.xml`, etc).

## Introduction

This chart bootstraps a extractor deployment on a [Kubernetes] cluster using the [Helm] package manager.

[kubernetes]: https://kubernetes.io
[helm]: https://helm.sh

Current chart version is `0.3.0`

## Source Code

- <https://github.com/depscloud/depscloud>
- <https://github.com/depscloud/deploy>

## Prerequisites

- Kubernetes 1.15+
- Helm 3.0+

## Installing the Chart

To install the chart with the release name `extractor`:

```bash
$ helm repo add depscloud https://depscloud.github.io/deploy/charts
$ helm install extractor depscloud/extractor
```

The command deploys extractor on the Kubernetes cluster using the default configuration.
The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm search repo --versions`

## Uninstalling the Chart

To uninstall/delete the `extractor` deployment:

```bash
$ helm delete extractor
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

The following table lists the configurable parameters of the extractor chart and their default values.

| Key                                        | Type   | Default                        | Description                                                                                                                                                 |
| ------------------------------------------ | ------ | ------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| affinity                                   | object | `{}`                           |                                                                                                                                                             |
| autoscaling.enabled                        | bool   | `false`                        | Enable autoscaling.                                                                                                                                         |
| autoscaling.maxReplicas                    | int    | `5`                            | The maximum number of replicas allowed.                                                                                                                     |
| autoscaling.minReplicas                    | int    | `1`                            | The minimum number of replicas to maintain.                                                                                                                 |
| autoscaling.targetCPUUtilizationPercentage | int    | `80`                           | The target CPU utilization threshold when autoscaling is triggered.                                                                                         |
| disabledManifests                          | list   | `[]`                           | Turn specific manifests off.                                                                                                                                |
| fullnameOverride                           | string | `""`                           |                                                                                                                                                             |
| global.labels                              | object | `{}`                           | Common labels added to all resources.                                                                                                                       |
| global.metrics.serviceMonitor.enabled      | bool   | `false`                        | Create a Prometheus ServiceMonitor.                                                                                                                         |
| global.metrics.serviceMonitor.interval     | string | `"10s"`                        | Configure the scrape interval used by the monitor.                                                                                                          |
| global.service.topology                    | list   | `[]`                           | Configure the routing topology. Requires ServiceTopology feature gate and ClusterIP.                                                                        |
| image.pullPolicy                           | string | `"IfNotPresent"`               |                                                                                                                                                             |
| image.repository                           | string | `"ocr.sh/depscloud/extractor"` |                                                                                                                                                             |
| image.tag                                  | string | `""`                           |                                                                                                                                                             |
| imagePullSecrets                           | list   | `[]`                           |                                                                                                                                                             |
| labels                                     | object | `{}`                           | Labels added to all resources. These are joined with the global configuration for the deployment.                                                           |
| metrics.dashboard.enabled                  | bool   | `false`                        | Enables the creation of the dashboard config map.                                                                                                           |
| metrics.dashboard.namespace                | string | `""`                           | Specify what namespace the config map should be deployed to. This may differ from your application configuration. Defaults to the namespace of the release. |
| metrics.dashboard.sidecar.label            | string | `"grafana_dashboard"`          | The label used by the sidecar to select the dashboard.                                                                                                      |
| metrics.serviceMonitor.enabled             | bool   | `false`                        | Create a Prometheus ServiceMonitor.                                                                                                                         |
| metrics.serviceMonitor.interval            | string | `"10s"`                        | Configure the scrape interval used by the monitor.                                                                                                          |
| nameOverride                               | string | `""`                           |                                                                                                                                                             |
| nodeSelector                               | object | `{}`                           |                                                                                                                                                             |
| podAnnotations                             | object | `{}`                           | Annotations for the pod.                                                                                                                                    |
| podSecurityContext                         | object | `{}`                           |                                                                                                                                                             |
| replicaCount                               | int    | `1`                            | The number of instances to run.                                                                                                                             |
| resources                                  | object | `{}`                           | Configure the resources allocated to the process.                                                                                                           |
| securityContext                            | object | `{}`                           |                                                                                                                                                             |
| service.annotations                        | object | `{}`                           | Specify any annotations to add to the service.                                                                                                              |
| service.topology                           | list   | `[]`                           | Configure the routing topology. Requires ServiceTopology feature gate and ClusterIP.                                                                        |
| service.type                               | string | `"Headless"`                   | Configure the service type to use.                                                                                                                          |
| serviceAccount.automountToken              | bool   | `false`                        | Determine pods should automount the token.                                                                                                                  |
| serviceAccount.create                      | bool   | `true`                         | Specifies whether a service account should be created.                                                                                                      |
| serviceAccount.name                        | string | `""`                           | The name of the service account to use. If not set and create is true, a name is generated using the fullname template                                      |
| tls.secretName                             | string | `""`                           | Configure mTLS for the gateway. The secret needs 3 keys: `tls.crt`, `tls.key`, and `ca.crt`.                                                                |
| tolerations                                | list   | `[]`                           |                                                                                                                                                             |
