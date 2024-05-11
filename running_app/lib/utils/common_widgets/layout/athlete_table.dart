import 'dart:math';

import 'package:flutter/material.dart';
import 'package:running_app/utils/common_widgets/layout/loading.dart';
import 'package:running_app/utils/common_widgets/button/text_button.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/function.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final fontWeight;
  final Color? color;

  const CustomText({
    this.fontSize,
    this.fontWeight,
    this.color,
    required this.text,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color ?? TColor.PRIMARY_TEXT,
          fontSize: fontSize ?? 14,
          fontWeight: fontWeight),
      // overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
class AthleteTable extends StatefulWidget {
  final double? tableHeight;
  final List<dynamic> participants;
  final ScrollController? controller;
  final int startIndex;
  final VoidCallback? distanceOnPressed;
  final VoidCallback? timeOnPressed;
  final bool? isLoading;
  final bool reachEnd;

  AthleteTable({
    this.controller,
    this.tableHeight,
    required this.participants,
    this.startIndex = 1,
    this.distanceOnPressed,
    this.timeOnPressed,
    this.isLoading,
    this.reachEnd = false,
    super.key
  });

  @override
  State<AthleteTable> createState() => _AthleteTableState();
}

class _AthleteTableState extends State<AthleteTable> {
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
    List participants = widget.participants;
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
                      child: CustomText(fontSize: FontSize.SMALL, fontWeight: FontWeight.w700, text: ' Rank'),
                  ),
                  SizedBox(width: media.width * 0.02,),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: media.width * 0.35,
                    child: CustomText(fontSize: FontSize.SMALL, fontWeight: FontWeight.w700, text: 'Athlete name'),
                  )
              ]),
              Row(
                children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      width: media.width * 0.25,
                      child: CustomTextButton(
                          onPressed: () {
                            widget.distanceOnPressed?.call();
                            setState(() {
                              buttonClicked = "Total (km)";
                            });
                          },
                          child: Row(
                            children: [
                              CustomText(
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
                          widget.timeOnPressed?.call();
                          setState(() {
                            buttonClicked = "Time";
                          });
                        },
                        child: Row(
                          children: [
                            CustomText(
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
              controller: widget.controller,
              child: Column(
                children: [
                  // for(int i = 0; i < 30; i++)
                  for(int i = widget.startIndex; i < participants.length; i++)...[
                    CustomTextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/user', arguments: {
                          "id": participants[i].userId,
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
                                    child: CustomText(text: " ${i}")
                                ),
                                SizedBox(width: media.width * 0.02,),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width: media.width * 0.35,
                                  child: Row(
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
                                              text: participants[i].name,
                                            ),
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
                                    child: CustomText(text: "${participants[i].totalDistance ?? 0}")
                                ),
                                // SizedBox(width: media.width * 0.1,),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    width: media.width * 0.15,
                                    child: CustomText(text: '${formatTimeDuration(participants[i].totalDuration ?? "00:00:00", type: 2)}')
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                  if(widget.reachEnd)...[
                    Loading(reachEnd: true,)
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
                  //       child: const CustomText(text: '1'),
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
                  //               child: CustomText(
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
                  //       child: CustomText(text: '6.32'),
                  //     ),
                  //     numeric: true,
                  //     tooltip: 'Total Distance',
                  //   ),
                  //   DataColumn(
                  //     label: Center(
                  //       child: CustomText(text: '4h11m'),
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
                  //                   child: CustomText(text: (participants!.indexOf(participant) + 1).toString())),
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
                  //                       child: CustomText(
                  //                           text: participants[i].username,
                  //                       ),
                  //                     )),
                  //               ],
                  //             ),
                  //           ),
                  //           DataCell(
                  //             Center(
                  //                 child: Container(
                  //                   alignment: Alignment.centerLeft,
                  //                   child: CustomText(text: generateRandomDistance()),
                  //                 )),
                  //           ),
                  //           DataCell(Center(
                  //               child: Container(
                  //                 alignment: Alignment.centerLeft,
                  //                 child: CustomText(text: '${generateRandomTime().split(":")[0]}h${generateRandomTime().split(":")[1]}m'),
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
            marginTop: media.height * 0.02,
            backgroundColor: Colors.transparent,
          )
        ]
      ],
    );
  }
}