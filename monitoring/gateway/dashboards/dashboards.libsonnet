local golang = import '../../common/golang.libsonnet';
local grpc = import '../../common/grpc.libsonnet';
local resources = import '../../common/resources.libsonnet';

local grafana = import 'github.com/grafana/grafonnet-lib/grafonnet/grafana.libsonnet';
local dashboard = grafana.dashboard;
local row = grafana.row;
local template = grafana.template;

{
  grafanaDashboards+:: {
    'depscloud-gateway-grafana.json':
      local availability =
        grpc.availability(
          selector=($._config.gateway.selector),
          slo_days=($._config.gateway.slos.days),
          slo_target=($._config.gateway.slos.availability),
        );

      local errorBudget =
        grpc.errorBudget(
          selector=($._config.gateway.selector),
          slo_days=($._config.gateway.slos.days),
          slo_target=($._config.gateway.slos.availability),
        );

      local sliRequestRate =
        grpc.requestRate(
          selector=($._config.gateway.selector),
        );

      local sliErrorRate =
        grpc.errorRate(
          selector=($._config.gateway.selector),
        );

      local sliRequestDuration =
        grpc.requestDuration(
          selector=($._config.gateway.selector),
        );

      local memory =
        resources.memory(
          selector=($._config.gateway.selector),
        );

      local cpu =
        resources.cpu(
          selector=($._config.gateway.selector),
        );

      local goroutines =
        golang.goroutines(
          selector=($._config.gateway.selector),
        );

      dashboard.new(
        '%sdeps.cloud / gateway' % $._config.dashboard.prefix,
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
        .addPanel(goroutines)
      ),
  },
}
