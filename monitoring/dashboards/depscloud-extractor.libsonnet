local grafana = import 'github.com/grafana/grafonnet-lib/grafonnet/grafana.libsonnet';
local dashboard = grafana.dashboard;
local row = grafana.row;
local prometheus = grafana.prometheus;
local template = grafana.template;
local graphPanel = grafana.graphPanel;
local singlestat = grafana.singlestat;

{
  grafanaDashboards+:: {
    'depscloud-extractor.json':
      local slo_days = 30;
      local slo_target = 0.99;

      local availability =
        singlestat.new(
          'Availability (%dd) > %.3f%%' % [slo_days, 100 * slo_target],
          datasource='$datasource',
          span=4,
          format='percentunit',
          decimals=3,
          description='Successfully answered requests over the last %d days' % slo_days
        )
        .addTarget(prometheus.target(
          'sum(rate(grpc_server_handled_total{grpc_code!="Unavailable",grpc_code!="Unknown",%s}[%dd])) / sum(rate(grpc_server_handled_total{%s}[%dd]))' % [
            $._config.selectors.tracker,
            slo_days,
            $._config.selectors.tracker,
            slo_days,
          ],
        ));

      local errorBudget =
        graphPanel.new(
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
            $._config.selectors.tracker,
            slo_days,
            $._config.selectors.tracker,
            slo_days,
            slo_target,
          ],
        ));

      dashboard.new(
        '%sdeps.cloud / extractor' % $._config.dashboard.prefix,
        time_from='now-1h',
        tags=($._config.dashboard.tags),
        refresh=($._config.dashboard.refresh)
      )
      .addTemplate({
        current: {
          text: 'default',
          value: 'default',
        },
        hide: 0,
        label: null,
        name: 'datasource',
        options: [],
        query: 'prometheus',
        refresh: 1,
        regex: '',
        type: 'datasource',
      })
      .addPanel(
        grafana.text.new(
          title='Notice',
          content='TBD',
          description='TBD',
          span=12,
        ),
        gridPos={
          h: 2,
          w: 24,
          x: 0,
          y: 0,
        },
      )
      .addRow(
        row.new()
        .addPanel(availability)
        .addPanel(errorBudget)
      ),
  },
}
