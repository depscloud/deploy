local grafana = import 'github.com/grafana/grafonnet-lib/grafonnet/grafana.libsonnet';
local prometheus = grafana.prometheus;
local singlestat = grafana.singlestat;
local graphPanel = grafana.graphPanel;

{
  /**
   */
  eventLoopLag(
    selector,
  ):: graphPanel.new(
    'Event Loop Lag',
    datasource='$datasource',
    span=4,
    format='short',
  )
      .addTarget(prometheus.target(
    'nodejs_eventloop_lag_p99_seconds{%s}' % [
      selector,
    ],
    legendFormat='{{ instance }}',
  )),
}
