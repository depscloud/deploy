local grpc = import 'common/grpc.libsonnet';
local nodejs = import 'common/nodejs.libsonnet';
local resources = import 'common/resources.libsonnet';

local grafana = import 'github.com/grafana/grafonnet-lib/grafonnet/grafana.libsonnet';
local dashboard = grafana.dashboard;
local row = grafana.row;
local template = grafana.template;

{
  grafanaDashboards+:: {
    'depscloud-extractor.json':
      local slo_days = 30;
      local slo_target = 0.99;

      local availability =
        grpc.availability(
          selector=($._config.selectors.extractor),
          slo_days=slo_days,
          slo_target=slo_target,
        );

      local errorBudget =
        grpc.errorBudget(
          selector=($._config.selectors.extractor),
          slo_days=slo_days,
          slo_target=slo_target,
        );

      local sliRequestRate =
        grpc.requestRate(
          selector=($._config.selectors.extractor),
        );

      local sliErrorRate =
        grpc.errorRate(
          selector=($._config.selectors.extractor),
        );

      local sliRequestDuration =
        grpc.requestDuration(
          selector=($._config.selectors.extractor),
        );

      local memory =
        resources.memory(
          selector=($._config.selectors.extractor),
        );

      local cpu =
        resources.cpu(
          selector=($._config.selectors.extractor),
        );

      local eventLoopLag =
        nodejs.eventLoopLag(
          selector=($._config.selectors.extractor),
        );

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
      )
      .addRow(
        row.new()
        .addPanel(sliRequestRate)
        .addPanel(sliErrorRate)
        .addPanel(sliRequestDuration)
      )
      .addRow(
        row.new()
        .addPanel(memory)
        .addPanel(cpu)
        .addPanel(eventLoopLag)
      ),
  },
}
