import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/utils/layouts.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/transaction_today.dart';
import 'package:gap/gap.dart';

class Stats extends StatefulWidget {
  const Stats({Key? key}) : super(key: key);

  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  List<Color> gradientColors = [
    Styles.blueColor,
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    final size = Layouts.getSize(context);
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      // appBar: 
      // myAppBar(
      //     title: 'Statistics',
      //     implyLeading: true,
      //     context: context,
      //     hasAction: true),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: ListView(
          scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
          children: <Widget>[
            SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () => Scaffold.of(context).openDrawer(),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Styles.transparentColor,
                              ),
                              child: const Icon(
                                Icons.menu,
                                color: Styles.primaryColor,
                              ),
                            ),
                          ),
                          const Gap(10),
                          Center(
                            child: Text(
                              Str.stats,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                  color: Styles.textColor, fontSize: 19),
                            ),
                          ),
                          const Gap(10),
                          InkWell(
                            // onTap: () => Navigator.pushNamed(context, RouteSTR.addLoanM),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Styles.transparentColor,
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Styles.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Styles.thirdColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
                      child: Text('Total Balance',
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.8)))),
                  const Divider(
                    color: Styles.primaryColor,
                    thickness: 2,
                  ),
                  Container(
                      padding: const EdgeInsets.fromLTRB(20, 25, 20, 30),
                      child: const Text('\$20,000.00 USD',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold))),
                ],
              ),
            ),
            const Gap(20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Styles.thirdColor,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    width: size.width * 0.44,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Styles.primaryColor),
                    child: const Text('Income',
                        style: TextStyle(color: Styles.thirdColor, fontSize: 18)),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    width: size.width * 0.44,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.transparent),
                    child: Text('Expenses',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.8), fontSize: 18)),
                  ),
                ],
              ),
            ),
            const Gap(20),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                color: Styles.thirdColor,
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(22, 22, 22, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0.7),
                              child: const Icon(Icons.show_chart_rounded,
                                  color: Colors.orange),
                            ),
                            const Gap(6),
                            CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0.15),
                              child: Icon(CupertinoIcons.eye_slash_fill,
                                  color: Colors.white.withOpacity(0.8), size: 17),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Styles.accentColor,
                          ),
                          child: Row(
                            children: [
                              const Text('This week',
                                  style: TextStyle(color: Styles.primaryColor)),
                              const Gap(8),
                              Icon(CupertinoIcons.chevron_down,
                                  color: Styles.primaryColor.withOpacity(0.8), size: 17)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 1.70,
                    child: LineChart(
                      mainData(),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Transactions',
                    style: TextStyle(
                        color: Styles.textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Text('View all',
                        style: TextStyle(
                            color: Styles.textColor.withOpacity(0.8), fontSize: 16)),
                    const Gap(3),
                    Transform.rotate(
                        angle: math.pi,
                        child: Icon(Icons.keyboard_backspace_rounded,
                            color: Styles.textColor.withOpacity(0.8), size: 18))
                  ],
                )
              ],
            ),
            const Gap(20),
            const TransactionTodayList(),
          ],
        ),
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.transparent,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      // titlesData: FlTitlesData(
      //   show: true,
      //   rightTitles: SideTitles(showTitles: false),
      //   topTitles: SideTitles(showTitles: false),
      //   bottomTitles: SideTitles(
      //     showTitles: true,
      //     reservedSize: 40,
      //     interval: 1.1,
      //     getTextStyles: (context, value) =>
      //         TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 17),
      //     getTitles: (value) {
      //       switch (value.toInt()) {
      //         case 1:
      //           return 'S';
      //         case 2:
      //           return 'M';
      //         case 3:
      //           return 'T';
      //         case 4:
      //           return 'W';
      //         case 5:
      //           return 'T';
      //         case 6:
      //           return 'F';
      //         case 7:
      //           return 'S';
      //       }
      //       return '';
      //     },
      //     margin: 15,
      //   ),
      //   leftTitles: SideTitles(
      //     showTitles: false,
      //     interval: 1,
      //     getTextStyles: (context, value) => const TextStyle(
      //       color: Color(0xff67727d),
      //       fontWeight: FontWeight.bold,
      //       fontSize: 15,
      //     ),
      //     getTitles: (value) {
      //       switch (value.toInt()) {
      //         case 1:
      //           return '10k';
      //         case 3:
      //           return '30k';
      //         case 5:
      //           return '50k';
      //       }
      //       return '';
      //     },
      //     reservedSize: 32,
      //     margin: 12,
      //   ),
      // ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d), width: 1),
      ),
      minX: 0,
      maxX: 9,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3),
            FlSpot(1.5, 3),
            FlSpot(3.5, 5),
            FlSpot(5, 3),
            FlSpot(6.5, 4),
            FlSpot(8, 2.8),
            FlSpot(9, 3),
          ],
          isCurved: true,
          color: gradientColors,
          barWidth: 2.5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            //applyCutOffY: true,
            //cutOffY: 100,
            gradientFrom: const Offset(100, 10),
            gradientTo: const Offset(100, 100),
            show: true,
            colors: [
              Colors.indigo.withOpacity(0.1),
              Colors.indigo,
            ],
          ),
        ),
      ],
    );
  }
}
