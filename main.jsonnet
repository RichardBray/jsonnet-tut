local grafana = import 'github.com/grafana/grafonnet/gen/grafonnet-latest/main.libsonnet';
local grizzly = import 'grizzly/grizzly.libsonnet';

local dashboards = import 'lib/dashboards.libsonnet';

{
  dashboards: [grizzly.dashboard.new(
    dashboards.nodeMetrics.uid,
    dashboards.nodeMetrics.dashboard
  )]
}