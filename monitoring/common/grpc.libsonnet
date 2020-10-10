local grafana = import 'github.com/grafana/grafonnet-lib/grafonnet/grafana.libsonnet';
local prometheus = grafana.prometheus;
local singlestat = grafana.singlestat;
local graphPanel = grafana.graphPanel;

{
  /**
   */
  availability(
    selector,
    slo_days=30,
    slo_target=0.99,
  ):: singlestat.new(
    'Availability (%dd) > %.3f%%' % [slo_days, 100 * slo_target],
    datasource='$datasource',
    span=4,
    format='percentunit',
    decimals=3,
    description='Successfully answered requests over the last %d days' % slo_days,
  )
      .addTarget(prometheus.target(
    'sum(rate(grpc_server_handled_total{grpc_code!="Unavailable",grpc_code!="Unknown",%s}[%dd])) / sum(rate(grpc_server_handled_total{%s}[%dd]))' % [
      selector,
      slo_days,
      selector,
      slo_days,
    ],
  )),

  /**
   */
  errorBudget(
    selector,
    slo_days=30,
    slo_target=0.99,
  ):: graphPanel.new(
    'ErrorBudget (%dd) > %.3f%%' % [slo_days, 100 * slo_target],
    datasource='$datasource',
    span=8,
    format='percentunit',
    decimals=3,
    fill=10,
    description='How much error budget is left looking at our %.3f%% availability guarantees' % [100 * slo_target]
  )
      .addTarget(prometheus.target(
    '100 * (sum(rate(grpc_server_handled_total{grpc_code!="Unavailable",grpc_code!="Unknown",%s}[%dd])) / sum(rate(grpc_server_handled_total{%s}[%dd])) - %f)' % [
      selector,
      slo_days,
      selector,
      slo_days,
      slo_target,
    ],
    legendFormat='errorbudget'
  )),

  /**
   */
  requestRate(
    selector,
  ):: graphPanel.new(
    'SLI - Request Rates',
    datasource='$datasource',
    span=4,
    format='reqps',
    stack=true,
    fill=10,
  ).addTarget(prometheus.target(
    'sum(rate(grpc_server_handled_total{%s}[5m])) by (grpc_code)' % [
      selector,
    ],
    legendFormat='{{ grpc_code }}'
  )),

  /**
   */
  errorRate(
    selector,
  ):: graphPanel.new(
    'SLI - Error Rates',
    datasource='$datasource',
    span=4,
    min=0,
    format='percentunit',
  ).addTarget(prometheus.target(
    (
      'sum(rate(grpc_server_handled_total{grpc_code="Unavailable",%s}[5m])) by (grpc_service, grpc_method) / ' +
      'sum(rate(grpc_server_handled_total{%s}[5m])) by (grpc_service, grpc_method)'
    ) % [
      selector,
      selector,
    ],
    legendFormat='{{ grpc_service }} {{ grpc_method }}',
  )),

  /**
   */
  requestDuration(
    selector,
  ):: graphPanel.new(
    'SLI - Request Duration',
    datasource='$datasource',
    span=4,
    format='s',
  ).addTarget(prometheus.target(
    'histogram_quantile(0.99, sum(rate(grpc_server_handling_seconds_bucket{%s}[5m])) by (le,grpc_service,grpc_method))' % [
      selector,
    ],
    legendFormat='{{ grpc_service }} {{ grpc_method }}',
  )),
}
