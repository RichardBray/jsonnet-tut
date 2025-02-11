local grafana = import 'github.com/grafana/grafonnet/gen/grafonnet-latest/main.libsonnet';
local panels = import 'lib/panels.libsonnet';

local dashboard = grafana.dashboard;

dashboard.new('Node Metrics')
+ dashboard.withDescription('Metrics from the node exporter')
+ dashboard.time.withFrom(value = "now-30m")
+ dashboard.withPanels([
    panels.cpuUsagePanel,
    panels.memoryUsagePanel
  ])