import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:running_app/models/account/leaderboard.dart';
import 'package:running_app/models/account/user.dart';
import 'package:running_app/utils/common_widgets/layout/app_bar.dart';
import 'package:running_app/utils/common_widgets/layout/header.dart';
import 'package:running_app/utils/common_widgets/button/icon_button.dart';
import 'package:running_app/utils/common_widgets/form/input_decoration.dart';
import 'package:running_app/utils/common_widgets/layout/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/layout/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/button/text_button.dart';
import 'package:running_app/utils/common_widgets/form/text_form_field.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/providers/token_provider.dart';
import 'package:running_app/view/community/utils/common_widgets/member_layout.dart';

class MemberManagementPublicView extends StatefulWidget {
  const MemberManagementPublicView({super.key});

  @override
  State<MemberManagementPublicView> createState() => MemberManagementPublicViewState();
}

class MemberManagementPublicViewState extends State<MemberManagementPublicView> {
  String token = "";
  List<Leaderboard>? participants;

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
      body: SingleChildScrollView(
        child: DefaultBackgroundLayout(
          child: Stack(
            children: [
              MainWrapper(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: CustomTextFormField(
                        decoration: CustomInputDecoration(
                            hintText: "Search by athlete name or id",
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
                    MemberLayout(layout: "Joined", participants: participants,)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


