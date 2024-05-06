import 'package:active_log/components/chart_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyChartGraph extends StatelessWidget {
  final List weeklySumamry;
  const MyChartGraph({super.key, required this.weeklySumamry});

  @override
  Widget build(BuildContext context) {
    ChartData myChartData = ChartData(
        sunAmount: weeklySumamry[0],
        monAmount: weeklySumamry[1],
        tueAmount: weeklySumamry[2],
        wedAmount: weeklySumamry[3],
        thurAmount: weeklySumamry[4],
        friAmount: weeklySumamry[5],
        satAmount: weeklySumamry[6]);
    myChartData.initializeChartData();
    return BarChart(BarChartData(
        maxY: 100,
        minY: 0,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        barGroups: myChartData.chartData
            .map((data) => BarChartGroupData(x: data.x, barRods: [
                  BarChartRodData(
                      toY: data.y,
                      color: Colors.cyan,
                      width: 4,
                      borderRadius: BorderRadius.circular(5))
                ]))
            .toList()));
  }
}
