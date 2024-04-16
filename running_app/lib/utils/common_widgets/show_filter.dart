import 'dart:async';

import 'package:flutter/material.dart';
import 'package:running_app/utils/common_widgets/main_button.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/constants.dart';

Future<Map<String, String?>> showFilter(
    BuildContext context,
    List<Map<String, dynamic>> choiceSection, {
      String? title,
      VoidCallback? onPressed,
      List? buttonClicked,
      VoidCallback? applyOnPressed,
    }) async {
  Completer<Map<String, String?>> completer = Completer<Map<String, String?>>();
  var media = MediaQuery.of(context).size;

  double totalHeight = 0;
  for (var choice in choiceSection) {
    int itemCount = (choice['list'] as List).length;
    totalHeight += media.height * (itemCount <= 2 ? 0.12 : 0.19);
  }
  totalHeight += media.height * 0.17;

  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      List buttonClickedStateList = [...buttonClicked ?? []];
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: totalHeight,
            decoration: BoxDecoration(
              color: TColor.PRIMARY_BACKGROUND,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
              border: Border(
                top: BorderSide(width: 1, color: TColor.BORDER_COLOR),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: TColor.BORDER_COLOR),
                      ),
                    ),
                    child: ListTile(
                      title: Center(
                        child: Text(
                          title ?? "Filter",
                          style: TxtStyle.headSection,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: media.height * 0.01),
                  Column(
                    children: [
                      for (int i = 0; i < choiceSection.length; i++)...[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MainWrapper(
                              child: Text(
                                choiceSection[i]["title"],
                                style: TxtStyle.headSection,
                              ),
                            ),
                            SizedBox(height: media.height * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: media.width * 0.95,
                                  height: media.height * (choiceSection[i]["list"].length > 2 ? 0.14 : 0.07),
                                  child: IntrinsicHeight(
                                    child: GridView.builder(
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 12.0,
                                          mainAxisSpacing: 12.0,
                                          childAspectRatio: 3.7),
                                      itemCount: choiceSection[i]["list"].length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return SizedBox(
                                          child: CustomMainButton(
                                            background: Colors.transparent,
                                            borderWidth: 2,
                                            borderWidthColor: (buttonClickedStateList[i] ==
                                                choiceSection[i]["list"][index])
                                                ? TColor.PRIMARY
                                                : TColor.BORDER_COLOR,
                                            horizontalPadding: 0,
                                            verticalPadding: 16,
                                            onPressed: () {
                                              setState(() {
                                                buttonClickedStateList[i] = (buttonClickedStateList[i] !=
                                                    choiceSection[i]["list"][index])
                                                    ? choiceSection[i]["list"][index]
                                                    : "";
                                              });
                                            },
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 10
                                                ),
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    '${choiceSection[i]["list"][index]}',
                                                    style: TextStyle(
                                                      color: (buttonClickedStateList[i] ==
                                                          choiceSection[i]["list"][index])
                                                          ? Colors.white // Change color here
                                                          : TColor.PRIMARY_TEXT,
                                                      fontSize: FontSize.NORMAL,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ]
                    ],
                  ),
                  SizedBox(height: media.height * 0.01),
                  MainWrapper(
                    bottomMargin: 3,
                    child: Center(
                      child: SizedBox(
                        width: media.width,
                        child: CustomMainButton(
                          borderRadius: 10,
                          horizontalPadding: 0,
                          verticalPadding: 12,
                          onPressed: () {
                            Map<String, String> result = {};
                            for (int i = 0; i < buttonClickedStateList.length; i++) {
                              result[choiceSection[i]["title"]] = buttonClickedStateList[i];
                            }
                            completer.complete(result);
                            Navigator.of(context).pop();
                            applyOnPressed?.call();
                          },
                          child: Text(
                            "Apply",
                            style: TxtStyle.normalText,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    },
  );
  return completer.future;
}

