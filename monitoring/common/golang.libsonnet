local grafana = import 'github.com/grafana/grafonnet-lib/grafonnet/grafana.libsonnet';
local prometheus = grafana.prometheus;
local graphPanel = grafana.graphPanel;

{
  /**
   */
  goroutines(
    selector,
  ):: graphPanel.new(
    'Goroutines',
    datasource='$datasource',
    span=4,
    format='short',
  ).addTarget(prometheus.target(
    'go_goroutines{%s}' % [
      selector,
    ],
    legendFormat='{{ instance }}',
  )),
}
