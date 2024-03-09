import 'dart:math';

import 'package:flutter/material.dart';
import 'package:running_app/utils/constants.dart';


class CustomText extends StatelessWidget {
  final String text;

  const CustomText({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: TColor.PRIMARY_TEXT,
          fontSize: FontSize.SMALL,
          fontWeight: FontWeight.w500),
      // overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
    );
  }
}

class AthleteTable extends StatelessWidget {
  final Random random = Random();
  final double? topMargin;
  AthleteTable({this.topMargin, super.key});

  // Generate random data for demonstration
  String generateRandomName() {
    List<String> names = [
      'John Doe',
      'Alice Smith',
      'Michael Johnson',
      'Emily Brown',
      'David Lee',
      'Sophia Garcia'
    ];
    return names[random.nextInt(names.length)];
  }

  String generateRandomDistance() {
    return (random.nextDouble() * 100)
        .toStringAsFixed(2);
  }

  String generateRandomTime() {
    int hours = random.nextInt(24);
    int minutes = random.nextInt(60);
    return '$hours:$minutes';
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Container(
      // width: media.width,
      margin: EdgeInsets.only(top: topMargin ?? 0),
      padding: const EdgeInsets.all(0),
      // margin: EdgeInsets.only(right: 10),
      decoration: const BoxDecoration(
          border: Border(
              // top: BorderSide(width: 1, color: Color(0xff746cb3)),
              bottom: BorderSide(width: 2, color: Color(0xff746cb3))
          ),
      ),
      child: Center(
        child: DataTable(
            border: const TableBorder(
                horizontalInside: BorderSide(width: 2, color: Color(0xff746cb3))
            ),
            columnSpacing: 12, horizontalMargin: 0, columns: [
          DataColumn(
            label: Container(
              alignment: Alignment.centerLeft,
              child: const CustomText(text: 'Rank    '),
            ),
            numeric: true,
            tooltip: 'Athlete Rank',
            onSort: (columnIndex, ascending) {
            },
          ),
          const DataColumn(
            label: Center(
              child: CustomText(text: 'Athlete Name'),
            ),
            numeric: false,
            tooltip: 'Athlete Name',
          ),
          const DataColumn(
            label: Center(
              child: CustomText(text: 'Total (km)'),
            ),
            numeric: true,
            tooltip: 'Total Distance',
          ),
          const DataColumn(
            label: Center(
              child: CustomText(text: 'Time       '),
            ),
            numeric: true,
            tooltip: 'Athlete Time',
          ),
        ], rows: [
          for (int i = 0; i < 5; i++) ...[
            DataRow(
                cells: [
                  DataCell(
                    Center(
                      child: Container(
                          alignment: Alignment.center,
                          child: CustomText(text: (i + 1).toString())),
                    ),
                  ),
                  DataCell(
                    Center(
                        child: Container(
                            alignment: Alignment.centerLeft,
                            child: CustomText(text: generateRandomName()))),
                  ),
                  DataCell(
                    Center(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: CustomText(text: generateRandomDistance()),
                        )),
                  ),
                  DataCell(Center(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: CustomText(text: '${generateRandomTime().split(":")[0]}h${generateRandomTime().split(":")[1]}m'),
                      ))),
                ]),
          ]
        ]),
      ),
    );
  }
}