# Indexer

Indexer crawls integrations supported by the [deps.cloud](https://deps.cloud) ecosystem.
It's responsible for cloning repositories and crawling their content.

## Introduction

This chart bootstraps an indexer cron on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.16+
- Helm 3.0+

## Installing the Chart

To install the chart with the release name `indexer`:

```bash
$ helm repo add depscloud https://depscloud.github.io/deploy/charts
$ helm install indexer depscloud/indexer
```

The command deploys indexer on the Kubernetes cluster in the default configuration.
The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm search repo --versions`

## Uninstalling the Chart

To uninstall/delete the `indexer` deployment:

```bash
$ helm delete indexer
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

The following table lists the configurable parameters of the indexer chart.

| Parameter                                | Description                                                     | Default                                |
|------------------------------------------|-----------------------------------------------------------------|----------------------------------------|
| `global.labels`                          | Labels applied to all deps.cloud resources                      | `{}`                                   |
| `image.repository`                       | The address of the registry hosting the image                   | `depscloud/indexer`                    |
| `image.pullPolicy`                       | The pull policy for the image                                   | `IfNotPresent`                         |
| `image.tag`                              | The version of the image                                        | `.Chart.AppVersion`                    |
| `imagePullSecrets`                       | Registry secret names                                           | `[]`                                   |
| `nameOverride`                           | String to partially override the full name template             | `""`                                   |
| `fullnameOverride`                       | String to completely override the full name                     | `""`                                   |
| `serviceAccount.create`                  | Whether or not a service account should be created              | `true`                                 |
| `serviceAccount.automountToken`          | Should we mount the service account token                       | `false`                                |
| `serviceAccount.name`                    | The name of the service account                                 | `""`                                   |
| `podSecurityContext`                     | Provide any pod security context attributes                     | `{}`                                   |
| `securityContext`                        | Provide any security context attributes                         | `{}`                                   |
| `resources`                              | Any resource constraints to place on the container              | `{}`                                   |
| `nodeSelector`                           | Target the deployment to a certain class of nodes               | `{}`                                   |
| `tolerations`                            | Identify any taints the process can tolerate                    | `[]`                                   |
| `affinity`                               | Set up an an affinity based on attributes                       | `{}`                                   |
| `extractor.address`                      | The address of the extractor process                            | `"{{ .Release.Name }}-extractor:8090"` |
| `extractor.secretName`                   | The name of the secret containing certificates to the extractor | `""`                                   |
| `tracker.address`                        | The address of the tracker process                              | `"{{ .Release.Name }}-tracker:8090"`   |
| `tracker.secretName`                     | The name of the secret containing certificates to the tracker   | `""`                                   |
| `workers`                                | The number of worker threads cloning and indexing repositories  | `5`                                    |
| `config`                                 | YAML containing the configuration for the various accounts      | `{}`                                   |
| `labels`                                 | Labels applied to the gateway resources                         | `{}`                                   |
