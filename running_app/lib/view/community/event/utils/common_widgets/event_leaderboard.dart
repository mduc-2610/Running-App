import 'dart:math';

import 'package:flutter/material.dart';
import 'package:running_app/models/activity/event.dart';
import 'package:running_app/utils/common_widgets/layout/athlete_table.dart';
import 'package:running_app/utils/common_widgets/layout/loading.dart';
import 'package:running_app/utils/common_widgets/button/text_button.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/function.dart';
import 'package:running_app/view/community/event/utils/common_widgets/event_leaderboard_text.dart';

class EventLeaderboard extends StatefulWidget {
  final DetailEvent? event;
  final String? firstColumnName;
  final String? secondColumnName;
  final String? thirdColumnName;
  final String? fourthColumnName;
  final double? tableHeight;
  final List<dynamic>? participants;
  final List<dynamic>? groups;
  final ScrollController? controller;
  final VoidCallback? distanceOnPressed;
  final VoidCallback? timeOnPressed;
  final bool? isLoading;
  final int startIndex;


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
    this.distanceOnPressed,
    this.timeOnPressed,
    this.startIndex = 1,
    this.isLoading,
    super.key});

  @override
  State<EventLeaderboard> createState() => _EventLeaderboardState();
}

class _EventLeaderboardState extends State<EventLeaderboard> {
  final Random random = Random();
  String buttonClicked = "Total (km)";

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
    // print(participants);
    var media = MediaQuery.sizeOf(context);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(
              bottom: 8
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
                      width: media.width * 0.12,
                      child: EventLeaderboardText(fontSize: FontSize.SMALL, fontWeight: FontWeight.w700, text: ' Rank'),
                    ),
                    SizedBox(width: media.width * 0.02,),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: media.width * 0.35,
                      child: EventLeaderboardText(fontSize: FontSize.SMALL, fontWeight: FontWeight.w700, text: 'Athlete name'),
                    )
                  ]),
              Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: media.width * 0.25,
                    child: CustomTextButton(
                        onPressed: () {
                          if(widget.distanceOnPressed !=  null) {
                            widget.distanceOnPressed?.call();
                          }
                          setState(() {
                            buttonClicked = "Total (km)";
                          });
                        },
                        child: Row(
                          children: [
                            EventLeaderboardText(
                                fontSize: FontSize.SMALL,
                                fontWeight: FontWeight.w700,
                                text: 'Total (km)',
                                color: (buttonClicked == "Total (km)") ? TColor.THIRD : TColor.PRIMARY_TEXT,
                            ),
                            SizedBox(width: 2,),
                            Transform.rotate(
                              angle: -90 * 3.14159 / 180,
                              child: Icon(
                                Icons.arrow_back_ios_rounded,
                                color: (buttonClicked == "Total (km)") ? TColor.THIRD : TColor.PRIMARY_TEXT,
                                size: 12,
                              ),)
                          ],
                        )),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: media.width * 0.15,
                    child: CustomTextButton(
                        onPressed: () {
                          if(widget.timeOnPressed !=  null) {
                            widget.timeOnPressed?.call();
                          }
                          setState(() {
                            buttonClicked = "Time";
                          });
                        },
                        child: Row(
                          children: [
                            EventLeaderboardText(
                                fontSize: FontSize.SMALL,
                                fontWeight: FontWeight.w700,
                                text: 'Time',
                                color: (buttonClicked == "Time") ? TColor.THIRD : TColor.PRIMARY_TEXT,
                            ),
                            SizedBox(width: 2,),
                            Transform.rotate(
                              angle: -90 * 3.14159 / 180,
                              child: Icon(
                                Icons.arrow_back_ios_rounded,
                                color: (buttonClicked == "Time") ? TColor.THIRD : TColor.PRIMARY_TEXT,
                                size: 12,
                              ),)
                          ],
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
        if(widget.isLoading == false)...[
          SizedBox(
            height: widget.tableHeight,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // for(int i = 0; i < 30; i++)
                  for(var participant in widget.participants ?? [])...[
                    CustomTextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/user', arguments: {
                          "id": participant?.userId,
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 12
                        ),
                        decoration: const BoxDecoration(
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
                                    width: media.width * 0.08,
                                    child: EventLeaderboardText(text: " ${(widget.participants!.indexOf(participant) + widget.startIndex!).toString()}")
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
                                                  text: participant?.name,
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
                                    child: EventLeaderboardText(text: "${participant?.totalDistance ?? 0}")
                                ),
                                // SizedBox(width: media.width * 0.1,),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    width: media.width * 0.15,
                                    child: EventLeaderboardText(text: '${formatTimeDuration(
                                        participant?.totalDuration ?? "00:00:00", type: 2)}')
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
        ]
        else...[
          Loading(
            marginTop: media.height * 0.2,
            backgroundColor: Colors.transparent,
          )
        ]
      ],
    );
  }
}