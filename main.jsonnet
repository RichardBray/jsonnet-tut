local grafana = import 'github.com/grafana/grafonnet/gen/grafonnet-latest/main.libsonnet';
local grizzly = import 'grizzly/grizzly.libsonnet';

local dashboards = import 'lib/dashboards.libsonnet';

local myAlert = {
  alert: 'HighCPUUsage',
  expr: 'cpu_usage_percent > 90',
  'for': '5m',
  labels: {
    severity: 'warning'
  },
  annotations: {
    summary: 'High CPU usage detected',
    description: 'CPU usage is above 90% for 5 minutes'
  }
};

{
  dashboards: [grizzly.dashboard.new(
    dashboards.nodeMetrics.uid,
    dashboards.nodeMetrics.dashboard
  )]
}