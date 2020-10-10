JSONNET_ARGS := -n 2 --max-blank-lines 2 --string-style s --comment-style s
ifneq (,$(shell which jsonnetfmt))
	JSONNET_FMT_CMD := jsonnetfmt
else
	JSONNET_FMT_CMD := jsonnet
	JSONNET_FMT_ARGS := fmt $(JSONNET_ARGS)
endif
JSONNET_FMT := $(JSONNET_FMT_CMD) $(JSONNET_FMT_ARGS)

TARGET ?= depscloud

all: fmt alerts rules dashboards lint

clean:
	rm -rf out

# helpers

.jsonnet:
	@jsonnet -J vendor -V output=$(OUTPUT) $(EXTRA_ARGS) $(TARGET)/gen.jsonnet

# style

fmt:
	find . -name 'vendor' -prune -o -name '*.libsonnet' -print -o -name '*.jsonnet' -print | \
		xargs -n 1 -- $(JSONNET_FMT) -i

lint:
	find . -name 'vendor' -prune -o -name '*.libsonnet' -print -o -name '*.jsonnet' -print | \
		while read f; do \
			$(JSONNET_FMT) "$$f" | diff -u "$$f" -; \
		done

# core

alerts:
	@mkdir -p out
	make .jsonnet TARGET=$(TARGET) OUTPUT=alerts EXTRA_ARGS="-S" > out/$(TARGET)_prometheus_alerts.yaml

dashboards:
	@mkdir -p out
	make .jsonnet TARGET=$(TARGET) OUTPUT=dashboards EXTRA_ARGS="-m out"

rules:
	@mkdir -p out
	make .jsonnet TARGET=$(TARGET) OUTPUT=rules EXTRA_ARGS="-S" > out/$(TARGET)_prometheus_rules.yaml
