JSONNET_ARGS := -n 2 --max-blank-lines 2 --string-style s --comment-style s
ifneq (,$(shell which jsonnetfmt))
	JSONNET_FMT_CMD := jsonnetfmt
else
	JSONNET_FMT_CMD := jsonnet
	JSONNET_FMT_ARGS := fmt $(JSONNET_ARGS)
endif
JSONNET_FMT := $(JSONNET_FMT_CMD) $(JSONNET_FMT_ARGS)

all: fmt alerts rules dashboards lint #test

fmt:
	find . -name 'vendor' -prune -o -name '*.libsonnet' -print -o -name '*.jsonnet' -print | \
		xargs -n 1 -- $(JSONNET_FMT) -i

alerts: mixin.libsonnet lib/alerts.jsonnet alerts/*.libsonnet
	@mkdir -p out
	jsonnet -J vendor -S lib/alerts.jsonnet > out/$@

rules: mixin.libsonnet lib/rules.jsonnet rules/*.libsonnet
	@mkdir -p out
	jsonnet -J vendor -S lib/rules.jsonnet > out/$@

dashboards: mixin.libsonnet lib/dashboards.jsonnet dashboards/*.libsonnet
	@mkdir -p out
	jsonnet -J vendor -m out lib/dashboards.jsonnet

lint: alerts rules
	find . -name 'vendor' -prune -o -name '*.libsonnet' -print -o -name '*.jsonnet' -print | \
		while read f; do \
			$(JSONNET_FMT) "$$f" | diff -u "$$f" -; \
		done

# 	promtool check rules prometheus_rules.yaml
# 	promtool check rules prometheus_alerts.yaml

clean:
	rm -rf dashboards_out prometheus_alerts.yaml prometheus_rules.yaml

# test: prometheus_alerts.yaml prometheus_rules.yaml
# 	promtool test rules tests.yaml