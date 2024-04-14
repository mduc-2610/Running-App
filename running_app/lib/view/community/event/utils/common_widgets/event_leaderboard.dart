import 'dart:math';

import 'package:flutter/material.dart';
import 'package:running_app/models/activity/event.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/view/community/event/utils/common_widgets/event_leaderboard_text.dart';

class EventLeaderboard extends StatelessWidget {
  final Random random = Random();
  final DetailEvent? event;
  final String? firstColumnName;
  final String? secondColumnName;
  final String? thirdColumnName;
  final String? fourthColumnName;
  final double? tableHeight;
  final List<dynamic>? participants;
  final List<dynamic>? groups;
  final ScrollController? controller;

  EventLeaderboard({
    this.event,
    this.firstColumnName,
    this.secondColumnName,
    this.thirdColumnName,
    this.fourthColumnName,
    this.controller,
    this.tableHeight,
    this.participants,
    this.groups,
    super.key});

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
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(
              bottom: 8
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: media.width * 0.1,
                      child: EventLeaderboardText(fontSize: FontSize.SMALL, fontWeight: FontWeight.w700, text: 'Rank'),
                    ),
                    SizedBox(width: media.width * 0.02,),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: media.width * 0.35,
                      child: EventLeaderboardText(fontSize: FontSize.SMALL, fontWeight: FontWeight.w700, text: secondColumnName ?? "Athlete name"),
                    )
                  ]),
              Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: media.width * 0.2,
                    child: EventLeaderboardText(
                        fontSize: FontSize.SMALL,
                        fontWeight: FontWeight.w700,
                        text: 'Total (km)'
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: media.width * 0.15,
                    child: EventLeaderboardText(fontSize: FontSize.SMALL, fontWeight: FontWeight.w700, text: 'Time'),
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: tableHeight,
          child: SingleChildScrollView(
            child: Column(
              children: [
                for(var entity in
                ((event?.competition == "Group")
                    ? groups
                    : participants) ?? [])...[
                  CustomTextButton(
                    onPressed: () {
                      Navigator.pushNamed
                        (context,
                          '${(event?.competition == "Individual")
                          ? '/event_member_detail'
                          : '/event_group_detail'
                          }',
                        arguments: {
                          "id": entity?.id, // Group id
                          "participant": event?.competition == "Individual" ? entity : null,
                          "rank": groups?.indexOf(entity),
                        }
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 12
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(width: 1, color: Color(0xff746cb3))
                          )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                  alignment: Alignment.centerLeft,
                                  width: media.width * 0.05,
                                  child: EventLeaderboardText(
                                      text: (( ((event?.competition == "Group")
                                          ? groups
                                          : participants) ?? []).indexOf(entity) + 1).toString()

                                  )
                              ),
                              SizedBox(width: media.width * 0.02,),
                              Container(
                                alignment: Alignment.centerLeft,
                                width: media.width * 0.4,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.asset(
                                        "assets/img/community/ptit_logo.png",
                                        width: 35,
                                        height: 35,
                                      ),
                                    ),
                                    SizedBox(width: media.width * 0.02,),
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: media.width * 0.29,
                                              child: EventLeaderboardText(
                                                text: entity?.name,
                                              ),
                                            ),
                                            SizedBox(height: 5,),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "-  ",
                                                  style: TxtStyle.descSection,
                                                  textAlign: TextAlign.left,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: 17,
                                                      height: 17,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(30),
                                                        color: TColor.ACCEPTED
                                                      ),
                                                      child: Icon(
                                                        Icons.check,
                                                        color: TColor.PRIMARY_TEXT,
                                                        size: 15
                                                      )
                                                    ),
                                                    SizedBox(width: media.width * 0.01,),
                                                    Text(
                                                      "Completed",
                                                      style: TextStyle(
                                                        color: TColor.ACCEPTED,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                  alignment: Alignment.centerLeft,
                                  width: media.width * 0.15,
                                  child: EventLeaderboardText(text: "${entity?.totalDistance}")
                              ),
                              // SizedBox(width: media.width * 0.1,),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  width: media.width * 0.15,
                                  child: EventLeaderboardText(text: entity?.totalDuration)
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ]
                // DataTable(
                //     border: const TableBorder(
                //         horizontalInside: BorderSide(width: 2, color: Color(0xff746cb3))
                //     ),
                //     columnSpacing: 12, horizontalMargin: 0,
                //     columns: [
                //       DataColumn(
                //     label: Container(
                //       alignment: Alignment.centerLeft,
                //       child: const EventLeaderboardText(text: '1'),
                //     ),
                //     numeric: true,
                //     tooltip: 'Athlete Rank',
                //     onSort: (columnIndex, ascending) {
                //     },
                //   ),
                //   DataColumn(
                //     label: Row(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       children: [
                //         ClipRRect(
                //           borderRadius: BorderRadius.circular(50),
                //           child: Image.asset(
                //             "assets/img/community/ptit_logo.png",
                //             width: 30,
                //             height: 30,
                //           ),
                //         ),
                //         SizedBox(width: media.width * 0.02,),
                //         Container(
                //             alignment: Alignment.centerLeft,
                //             child: SizedBox(
                //               width: media.width * 0.25,
                //               child: EventLeaderboardText(
                //                 text: "adadadadadasd",
                //               ),
                //             )
                //             ),
                //       ],
                //     ),
                //     numeric: false,
                //     tooltip: 'Athlete Name',
                //   ),
                //   DataColumn(
                //     label: Center(
                //       child: EventLeaderboardText(text: '6.32'),
                //     ),
                //     numeric: true,
                //     tooltip: 'Total Distance',
                //   ),
                //   DataColumn(
                //     label: Center(
                //       child: EventLeaderboardText(text: '4h11m'),
                //     ),
                //     numeric: true,
                //     tooltip: 'Athlete Time',
                //   ),
                // ],
                //     rows: [
                //
                //   for (var participant in participants ?? []) ...[
                //     DataRow(
                //         cells: [
                //           DataCell(
                //             Center(
                //               child: Container(
                //                   alignment: Alignment.center,
                //                   child: EventLeaderboardText(text: (participants!.indexOf(participant) + 1).toString())),
                //             ),
                //           ),
                //           DataCell(
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.start,
                //               children: [
                //                 ClipRRect(
                //                   borderRadius: BorderRadius.circular(50),
                //                   child: Image.asset(
                //                     "assets/img/community/ptit_logo.png",
                //                     width: 30,
                //                     height: 30,
                //                   ),
                //                 ),
                //                 SizedBox(width: media.width * 0.02,),
                //                 Container(
                //                     alignment: Alignment.centerLeft,
                //                     child: SizedBox(
                //                       width: media.width * 0.25,
                //                       child: EventLeaderboardText(
                //                           text: participant?.username,
                //                       ),
                //                     )),
                //               ],
                //             ),
                //           ),
                //           DataCell(
                //             Center(
                //                 child: Container(
                //                   alignment: Alignment.centerLeft,
                //                   child: EventLeaderboardText(text: generateRandomDistance()),
                //                 )),
                //           ),
                //           DataCell(Center(
                //               child: Container(
                //                 alignment: Alignment.centerLeft,
                //                 child: EventLeaderboardText(text: '${generateRandomTime().split(":")[0]}h${generateRandomTime().split(":")[1]}m'),
                //               ))),
                //         ]),
                //   ]
                // ]),
              ],
            ),
          ),
        ),
      ],
    );
  }
}