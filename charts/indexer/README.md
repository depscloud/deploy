# Indexer

Indexer crawls version control providers supported by the [deps.cloud](https://deps.cloud) ecosystem.
It's responsible for discovering, cloning, and crawling repositories and their content.

## Introduction

This chart bootstraps an indexer deployment on a [Kubernetes] cluster using the [Helm] package manager.

[kubernetes]: https://kubernetes.io
[helm]: https://helm.sh

Current chart version is `0.3.5`

## Source Code

- <https://github.com/depscloud/depscloud>
- <https://github.com/depscloud/deploy>

## Prerequisites

- Kubernetes 1.15+
- Helm 3.0+

## Installing the Chart

To install the chart with the release name `indexer`:

```bash
$ helm repo add depscloud https://depscloud.github.io/deploy/charts
$ helm install indexer depscloud/indexer
```

The command deploys indexer on the Kubernetes cluster using the default configuration.
The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm search repo --versions`

## Uninstalling the Chart

To uninstall/delete the `indexer` deployment:

```bash
$ helm delete indexer
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

The following table lists the configurable parameters of the indexer chart and their default values.

| Key                              | Type   | Default                                                                       | Description                                                                                                                                                 |
| -------------------------------- | ------ | ----------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| affinity                         | object | `{}`                                                                          |                                                                                                                                                             |
| config                           | object | `{"accounts":[{"github":{"organizations":["depscloud"],"strategy":"HTTP"}}]}` | Configure the accounts to index. See [the documentation](https://deps.cloud/docs/deploy/config/indexing/) for more information.                             |
| externalConfig.configMapRef.name | string | `""`                                                                          | The name of the config map containing the `config.yaml` file.                                                                                               |
| externalConfig.secretRef.name    | string | `""`                                                                          | The name of the secret containing the `config.yaml` file.                                                                                                   |
| extractor.address                | string | `"dns:///extractor:8090"`                                                     | Configures the connection string for the extractor.                                                                                                         |
| extractor.secretName             | string | `""`                                                                          | Configures mTLS for the extractor. The secret needs 3 keys: `tls.crt`,                                                                                      |
| fullnameOverride                 | string | `""`                                                                          |                                                                                                                                                             |
| global.labels                    | object | `{}`                                                                          | Common labels added to all resources.                                                                                                                       |
| image.pullPolicy                 | string | `"IfNotPresent"`                                                              |                                                                                                                                                             |
| image.repository                 | string | `"img.pitz.tech/depscloud/indexer"`                                           |                                                                                                                                                             |
| image.tag                        | string | `""`                                                                          |                                                                                                                                                             |
| imagePullSecrets                 | list   | `[]`                                                                          |                                                                                                                                                             |
| labels                           | object | `{}`                                                                          | Labels added to all resources. These are joined with the global configuration for the deployment.                                                           |
| metrics.dashboard.enabled        | bool   | `false`                                                                       | Enables the creation of the dashboard config map.                                                                                                           |
| metrics.dashboard.namespace      | string | `""`                                                                          | Specify what namespace the config map should be deployed to. This may differ from your application configuration. Defaults to the namespace of the release. |
| metrics.dashboard.sidecar.label  | string | `"grafana_dashboard"`                                                         | The label used by the sidecar to select the dashboard.                                                                                                      |
| nameOverride                     | string | `""`                                                                          |                                                                                                                                                             |
| nodeSelector                     | object | `{}`                                                                          |                                                                                                                                                             |
| podAnnotations                   | object | `{}`                                                                          | Annotations for the pod.                                                                                                                                    |
| podSecurityContext               | object | `{}`                                                                          |                                                                                                                                                             |
| resources                        | object | `{}`                                                                          | Configure the resources allocated to the process.                                                                                                           |
| schedule                         | string | `"@daily"`                                                                    | The schedule to run on. If not set, then the indexer will run as a job instead of on a recurring schedule.                                                  |
| securityContext                  | object | `{}`                                                                          |                                                                                                                                                             |
| serviceAccount.automountToken    | bool   | `false`                                                                       | Determine pods should automount the token.                                                                                                                  |
| serviceAccount.create            | bool   | `true`                                                                        | Specifies whether a service account should be created.                                                                                                      |
| serviceAccount.name              | string | `""`                                                                          | The name of the service account to use. If not set and create is true, a name is generated using the fullname template                                      |
| tolerations                      | list   | `[]`                                                                          |                                                                                                                                                             |
| tracker.address                  | string | `"dns:///tracker:8090"`                                                       | Configures the connection string for the tracker.                                                                                                           |
| tracker.secretName               | string | `""`                                                                          | Configures mTLS for the tracker. The secret needs 3 keys: `tls.crt`,                                                                                        |
| workers                          | int    | `5`                                                                           | The number of worker threads to index repositories.                                                                                                         |
