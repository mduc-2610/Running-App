
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:running_app/models/account/user.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/view/activity/activity_record_create_view.dart';
import 'package:running_app/view/activity/activity_record_detail_view.dart';
import 'package:running_app/view/activity/activity_record_edit_view.dart';
import 'package:running_app/view/activity/activity_record_stats_view.dart';
import 'package:running_app/view/activity/activity_record_view.dart';
import 'package:running_app/view/community/club/club_create_view.dart';
import 'package:running_app/view/community/club/club_detail_information_view.dart';
import 'package:running_app/view/community/event/create/event_advanced_option_create_view.dart';
import 'package:running_app/view/community/event/create/event_feature_create_view.dart';
import 'package:running_app/view/community/event/create/event_information_create_view.dart';
import 'package:running_app/view/community/event/create/group_create_view.dart';
import 'package:running_app/view/community/event/management/group_management_view.dart';
import 'package:running_app/view/community/event/management/member_management_private_view.dart';
import 'package:running_app/view/community/event/management/member_management_public_view.dart';
import 'package:running_app/view/community/club/club_member_view.dart';
import 'package:running_app/view/community/event/utils/provider/event_advanced_option_create_provider.dart';
import 'package:running_app/view/community/event/utils/provider/event_feature_create_provider.dart';
import 'package:running_app/view/user/other_user_view.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences
import 'package:intl/intl_standalone.dart' if (dart.library.html) 'package:intl/intl_browser.dart';


import 'package:running_app/utils/common_widgets/email_verification.dart';
import 'package:running_app/utils/common_widgets/notification_box.dart';
import 'package:running_app/utils/providers/token_provider.dart';
import 'package:running_app/utils/providers/user_provider.dart';
import 'package:running_app/view/activity/activity_record_list_view.dart';
import 'package:running_app/view/address/address_view.dart';
import 'package:running_app/view/community/club/club_detail_view.dart';
import 'package:running_app/view/community/club/club_list_view.dart';
import 'package:running_app/view/community/community_view.dart';
import 'package:running_app/view/community/event/detail/event_detail_view.dart';
import 'package:running_app/view/community/event/detail/event_member_detail_view.dart';
import 'package:running_app/view/community/event/detail/event_group_detail_view.dart';
import 'package:running_app/view/community/event/event_list_view.dart';
import 'package:running_app/view/community/event/your_event_list_view.dart';
import 'package:running_app/view/home/home_view.dart';
import 'package:running_app/view/home/notification_view.dart';
import 'package:running_app/view/login/get_started_view.dart';
import 'package:running_app/view/login/on_boarding_view.dart';
import 'package:running_app/view/login/profile_create_view.dart';
import 'package:running_app/view/login/sign_in_view.dart';
import 'package:running_app/view/login/sign_up_view.dart';
import 'package:running_app/view/rank/rank_view.dart';
import 'package:running_app/view/store/product_view.dart';
import 'package:running_app/view/store/store_view.dart';
import 'package:running_app/view/user/setting/account_information_setting_view.dart';
import 'package:running_app/view/home/user_discovery_view.dart';
import 'package:running_app/view/user/follow_view.dart';
import 'package:running_app/view/user/setting/notification_setting_view.dart';
import 'package:running_app/view/user/setting/privacy_setting_view.dart';
import 'package:running_app/view/user/setting/setting_view.dart';
import 'package:running_app/view/user/user_view.dart';
import 'package:running_app/view/wallet/wallet.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await findSystemLocale();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token') ?? '';
  String userPref = prefs.getString('user') ?? '';
  bool logged = prefs.getBool('logged') ?? false;
  DetailUser? user = userPref != "" ? DetailUser.fromJson(json.decode(userPref) ?? "") : null ;
  Widget homeScreen = token != "" ? const HomeView() : (logged == false) ? const GetStartedView() : const SignInView();
  try {
    final data = await callRetrieveAPI('account/user', user?.id, null, DetailUser.fromJson, token);
  }
  catch (e) {
    homeScreen = const GetStartedView();

  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider()..setUser(user),
        ),
        ChangeNotifierProvider<TokenProvider>(
          create: (_) => TokenProvider()..setToken(token),
        ),
        ChangeNotifierProvider<EventFeatureCreateProvider>(
            create: (_) => EventFeatureCreateProvider()
        ),
        ChangeNotifierProvider<EventAdvancedOptionCreateProvider>(
          create: (_) => EventAdvancedOptionCreateProvider()
        ),
  ],
      child: MyApp(homeScreen: homeScreen, token: token, user: user),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget homeScreen;
  final String? token;
  final DetailUser? user;

  const MyApp({required this.homeScreen, required this.token, required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    // print('Token: $token, User: $user');
    // print('TokenProvider: ${Provider.of<TokenProvider>(context).token}, UserProvider: ${Provider.of<UserProvider>(context).user}');

    return MaterialApp(
      title: 'Running',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Quicksand",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => homeScreen,
        '/on_board': (context) => const OnBoardingView(),
        '/sign_in': (context) => const SignInView(),
        '/sign_up': (context) => const SignUpView(),
        '/profile_create': (context) => const ProfileCreateView(),
        '/home': (context) => const HomeView(),
        '/activity_record': (context) =>  ActivityRecordView(),
        '/activity_record_list': (context) => const ActivityRecordListView(),
        '/activity_record_detail': (context) => const ActivityRecordDetailView(),
        '/activity_record_edit': (context) => const ActivityRecordEditView(),
        '/activity_record_create': (context) => const ActivityRecordCreateView(),
        '/activity_record_stats': (context) => const ActivityRecordStatsView(),
        '/store': (context) => const StoreView(),
        '/product': (context) => const ProductView(),
        '/rank': (context) => const RankView(),
        '/box': (context) => const NotificationBox(),
        '/address': (context) => const AddressView(),
        '/wallet': (context) => const WalletView(),
        '/email_verification': (context) => const EmailVerification(),
        '/community': (context) => const CommunityView(),
        '/club_list': (context) => const ClubListView(),
        '/club_detail': (context) => const ClubDetailView(),
        '/club_detail_information': (context) => const ClubDetailInformationView(),
        '/club_create': (context) => const ClubCreateView(),
        '/club_member': (context) => const ClubMemberView(),
        '/event_list': (context) => const EventListView(),
        '/event_user_detail': (context) => const EventMemberDetailView(),
        '/event_group_detail': (context) => const EventGroupDetailView(),
        '/group_create': (context) => const GroupCreateView(),
        '/event_feature_create': (context) => const EventFeatureCreateView(),
        '/event_information_create': (context) => const EventInformationCreateView(),
        '/event_advanced_option_create': (context) => const EventAdvancedOptionCreateView(),
        '/your_event_list': (context) => const YourEventListView(),
        '/group_management': (context) => const GroupManagementView(),
        '/member_management_private': (context) => const MemberManagementPrivateView(),
        '/member_management_public': (context) => const MemberManagementPublicView(),
        '/user': (context) => const UserView(),
        '/other_user': (context) => const OtherUserView(),
        '/setting': (context) => const SettingView(),
        '/event_detail': (context) => const EventDetailView(),
        '/privacy_setting': (context) => const PrivacySettingView(),
        '/account_information_setting': (context) => const AccountInformationSettingView(),
        '/notification_setting': (context) => const NotificationSettingView(),
        '/athlete_discovery': (context) => const UserDiscoveryView(),
        '/follow': (context) => const FollowView(),
        '/notification': (context) => const NotificationView(),
        // '/verify': (context) => VerifyCodeForm(),
      },
    );
  }
}
