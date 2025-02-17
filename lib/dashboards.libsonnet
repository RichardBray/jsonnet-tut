local grafana = import 'github.com/grafana/grafonnet/gen/grafonnet-latest/main.libsonnet';
local panels = import 'panels.libsonnet';

local dashboard = grafana.dashboard;

local nodeMetricsUid = 'node-metrics';
local nodeMetricsDash = dashboard.new('Node Metrics')
+ dashboard.withUid(nodeMetricsUid)
+ dashboard.withDescription('Metrics from the node exporter')
+ dashboard.time.withFrom(value = "now-50m")
+ dashboard.withPanels([
    panels.cpuUsagePanel,
    panels.memoryUsagePanel,
    panels.diskUsagePanel
  ]);

{
  nodeMetrics: {
    dashboard: nodeMetricsDash,
    uid: nodeMetricsUid
  }
}