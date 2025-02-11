local grafana = import 'github.com/grafana/grafonnet/gen/grafonnet-latest/main.libsonnet';

local dashboard = grafana.dashboard;
local timeSeries = grafana.panel.timeSeries;

dashboard.new('Node Metrics')
+ dashboard.withDescription('CPU Usage')
+ dashboard.time.withFrom(value="now-30m")
+ dashboard.withPanels(
    timeSeries.new('My first graph')
    + timeSeries.queryOptions.withDatasource('prometheus', 'bebsfl2z94g74c')
    + timeSeries.queryOptions.withTargets([
          grafana.query.prometheus.new(
      'bebsfl2z94g74c',
      'irate(node_cpu_seconds_total{mode!=\"idle\", cpu=\"0\"}[1m])',
    ),

    ])
    + timeSeries.gridPos.withW(24)
    + timeSeries.gridPos.withH(8),
  )



/**
grafana.dashboard.new('My Dashboard') {
  description: 'This is a dashboard',
  panels: [
    grafana.panel.timeSeries.new('My first graph')
  ]
}
 */