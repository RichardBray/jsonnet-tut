local grafana = import 'github.com/grafana/grafonnet/gen/grafonnet-latest/main.libsonnet';

local dashboard = grafana.dashboard;
local timeSeries = grafana.panel.timeSeries;
local prometheus = grafana.query.prometheus;

local cpuQuery(cpuMode) =
  prometheus.new(
    'bebsfl2z94g74c',
    'sum(irate(node_cpu_seconds_total{mode="' + cpuMode + '", cpu="0"}[1m])) / scalar(count(count(node_cpu_seconds_total{mode="' + cpuMode + '", cpu="0"}) by(cpu)))'
  ) + prometheus.withLegendFormat(cpuMode);

dashboard.new('Node Metrics')
+ dashboard.withDescription('Metrics from the node exporter')
+ dashboard.time.withFrom(value = "now-30m")
+ dashboard.withPanels([
    timeSeries.new('CPU Usage')
    + timeSeries.queryOptions.withTargets([
        cpuQuery('irq'),
        cpuQuery('idle'),
        cpuQuery('system'),
        cpuQuery('user')
      ])
    + timeSeries.gridPos.withW(24)
    + timeSeries.gridPos.withH(8)
    + timeSeries.standardOptions.withUnit('percentunit'),
    timeSeries.new('Memory Usage')
    + timeSeries.queryOptions.withTargets([
        prometheus.new(
          'bebsfl2z94g74c',
          'node_memory_MemTotal_bytes'
        ) + prometheus.withLegendFormat('RAM Total'),
        prometheus.new(
          'bebsfl2z94g74c',
          'node_memory_MemTotal_bytes - node_memory_MemFree_bytes - (node_memory_Cached_bytes + node_memory_Buffers_bytes + node_memory_SReclaimable_bytes)'
        ) + prometheus.withLegendFormat('RAM Used')
      ])
    + timeSeries.gridPos.withW(24)
    + timeSeries.gridPos.withH(8)
    + timeSeries.standardOptions.withUnit('bytes')
  ])