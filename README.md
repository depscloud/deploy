# deps.cloud deployment configuration

![license](https://img.shields.io/github/license/depscloud/deploy.svg)
[![license check](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fdepscloud%2Fdeploy.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Fdepscloud%2Fdeploy?ref=badge_shield)

This repository contains deployment configuration for the deps.cloud ecosystem.

## Docker

Docker is great for trying the project out or for active development.
I do not recommend using the docker configuration in this repository for production deployments.

* [CockroachDB](docker/cockroachdb/)
* [MariaDB](docker/mariadb/)
* [MySQL](docker/mysql/)
* [PostgreSQL](docker/postgres/)
* [SQLite](docker/sqlite/)

## Kubernetes

* [ArgoCD](https://github.com/depscloud/deploy/tree/main/examples/argocd)
* FluxCD's [HelmOperator](https://github.com/depscloud/deploy/tree/main/examples/helm-operator)
* [Helm](https://github.com/depscloud/deploy/tree/main/examples/helm)
* [Raw Manifests](https://deps.cloud/docs/deployment/k8s/)

## Helm

The canonical source for Helm charts is the [Helm Hub](https://hub.helm.sh/), an aggregator for distributed chart repos.

This GitHub project is the source for the `depscloud` [Helm chart repository](https://v3.helm.sh/docs/topics/chart_repository/).

For more information about installing and using Helm, see the [Helm Docs](https://helm.sh/docs/).
For a quick introduction to Charts, see the [Chart Guide](https://helm.sh/docs/topics/charts/).

### How do I install these charts?

```
$ helm repo add depscloud https://depscloud.github.io/deploy/charts
"depscloud" has been added to your repositories
```

# Support

Join our [mailing list] to get access to virtual events and ask any questions there.

We also have a [Slack] channel.

[mailing list]: https://groups.google.com/a/deps.cloud/forum/#!forum/community/join
[Slack]: https://depscloud.slack.com/join/shared_invite/zt-fd03dm8x-L5Vxh07smWr_vlK9Qg9q5A

## Branch Checks

![branch](https://github.com/depscloud/deploy/workflows/branch/badge.svg?branch=main)

## Release Checks

![branch](https://github.com/depscloud/deploy/workflows/branch/badge.svg?branch=prod)
![GitHub Pages](https://img.shields.io/github/deployments/depscloud/deploy/github-pages?label=GitHub%20Pages)

## License Checks

[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fdepscloud%2Fdeploy.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2Fdepscloud%2Fdeploy?ref=badge_large)
![Google Analytics](https://www.google-analytics.com/collect?v=1&cid=555&t=pageview&ec=repo&ea=open&dp=deploy&dt=deploy&tid=UA-143087272-2)
