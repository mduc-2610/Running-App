import 'package:flutter/material.dart';
import 'package:running_app/utils/common_widgets/email_verification.dart';
import 'package:running_app/utils/common_widgets/notification_box.dart';
import 'package:running_app/utils/common_widgets/verify_code_form.dart';
import 'package:running_app/view/activity/activity_view.dart';
import 'package:running_app/view/activity/running_view.dart';
import 'package:running_app/view/address/address.dart';
import 'package:running_app/view/home/home_view.dart';
import 'package:running_app/view/login/get_started_view.dart';
import 'package:running_app/view/login/on_boarding_view.dart';
import 'package:running_app/view/login/sign_in_view.dart';
import 'package:running_app/view/login/sign_up_view.dart';
import 'package:running_app/view/rank/rank_view.dart';
import 'package:running_app/view/store/product_view.dart';
import 'package:running_app/view/store/store_view.dart';
import 'package:running_app/view/wallet/wallet.dart';


void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Running',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Quicksand",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false
      ),
      initialRoute: '/rank',
      routes: {
        '/': (context) => GetStartedView(),
        '/on_board': (context) => const OnBoardingView(),
        '/sign_in': (context) => const SignInView(),
        '/sign_up': (context) => const SignUpView(),
        '/home': (context) => const HomeView(),
        '/activity': (context) => const ActivityView(),
        '/store': (context) => const StoreView(),
        '/product': (context) => const ProductView(),
        '/rank': (context) => const RankView(),
        '/box': (context) => const NotificationBox(),
        '/address': (context) => const AddressView(),
        '/wallet': (context) => const WalletView(),
        '/email_verification': (context) => const EmailVerification(),
        // '/verify': (context) => VerifyCodeForm(),
        // '/running': (context) => const RunningView(),
      },
    );
  }
}
