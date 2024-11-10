import 'dart:math';

import 'package:fieldapp_functionality/imageanalysis/imageanalysis.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';

class SalesDashboard extends StatefulWidget {
  const SalesDashboard({super.key});

  @override
  State<SalesDashboard> createState() => _SalesDashboardState();
}

class _SalesDashboardState extends State<SalesDashboard> {
  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: const Color(0xffF6F7FA),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: sw * 0.2,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Symbols.arrow_back_ios,
                                size: 0.03 * sw,
                                color: primaryColor,
                              ),
                              Text(
                                'Back',
                                style: TextStyle(
                                  fontSize: 0.03 * sw,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text("Sales Dashboard",
                          style: TextStyle(
                            fontSize: 0.03 * sw,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          )),
                      SizedBox(
                        width: 0.2 * sw,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InfoContainer(
                      icon: Symbols.bar_chart_rounded,
                      title: 'Total Sales',
                      value: '128',
                      subtitle: Text('Till 1 Nov',
                          style: TextStyle(fontWeight: FontWeight.w300)),
                    ),
                    InfoContainer(
                      icon: Icons.campaign,
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
                      icon: Symbols.warehouse_rounded,
                      title: 'Field Visits',
                      value: '15',
                      subtitle: Text('Till 1 Nov',
                          style: TextStyle(fontWeight: FontWeight.w300)),
                    ),
                    InfoContainer(
                        icon: Symbols.rewarded_ads,
                        title: 'Rewards',
                        value: '48',
                        subtitle: Row(
                          children: [
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Symbols.editor_choice,
                                      size: 7.sp,
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
                                      Symbols.stars_rounded,
                                      size: 7.sp,
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
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF1890FF).withOpacity(0.07),
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
                                const Icon(Symbols.family_star,
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
                                        text: '72%',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff1890FF),
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' of your people.',
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
                const Gap(20),
                WeeklyOverviewChart(),
                const Gap(10),
                // Legend
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLegendItem('Sales Target', Colors.blue),
                    const SizedBox(width: 16),
                    _buildLegendItem(
                        'Achieved Target', Colors.blue.withOpacity(0.3)),
                    const SizedBox(width: 16),
                    _buildLegendItem('Holiday', Colors.grey),
                  ],
                ),
                const Gap(50)
              ],
            ),
          ),
        ),
        floatingActionButton: GestureDetector(
          onTap: () {
            SalesSheet(context);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
              color: const Color(0xFF1890FF),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.0, vertical: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Symbols.bar_chart_rounded, color: Colors.white),
                  Gap(5),
                  Text("Add Sales", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
        ));
  }
}

