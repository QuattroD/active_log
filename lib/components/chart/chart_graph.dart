import 'package:active_log/components/chart/chart_data.dart';
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
        titlesData: const FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: getBottomTitles)),
        ),
        barGroups: myChartData.chartData
            .map((data) => BarChartGroupData(x: data.x, barRods: [
                  BarChartRodData(
                      toY: data.y,
                      color: Colors.cyan,
                      width: 8,
                      borderRadius: BorderRadius.circular(3))
                ]))
            .toList()));
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  const style =
      TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 10);
  Widget text;

  switch (value.toInt()) {
    case 0:
      text = const Text(
        'Вс',
        style: style,
      );
      break;
    case 1:
      text = const Text(
        'Пн',
        style: style,
      );
      break;
    case 2:
      text = const Text(
        'Вт',
        style: style,
      );
      break;
    case 3:
      text = const Text(
        'Ср',
        style: style,
      );
      break;
    case 4:
      text = const Text(
        'Чт',
        style: style,
      );
      break;
    case 5:
      text = const Text(
        'Пт',
        style: style,
      );
      break;
    case 6:
      text = const Text(
        'Сб',
        style: style,
      );
      break;
    default:
      text = const Text(
        '',
        style: style,
      );
      break;
  }
  
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}
