import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DoughnutChart extends StatelessWidget {
  const DoughnutChart({super.key, required this.data, required this.tooltip});

  final List<ChartData> data;
  final TooltipBehavior tooltip;

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      tooltipBehavior: tooltip,
      series: <CircularSeries<ChartData, String>>[
        DoughnutSeries<ChartData, String>(
            dataSource: data,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            name: 'Gold')
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
}
