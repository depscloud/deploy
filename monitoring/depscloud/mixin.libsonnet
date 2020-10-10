// service level alerts, dashboards, rules
(import '../extractor/mixin.libsonnet') +
(import '../gateway/mixin.libsonnet') +
(import '../indexer/mixin.libsonnet') +
(import '../tracker/mixin.libsonnet') +
// ecosystem level alerts, dashboards, rules
(import 'alerts/alerts.libsonnet') +
(import 'dashboards/dashboards.libsonnet') +
(import 'rules/rules.libsonnet') +
// defaults!
(import '../common/defaults.libsonnet') +
(import 'config.libsonnet')
