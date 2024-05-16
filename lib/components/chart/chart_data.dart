import 'package:active_log/components/chart/chart.dart';

class ChartData {
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;

  ChartData({
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.friAmount,
    required this.satAmount,
  });

  List<Chart> chartData = [];

  void initializeChartData() {
    chartData = [
      Chart(x: 0, y: sunAmount),
      Chart(x: 1, y: monAmount),
      Chart(x: 2, y: tueAmount),
      Chart(x: 3, y: wedAmount),
      Chart(x: 4, y: thurAmount),
      Chart(x: 5, y: friAmount),
      Chart(x: 6, y: satAmount),
    ];
  }
}
