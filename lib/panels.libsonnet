local grafana = import 'github.com/grafana/grafonnet/gen/grafonnet-latest/main.libsonnet';

local timeSeries = grafana.panel.timeSeries;
local prometheus = grafana.query.prometheus;

local prometheusDataSourceId = 'bebsfl2z94g74c';

local cpuQuery(cpuMode) =
  prometheus.new(
    prometheusDataSourceId,
    'sum(irate(node_cpu_seconds_total{mode="' + cpuMode + '", cpu="0"}[1m])) / scalar(count(count(node_cpu_seconds_total{mode="' + cpuMode + '", cpu="0"}) by(cpu)))'
  ) + prometheus.withLegendFormat(cpuMode);

{
  cpuUsagePanel: timeSeries.new('CPU Usage')
    + timeSeries.queryOptions.withTargets([
        cpuQuery('irq'),
        cpuQuery('idle'),
        cpuQuery('system'),
        cpuQuery('user')
      ])
    + timeSeries.gridPos.withW(24)
    + timeSeries.gridPos.withH(8)
    + timeSeries.standardOptions.withUnit('percentunit'),

  memoryUsagePanel: timeSeries.new('Memory Usage')
    + timeSeries.queryOptions.withTargets([
        prometheus.new(
          prometheusDataSourceId,
          'node_memory_MemTotal_bytes'
        ) + prometheus.withLegendFormat('RAM Total'),
        prometheus.new(
          prometheusDataSourceId,
          'node_memory_MemTotal_bytes - node_memory_MemFree_bytes - (node_memory_Cached_bytes + node_memory_Buffers_bytes + node_memory_SReclaimable_bytes)'
        ) + prometheus.withLegendFormat('RAM Used')
      ])
    + timeSeries.gridPos.withW(24)
    + timeSeries.gridPos.withH(8)
    + timeSeries.standardOptions.withUnit('bytes'),

  diskUsagePanel: timeSeries.new('Disk Usage')
    + timeSeries.queryOptions.withTargets([
        prometheus.new(
          prometheusDataSourceId,
          '100 - ((node_filesystem_avail_bytes{device!~"rootfs"} * 100) / node_filesystem_size_bytes{device!~"rootfs"})'
        ) + prometheus.withLegendFormat('{{mountpoint}}'),
      ])
    + timeSeries.gridPos.withW(24)
    + timeSeries.gridPos.withH(8)
    + timeSeries.standardOptions.withUnit('percentage')
}