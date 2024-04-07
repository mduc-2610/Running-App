import 'dart:async';

import 'package:flutter/material.dart';
import 'package:running_app/utils/constants.dart';

Future<int> showMonth(BuildContext context) async {
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  Completer<int> completer = Completer<int>();
  String month = "";
  String year = "";
  var media = MediaQuery.of(context).size;
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context:
      context,
    builder: (BuildContext context) {
      return Container(
        height: media.height * 0.4,
        decoration: BoxDecoration(
            color: TColor.PRIMARY_BACKGROUND,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
            border:
            Border(top: BorderSide(width: 1, color: TColor.BORDER_COLOR))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                      BorderSide(width: 1, color: TColor.BORDER_COLOR))),
              child: ListTile(
                shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                ),
                title: Center(
                    child: Text(
                      "Month",
                      style: TxtStyle.headSection,
                    )),
              ),
            ),
            Container(
              height: media.height * 0.33,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: 12,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Center(
                              child: Text(
                                '${months[index]}',
                                style: TextStyle(
                                    color: TColor.PRIMARY_TEXT,
                                    fontSize: FontSize.NORMAL),
                              )),
                          onTap: () async {
                            completer.complete(Month.MONTH_MAP[months[index]]);
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    },
  );
  return completer.future;
}


Future<int?> showYear(BuildContext context) async {
  Completer<int?> completer = Completer<int?>();
  var media = MediaQuery.of(context).size;
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context:
    context,
    builder: (BuildContext context) {
      return Container(
        height: media.height * 0.4,
        decoration: BoxDecoration(
            color: TColor.PRIMARY_BACKGROUND,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
            border:
            Border(top: BorderSide(width: 1, color: TColor.BORDER_COLOR))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                      BorderSide(width: 1, color: TColor.BORDER_COLOR))),
              child: ListTile(
                shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                ),
                title: Center(
                    child: Text(
                      "Year",
                      style: TxtStyle.headSection,
                    )),
              ),
            ),
            Container(
              height: media.height * 0.33,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: DateTime.now().year - 2015,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Center(
                              child: Text(
                                '${2018 + index}',
                                style: TextStyle(
                                    color: TColor.PRIMARY_TEXT,
                                    fontSize: FontSize.NORMAL),
                              )),
                          onTap: () {
                            completer.complete(2018 + index);
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    },
  ).whenComplete(() {
    if (!completer.isCompleted) {
      completer.complete(null); // Complete with null if not already completed
    }
  });
  return completer.future;
}


Future<dynamic> showDate(
    BuildContext context,
    List<dynamic> dateList,
    ) async {
  Completer<dynamic> completer = Completer<dynamic>();
  var media = MediaQuery.of(context).size;
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context:
    context,
    builder: (BuildContext context) {
      return Container(
        height: media.height * 0.4,
        decoration: BoxDecoration(
            color: TColor.PRIMARY_BACKGROUND,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
            border:
            Border(top: BorderSide(width: 1, color: TColor.BORDER_COLOR))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                      BorderSide(width: 1, color: TColor.BORDER_COLOR))),
              child: ListTile(
                shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                ),
                title: Center(
                    child: Text(
                      "Option",
                      style: TxtStyle.headSection,
                    )),
              ),
            ),
            Container(
              height: media.height * 0.33,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: dateList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Center(
                              child: Text(
                                '${dateList[index]["dateRepresent"]}',
                                style: TextStyle(
                                    color: TColor.PRIMARY_TEXT,
                                    fontSize: FontSize.NORMAL),
                              )),
                          onTap: () async {
                            completer.complete(dateList[index]);
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    },
  );
  return completer.future;
}

