LATEST_VERSION=$(shell (curl -sSL https://api.github.com/repos/depscloud/depscloud/releases/latest | jq -r .tag_name | cut -c 2-))

CHART_REPOSITORY_URL = "https://depscloud.github.io/deploy"
REPOSITORY_URL = "https://github.com/depscloud/deploy.git"

all: public/monitoring public/charts public/k8s public/index.html

clean:
	rm -rf public

build-deps:
	go get -u github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb
	go get -u github.com/google/go-jsonnet/cmd/jsonnet
	go get -u github.com/gomarkdown/mdtohtml

public:
	git clone -q --depth 1 -b gh-pages $(REPOSITORY_URL) public

public/charts: public .public/charts
.public/charts:
	@echo "[charts] linting templates"
	@ls -1 charts/ | xargs -I{} helm lint charts/{}

	@echo "[charts] updating dependencies"
	@ls -1 charts/ | xargs -I{} helm dependency update charts/{} 1>/dev/null

	@echo "[charts] packaging"
	@ls -1 charts/ | xargs -I{} helm package charts/{} -d public/charts/ 1>/dev/null

	@echo "[charts] indexing"
	@helm repo index public/charts/ --url "$(CHART_REPOSITORY_URL)/charts"

public/k8s: public .public/k8s
.public/k8s:
	@helm repo add bitnami https://charts.bitnami.com/bitnami 1>/dev/null
	@helm repo update 1>/dev/null

	@echo "[k8s] generating mysql.yaml"
	@helm template mysql bitnami/mysql \
		--version 6.14.4 \
		--set db.user=user \
		--set db.password=password \
		--set db.name=depscloud \
		--set volumePermissions.enabled=true \
		>> "public/k8s/mysql.yaml"

	@echo "[k8s] generating postgres.yaml"
	@helm template postgresql bitnami/postgresql \
		--version 8.10.10 \
		--set postgresqlUsername=user \
		--set postgresqlPassword=password \
		--set postgresqlDatabase=depscloud \
		>> "public/k8s/postgres.yaml"

	@echo "[k8s] generating depscloud.yaml"
	@helm template depscloud ./charts/depscloud/ \
		--set indexer.externalConfig.secretRef.name="depscloud-indexer" \
		--set tracker.externalStorage.secretRef.name="depscloud-tracker" \
		>> "public/k8s/depscloud.yaml"

	@echo "[k8s] generating depscloud-system.yaml"
	@helm template depscloud ./charts/depscloud/ \
		--set indexer.externalConfig.secretRef.name="depscloud-indexer" \
		--set tracker.externalStorage.secretRef.name="depscloud-tracker" \
		>> "public/k8s/depscloud-system.yaml"

public/monitoring: public .public/monitoring
.public/monitoring:
	@mkdir -p public/monitoring/
	@echo "[monitoring] generating alerts, dashboards, and rules"
	@cd monitoring && jb install 1>/dev/null && make alerts dashboards rules 1>/dev/null
	@cp monitoring/out/* public/monitoring/

.sync-chart:
	@yq w -i ./charts/$(CHART_NAME)/Chart.yaml version $(LATEST_VERSION)
	@yq w -i ./charts/$(CHART_NAME)/Chart.yaml appVersion $(LATEST_VERSION)
	@yq w -i ./charts/depscloud/Chart.yaml "dependencies.(name==$(CHART_NAME)).version"  $(LATEST_VERSION)

sync-tag:
	@make .sync-chart CHART_NAME=extractor
	@make .sync-chart CHART_NAME=gateway
	@make .sync-chart CHART_NAME=indexer
	@make .sync-chart CHART_NAME=tracker
	@make .sync-chart CHART_NAME=depscloud
	@yq w -i ./charts/depscloud/values.yaml "beacon.config.applicationVersion"  $(LATEST_VERSION)

tag-release:
	@git commit -a -m "$(LATEST_VERSION)"
	@git tag -a -m "v$(LATEST_VERSION)" v$(LATEST_VERSION)
	@echo "tagging complete, please run git push --follow-tags"

public/index.html: public .public/index.html
.public/index.html:
	@echo "[site] generating"
	@cp site/style.css public/style.css
	@mdtohtml -page -css style.css site/README.md public/index.html
