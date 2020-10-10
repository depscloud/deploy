CHART_REPOSITORY_URL = "https://depscloud.github.io/deploy"
REPOSITORY_URL = "https://github.com/depscloud/deploy.git"

all: public/charts public/k8s public/monitoring

clean:
	rm -rf public

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
	@cd monitoring && jb install && make 1>/dev/null
	@cp monitoring/out/* public/monitoring/
