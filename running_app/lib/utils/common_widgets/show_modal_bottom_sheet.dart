import 'package:flutter/material.dart';
import 'package:running_app/utils/constants.dart';

void showActionList(
    BuildContext context,
    List action,
    String title
    ) {
  var itemCount = action.length;
  var media = MediaQuery.sizeOf(context);
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: (title != "" ? 60 : 0) + (itemCount * 60),
        decoration: BoxDecoration(
          color: TColor.PRIMARY_BACKGROUND,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          border: Border(
            top: BorderSide(width: 1, color: TColor.BORDER_COLOR)
          )
        ),
        child: Column(
          children: <Widget>[
            if(title != "")...[
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 1,
                            color: TColor.BORDER_COLOR
                        )
                    )
                ),
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
                        title,
                        style: TxtStyle.headSection,
                      )
                    ),
                ),
              ),
            ],
            Expanded(
              child: ListView.builder(
                itemCount: itemCount,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1,
                                color: TColor.BORDER_COLOR
                            )
                        )
                    ),
                    child: ListTile(
                      title: Center(
                          child: Text(
                            action[index]["text"],
                            style: TextStyle(
                              color: TColor.PRIMARY_TEXT,
                              fontSize: FontSize.NORMAL
                            ),
                          )
                        ),
                        onTap: () {
                          action[index]["onPressed"]();
                          // Navigator.pop(context);
                        },
                      ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}


