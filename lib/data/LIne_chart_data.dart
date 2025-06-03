import 'package:fl_chart/fl_chart.dart';

class LineData {
  final spots = const [
    FlSpot(0, 1),
    FlSpot(10, 10),
    FlSpot(20, 30),
    FlSpot(30, 24),
    FlSpot(40, 15),
    FlSpot(50, 10),
    FlSpot(60, 30),
    FlSpot(70, 28),
    FlSpot(80, 19),
    FlSpot(90, 10),
    FlSpot(100, 21),
    FlSpot(110, 42),
  ];

  final bottomTitle = {
    0: 'Jan',
    10: 'Feb',
    20: 'Mar',
    30: 'Apr',
    40: 'May',
    50: 'Jun',
    60: 'Jul',
    70: 'Aug',
    80: 'Sep',
    90: 'Oct',
    100: 'Nov',
    110: 'Dec',
  };
  final leftTitle = {0: '0', 10: '10', 20: '20', 30: '30', 40: '40', 50: '50'};
}
