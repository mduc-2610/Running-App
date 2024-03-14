import 'dart:math';

import 'package:flutter/material.dart';
import 'package:running_app/models/account/user.dart';
import 'package:running_app/utils/constants.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final fontWeight;

  const CustomText({this.fontSize, this.fontWeight, required this.text, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: TColor.PRIMARY_TEXT,
          fontSize: fontSize ?? 14,
          fontWeight: fontWeight),
      // overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
class AthleteTable extends StatelessWidget {
  final Random random = Random();
  final double? topMargin;
  final List<DetailUser>? participants;
  AthleteTable({this.topMargin, this.participants, super.key});

  // Generate random data for demonstration
  String generateRandomName() {
    List<String> names = [
      'John Doe',
      'Alice Smith',
      'Michael Johnson',
      'Emily Brown',
      'David Lee',
      'Sophia Garcia',
      'John Doe',
      'Alice Smith',
      'Michael Johnson',
      'Emily Brown',
      'David Lee',
      'Sophia Garcia',
      'John Doe',
      'Alice Smith',
      'Michael Johnson',
      'Emily Brown',
      'David Lee',
      'Sophia Garcia',
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
    return SingleChildScrollView(
      child: Container(
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
                child: const CustomText(fontWeight: FontWeight.w700, text: 'Rank    '),
              ),
              numeric: true,
              tooltip: 'Athlete Rank',
              onSort: (columnIndex, ascending) {
              },
            ),
            const DataColumn(
              label: Center(
                child: CustomText(fontWeight: FontWeight.w700, text: 'Athlete Name'),
              ),
              numeric: false,
              tooltip: 'Athlete Name',
            ),
            const DataColumn(
              label: Center(
                child: CustomText(fontWeight: FontWeight.w700, text: 'Total (km)'),
              ),
              numeric: true,
              tooltip: 'Total Distance',
            ),
            const DataColumn(
              label: Center(
                child: CustomText(fontWeight: FontWeight.w700, text: 'Time       '),
              ),
              numeric: true,
              tooltip: 'Athlete Time',
            ),
          ], rows: [

            for (var participant in participants ?? []) ...[
              DataRow(
                  cells: [
                    DataCell(
                      Center(
                        child: Container(
                            alignment: Alignment.center,
                            child: CustomText(text: (participants!.indexOf(participant) + 1).toString())),
                      ),
                    ),
                    DataCell(
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              "assets/img/community/ptit_logo.png",
                              width: 30,
                              height: 30,
                            ),
                          ),
                          SizedBox(width: media.width * 0.02,),
                          Container(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                width: media.width * 0.25,
                                child: CustomText(
                                    text: participant?.username,
                                ),
                              )),
                        ],
                      ),
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
      ),
    );
  }
}