Future<dynamic> SalesSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    barrierColor: Colors.transparent,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(17.sp)),
    ),
    builder: (BuildContext ctx) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.9,
        maxChildSize: 0.93,
        builder: (BuildContext context, ScrollController scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(17.sp)),
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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Submit Sales",
                        style: TextStyle(
                            fontSize: 8.sp, fontWeight: FontWeight.w500)),
                    Container(
                      height: 2,
                      width: MediaQuery.of(context).size.width * 0.9,
                      color: Colors.grey[300],
                      margin: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    Gap(5.sp),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Retailer Name",
                            style: TextStyle(
                                fontSize: 7.sp, fontWeight: FontWeight.w600)),
                        Container(
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 239, 239, 239)),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "   Enter Retailer Name",
                              hintStyle: TextStyle(
                                  color: const Color(0xff74787E),
                                  fontSize: 6.sp),
                            ),
                          ),
                        )
                      ],
                    ),
                    const Gap(20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Date of Sale*",
                            style: TextStyle(
                                fontSize: 7.sp, fontWeight: FontWeight.w600)),
                        Container(
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 239, 239, 239)),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "   eg- 06/06/2024",
                              hintStyle: TextStyle(
                                  color: const Color(0xff74787E),
                                  fontSize: 6.sp),
                            ),
                          ),
                        )
                      ],
                    ),
                    const Gap(20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Store Name*",
                            style: TextStyle(
                                fontSize: 7.sp, fontWeight: FontWeight.w600)),
                        Container(
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 239, 239, 239)),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "   Enter Store",
                                hintStyle: TextStyle(
                                    color: const Color(0xff74787E),
                                    fontSize: 6.sp)),
                          ),
                        )
                      ],
                    ),
                    const Gap(20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Product Serial Number",
                            style: TextStyle(
                                fontSize: 7.sp, fontWeight: FontWeight.w600)),
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 90.w,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 239, 239, 239)),
                                child: TextField(
                                  decoration: InputDecoration(
                                      hintText: "   Enter 20 digit Number",
                                      hintStyle: TextStyle(
                                          color: const Color(0xff74787E),
                                          fontSize: 6.sp)),
                                ),
                              ),
                              Gap(4.sp),
                              Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xff4285F4)
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 9.sp, vertical: 4.sp),
                                    child: Center(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.barcode_reader,
                                            size: 7.sp,
                                            color: const Color(0xff4285F4),
                                          ),
                                          Gap(2.sp),
                                          const Text("Scan",
                                              style: TextStyle(
                                                  color: Color(0xff4285F4))),
                                        ],
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                    const Gap(20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Additional Info",
                            style: TextStyle(
                                fontSize: 7.sp, fontWeight: FontWeight.w600)),
                        Container(
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 239, 239, 239)),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "   Enter additional info",
                                hintStyle: TextStyle(
                                    color: const Color(0xff74787E),
                                    fontSize: 6.sp)),
                          ),
                        ),
                      ],
                    ),
                    const Gap(20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Quantity",
                            style: TextStyle(
                                fontSize: 7.sp, fontWeight: FontWeight.w600)),
                        Container(
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 239, 239, 239)),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "   Enter the quantity",
                                hintStyle: TextStyle(
                                    color: const Color(0xff74787E),
                                    fontSize: 6.sp)),
                          ),
                        )
                      ],
                    ),
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(ctx);
                          },
                          child: Container(
                            width: 70.w,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.sp),
                                child: Text(
                                  "Reset",
                                  style: TextStyle(color: Colors.grey.shade800),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Gap(4.sp),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(ctx);
                          },
                          child: Container(
                            width: 70.w,
                            decoration: BoxDecoration(
                              color: const Color(0xff4285F4),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.2.sp),
                                child: const Text("Save & Next",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
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
      width: 0.45.sw,
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1890FF).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(4.sp),
                    child: Icon(
                      icon,
                      size: 8.sp,
                      color: const Color(0xFF1890FF),
                    ),
                  ),
                ),
                const Gap(10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 7.sp,
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
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xff333333),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(6.w),
                subtitle,
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class WeeklyOverviewChart extends StatefulWidget {
  WeeklyOverviewChart({Key? key}) : super(key: key);

  @override
  _WeeklyOverviewChartState createState() => _WeeklyOverviewChartState();
}

class _WeeklyOverviewChartState extends State<WeeklyOverviewChart> {
  String selectedPeriod = 'Weekly';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Overview',
                    style: TextStyle(
                      fontSize: 8.sp,
                      fontWeight: FontWeight.w600,
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
                        _buildTimeButton('Today', selectedPeriod == 'Today'),
                        _buildTimeButton('Weekly', selectedPeriod == 'Weekly'),
                        _buildTimeButton(
                            'Monthly', selectedPeriod == 'Monthly'),
                      ],
                    ),
                  ),
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
      ),
    );
  }

  Widget _buildTimeButton(String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPeriod = text;
          // Update the chart data based on the selected period
          // For simplicity, we are not changing the data here
          // Update the chart data based on the selected period
          if (selectedPeriod == 'Today') {
            // Generate random data for today
            weeklyData.forEach((data) {
              data['salesTarget'] = Random().nextInt(300) + 100;
              data['achievedTarget'] = Random().nextInt(300) + 100;
              data['isHoliday'] = false;
            });
          } else if (selectedPeriod == 'Weekly') {
            // Generate random data for the week
            weeklyData.forEach((data) {
              data['salesTarget'] = Random().nextInt(300) + 100;
              data['achievedTarget'] = Random().nextInt(300) + 100;
              data['isHoliday'] = data['day'] == 'Sat' || data['day'] == 'Sun';
            });
          } else if (selectedPeriod == 'Monthly') {
            // Generate random data for the month
            weeklyData.forEach((data) {
              data['salesTarget'] = Random().nextInt(300) + 100;
              data['achievedTarget'] = Random().nextInt(300) + 100;
              data['isHoliday'] = false;
            });
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6.sp, vertical: 1.9.sp),
        margin: EdgeInsets.symmetric(vertical: 0.8.sp, horizontal: 0.8.sp),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
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
          fontSize: 10,
          color: Colors.black,
        ),
      ),
    ],
  );
}
