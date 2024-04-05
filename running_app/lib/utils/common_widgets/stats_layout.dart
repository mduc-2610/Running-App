import 'package:flutter/material.dart';
import 'package:running_app/utils/common_widgets/stats_box.dart';

class StatsLayout extends StatelessWidget {
  final String totalDistance;
  final String totalActiveDays;
  final String totalAvgPace;
  final String totalTime;
  final String totalAvgHeartBeat;
  final String totalAvgCadence;
  final int boxNumber;

  StatsLayout({
    required this.totalDistance,
    required this.totalActiveDays,
    required this.totalAvgPace,
    required this.totalTime,
    required this.totalAvgHeartBeat,
    required this.totalAvgCadence,
    this.boxNumber = 6,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(boxNumber >= 1)...[
              StatsBoxLayout(
                icon: Icons.social_distance,
                iconColor: Color(0xff000000),
                iconBackgroundColor: Color(0xffffffff),
                backgroundColor: Color(0xff232b35),
                firstText: totalDistance == "0.0" ? "0" : totalDistance,
                secondText: "Total Distance",
                thirdText: " (km)",
                firstTextColor: Color(0xffffffff),
                secondTextColor: Color(0xffcdcdcd),
                layout: 1,
              ),
              SizedBox(
                height: media.height * 0.01,
              ),
            ],
            if(boxNumber >= 3)...[
              StatsBoxLayout(
                icon: Icons.speed_rounded,
                iconColor: Color(0xffffffff),
                iconBackgroundColor: Color(0xff6c6cf2),
                backgroundColor: Color(0xffe1e3fd),
                firstText: '${totalAvgPace}',
                secondText: "Avg. Pace",
                thirdText: " (min/km)",
                firstTextColor: Color(0xff000000),
                secondTextColor: Color(0xff344152),
                layout: 2,
              ),
              SizedBox(
                height: media.height * 0.01,
              ),
            ],
            if(boxNumber >= 5)...[
              StatsBoxLayout(
                icon: Icons.monitor_heart_outlined,
                iconColor: Color(0xffffffff),
                iconBackgroundColor: Color(0xfff3af9b),
                backgroundColor: Color(0xfffcefeb),
                firstText: totalAvgHeartBeat,
                secondText: "Avg. Heartbeat",
                thirdText: " (bpm)",
                firstTextColor: Color(0xff000000),
                secondTextColor: Color(0xff344152),
                layout: 2,
              ),
            ],
          ]
        ),
        Column(
          children: [
            if(boxNumber >= 2)...[
              StatsBoxLayout(
                icon: Icons.calendar_today_rounded,
                iconColor: Color(0xffffffff),
                iconBackgroundColor: Color(0xfff5c343),
                backgroundColor: Color(0xfffdf3d3),
                firstText: totalActiveDays.padLeft(2, '0'),
                secondText: "Active Days",
                firstTextColor: Color(0xff000000),
                secondTextColor: Color(0xff344152),
                layout: 2,
              ),
              SizedBox(
                height: media.height * 0.01,
              ),
            ],
            if(boxNumber >= 4)...[
              StatsBoxLayout(
                icon: Icons.access_time_rounded,
                iconColor: Color(0xffffffff),
                iconBackgroundColor: Color(0xff232b35),
                backgroundColor: Color(0xfff4f6f8),
                firstText: totalTime,
                secondText: "Total Time",
                firstTextColor: Color(0xff000000),
                secondTextColor: Color(0xff344152),
                layout: 1,
              ),
              SizedBox(
                height: media.height * 0.01,
              ),
            ],
            if(boxNumber >= 6)...[
              StatsBoxLayout(
                icon: Icons.directions_run_rounded,
                iconColor: Color(0xffffffff),
                iconBackgroundColor: Color(0xff316ff6),
                backgroundColor: Color(0xff6098f8),
                firstText: totalAvgCadence,
                secondText: "Avg. Cadence",
                thirdText: " (spm)",
                firstTextColor: Color(0xffffffff),
                secondTextColor: Color(0xffffffff),
                layout: 2,
              ),
            ],
          ],
        )
      ],
    );
  }
}
