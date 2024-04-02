import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:running_app/models/account/user.dart';
import 'package:running_app/utils/common_widgets/app_bar.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/icon_button.dart';
import 'package:running_app/utils/common_widgets/input_decoration.dart';
import 'package:running_app/utils/common_widgets/main_button.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/common_widgets/text_form_field.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/function.dart';
import 'package:running_app/utils/providers/token_provider.dart';
import 'package:running_app/utils/common_widgets/show_action_list.dart';
import 'package:running_app/view/community/utils/common_widgets/member_approval_layout.dart';
import 'package:running_app/view/community/utils/common_widgets/member_layout.dart';


class MemberManagementPrivateView extends StatefulWidget {
  const MemberManagementPrivateView({super.key});

  @override
  State<MemberManagementPrivateView> createState() => MemberManagementPrivateViewState();
}

class MemberManagementPrivateViewState extends State<MemberManagementPrivateView> {
  String _showLayout = "Approval";
  String token = "";
  List<User>? participants;

  void initToken() {
    setState(() {
      token = Provider.of<TokenProvider>(context).token;
    });
  }

  void getParticipants() {
    setState(() {
      Map<String, dynamic> arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      participants = arguments["participants"];
    });
  }

  @override
  void didChangeDependencies() {
    initToken();
    getParticipants();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: const Header(title: "Member management", noIcon: true,),
        backgroundImage: TImage.PRIMARY_BACKGROUND_IMAGE,
      ),
      body: DefaultBackgroundLayout(
        child: Stack(
          children: [
            MainWrapper(
              bottomMargin: 0,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: CustomTextFormField(
                      decoration: CustomInputDecoration(
                          hintText: "Search athlete name or tag name",
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20
                          ),
                          prefixIcon: Icon(
                              Icons.search_rounded,
                              color: TColor.DESCRIPTION
                          )
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),

                  SizedBox(height: media.height * 0.015,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (var x in ["Approval", "Joined"])...[
                        SizedBox(
                          width: media.width * 0.46,
                          // height: media.height * 0.07,
                          child: CustomTextButton(
                            onPressed: () {
                              setState(() {
                                _showLayout = x;
                              });
                            },
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: media.width * 0.07)),
                                backgroundColor: MaterialStateProperty.all<
                                    Color?>(
                                    _showLayout == x ? TColor.PRIMARY : null),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10)))),
                            child: Text(x,
                                style: TextStyle(
                                  color: TColor.PRIMARY_TEXT,
                                  fontSize: FontSize.SMALL,
                                  fontWeight: FontWeight.w600,
                                )
                              ,textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ],
                  ),
                  SizedBox(height: media.height * 0.015,),
                  (_showLayout == "Approval")
                      ? MemberApprovalLayout(participants: participants,)
                      : SizedBox(
                      height: media.height * 0.72,
                      child: MemberLayout(layout: "Joined", participants: participants,))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
