import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        .toStringAsFixed(2); // Random distance between 0 and 100 km
  }

  String generateRandomTime() {
    int hours = random.nextInt(24); // Random hours between 0 and 23
    int minutes = random.nextInt(60); // Random minutes between 0 and 59
    return '$hours:$minutes'; // Format: HH:MM
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Container(
      width: media.width,
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.all(0),
      // margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          border: Border(
              // top: BorderSide(width: 1, color: Color(0xff746cb3)),
              bottom: BorderSide(width: 2, color: Color(0xff746cb3))
          ),
      ),
      child: Center(
        child: DataTable(
            border: TableBorder(
                horizontalInside: BorderSide(width: 2, color: Color(0xff746cb3))
            ),
            columnSpacing: 12, horizontalMargin: 0, columns: [
          DataColumn(
            label: Container(
              alignment: Alignment.centerLeft,
              child: CustomText(text: 'Rank    '),
            ),
            numeric: true,
            tooltip: 'Athlete Rank',
            onSort: (columnIndex, ascending) {
              // Implement sorting logic here if needed
            },
          ),
          DataColumn(
            label: Center(
              child: CustomText(text: 'Athlete Name'),
            ),
            numeric: false,
            tooltip: 'Athlete Name',
          ),
          DataColumn(
            label: Center(
              child: CustomText(text: 'Total (km)'),
            ),
            numeric: true,
            tooltip: 'Total Distance',
          ),
          DataColumn(
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