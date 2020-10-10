local grafana = import 'github.com/grafana/grafonnet-lib/grafonnet/grafana.libsonnet';
local prometheus = grafana.prometheus;
local singlestat = grafana.singlestat;
local graphPanel = grafana.graphPanel;

{
  /**
   */
  memory(
    selector,
  ):: graphPanel.new(
    'Memory',
    datasource='$datasource',
    span=4,
    format='bytes',
  )
      .addTarget(prometheus.target(
    'process_resident_memory_bytes{%s}' % [
      selector,
    ],
    legendFormat='{{ instance }}',
  )),

  /**
   */
  cpu(
    selector,
  ):: graphPanel.new(
    'CPU usage',
    datasource='$datasource',
    span=4,
    format='short',
    min=0,
  )
      .addTarget(prometheus.target(
    'rate(process_cpu_seconds_total{%s}[5m])' % [
      selector,
    ],
    legendFormat='{{ instance }}',
  )),
}
