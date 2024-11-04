import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SalesDashboard extends StatefulWidget {
  const SalesDashboard({super.key});

  @override
  State<SalesDashboard> createState() => _SalesDashboardState();
}

class _SalesDashboardState extends State<SalesDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InfoContainer(
                    icon: Icons.bar_chart_rounded,
                    title: 'Total Sales',
                    value: '128',
                    subtitle: Text('Till 1 Nov',
                        style: TextStyle(fontWeight: FontWeight.w300)),
                  ),
                  InfoContainer(
                    icon: Icons.campaign_rounded,
                    title: 'Campaigns',
                    value: '- -',
                    subtitle: Text('Till 1 Nov',
                        style: TextStyle(fontWeight: FontWeight.w300)),
                  ),
                ],
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const InfoContainer(
                    icon: Icons.warehouse_rounded,
                    title: 'Field Visits',
                    value: '15',
                    subtitle: Text('Till 1 Nov',
                        style: TextStyle(fontWeight: FontWeight.w300)),
                  ),
                  InfoContainer(
                      icon: Icons.celebration_rounded,
                      title: 'Rewards',
                      value: '48',
                      subtitle: Row(
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.done,
                                    color: Colors.amber[400],
                                  ),
                                  const Gap(3),
                                  const Text('11')
                                ],
                              ),
                              const Gap(5),
                              Row(
                                children: [
                                  Icon(
                                    Icons.stars_rounded,
                                    color: Colors.green[400],
                                  ),
                                  const Gap(3),
                                  const Text('05')
                                ],
                              ),
                            ],
                          )
                        ],
                      )),
                ],
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF1890FF).withOpacity(0.12),
                        const Color(0xffABD1F3).withOpacity(0.12)
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.star_rounded,
                                  color: Color(0xff1890FF)),
                              const Gap(5),
                              RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'You are doing better than ',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '75%',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff1890FF),
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' of your peers',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              ),
              WeeklyOverviewChart(),
            ],
          ),
        ),
        floatingActionButton: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
            color: const Color(0xFF1890FF),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.0, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.bar_chart_rounded, color: Colors.white),
                Gap(5),
                Text("Add Sales", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ));
  }
}

class InfoContainer extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Widget subtitle;

  const InfoContainer({
    Key? key,
    required this.icon,
    required this.title,
    required this.value,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1890FF).withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      icon,
                      color: const Color(0xFF1890FF),
                    ),
                  ),
                ),
                const Gap(10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Gap(20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(10),
                subtitle,
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class WeeklyOverviewChart extends StatelessWidget {
  WeeklyOverviewChart({Key? key}) : super(key: key);

  // Generate random data for current and previous week
  final List<Map<String, dynamic>> weeklyData = List.generate(7, (index) {
    final random = Random();
    return {
      'day': _getDayName(index),
      'salesTarget': random.nextInt(300) + 100, // Random value between 100-400
      'achievedTarget': random.nextInt(300) + 100,
      'isHoliday': _getDayName(index) == 'Sat' || _getDayName(index) == 'Sun',
    };
  });

  static String _getDayName(int index) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[index];
  }

  BarChartGroupData generateGroupData(
    int x,
    double salesTarget,
    double achievedTarget,
    bool isHoliday,
  ) {
    return BarChartGroupData(
      x: x,
      groupVertically: false,
      barRods: [
        BarChartRodData(
          toY: isHoliday ? achievedTarget : salesTarget,
          color: isHoliday ? Colors.grey : Colors.blue,
          width: 8,
          borderRadius: BorderRadius.circular(2),
        ),
        BarChartRodData(
          toY: achievedTarget,
          color: Colors.blue.withOpacity(0.3),
          width: 8,
          borderRadius: BorderRadius.circular(2),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Overview',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Time period selector
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      _buildTimeButton('Today', false),
                      _buildTimeButton('Weekly', true),
                      _buildTimeButton('Monthly', false),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Legend
            Row(
              children: [
                _buildLegendItem('Sales Target', Colors.blue),
                const SizedBox(width: 16),
                _buildLegendItem(
                    'Achieved Target', Colors.blue.withOpacity(0.3)),
                const SizedBox(width: 16),
                _buildLegendItem('Holiday', Colors.grey),
              ],
            ),
            const SizedBox(height: 20),

            // FL Chart
            SizedBox(
              height: 300,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 500,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            weeklyData[value.toInt()]['day'],
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          );
                        },
                        interval: 100,
                      ),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: const FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 100,
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: List.generate(
                    weeklyData.length,
                    (index) => generateGroupData(
                      index,
                      weeklyData[index]['salesTarget'].toDouble(),
                      weeklyData[index]['achievedTarget'].toDouble(),
                      weeklyData[index]['isHoliday'],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeButton(String text, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.black : Colors.grey[600],
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
