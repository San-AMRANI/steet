import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steet/data/LIne_chart_data.dart';
import 'package:steet/presentation/dashboard/widgets/CostumCard.dart';
import 'package:steet/presentation/providers/DashboardProvider.dart';

class LineChartCard extends ConsumerStatefulWidget {
  const LineChartCard({super.key});
  @override
  ConsumerState<LineChartCard> createState() => _LineChartState();
}

class _LineChartState extends ConsumerState<LineChartCard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dashboardProvider.notifier).getStudentCount();
    });
  }

  @override
  Widget build(BuildContext context) {
    // final studentCountState = ref.watch(dashboardProvider).studentCount;
    final data = LineData();
    return CustomCard(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Activity Overview",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500 , color: Colors.grey[600]),
        ),
        const SizedBox(height: 20),
        AspectRatio(
            aspectRatio: 16 / 8,
            child: LineChart(
              LineChartData(
                lineTouchData: LineTouchData(
                  handleBuiltInTouches: false,
                ),
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return data.bottomTitle[value.toInt()] != null
                            ? SideTitleWidget(
                                axisSide: meta.axisSide,
                                child: Text(
                                  data.bottomTitle[value.toInt()].toString(),
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey[400]),
                                ),
                              )
                            : const SizedBox();
                      },
                    )),
                    leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return data.leftTitle[value.toInt()] != null
                            ? SideTitleWidget(
                                axisSide: meta.axisSide,
                                child: Text(
                                  data.leftTitle[value.toInt()].toString(),
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey[400]),
                                ),
                              )
                            : const SizedBox();
                      },
                      interval: 1,
                      reservedSize: 30,
                    ))),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    color: Colors.grey,
                    barWidth: 2.5,
                    belowBarData: BarAreaData(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.grey.withOpacity(0.5),
                          Colors.transparent
                        ],
                      ),
                      show: true,
                    ),
                    dotData: FlDotData(
                      show: false,
                    ),
                    spots: data.spots,
                  )
                ],
                minX: 0,
                maxX: 120,
                maxY: 50,
                minY: -5,
              ),
            ))
      ],
    ));
  }
}
