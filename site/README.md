# deps.cloud deployment configuration

[![Artifact HUB](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/depscloud)](https://artifacthub.io/packages/search?repo=depscloud)
![license](https://img.shields.io/github/license/depscloud/deploy.svg)

Please see our [documentation](https://deps.cloud/docs/deploy) for proper use.

### Kubernetes Manifests

```bash
$ kubectl apply -f https://depscloud.github.io/deploy/k8s/depscloud.yaml
```

* [depscloud](/k8s/depscloud.yaml)
* [mysql](/k8s/mysql.yaml)
* [postgres](/k8s/postgres.yaml)

### Helm

```bash
$ helm repo add depscloud https://depscloud.github.io/deploy/charts
"depscloud" has been added to your repositories
```

* [ArtifactHub](https://artifacthub.io/packages/search?page=1&ts_query_web=depscloud)

### Grafana Dashboards

* [extractor](/monitoring/depscloud-extractor-grafana.json)
* [gateway](/monitoring/depscloud-gateway-grafana.json)
* [indexer](/monitoring/depscloud-indexer-grafana.json)
* [tracker](/monitoring/depscloud-tracker-grafana.json)
