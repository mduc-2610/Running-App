import 'package:flutter/material.dart';
import 'package:running_app/view/activity/activity_view.dart';
import 'package:running_app/view/home/home_view.dart';
import 'package:running_app/view/login/get_started_view.dart';
import 'package:running_app/view/login/on_boarding_view.dart';
import 'package:running_app/view/login/sign_in_view.dart';
import 'package:running_app/view/login/sign_up_view.dart';


void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Running',
      theme: ThemeData(
        fontFamily: "Quicksand",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const GetStartedView(),
        '/on_board': (context) => const OnBoardingView(),
        '/sign_in': (context) => const SignInView(),
        '/sign_up': (context) => const SignUpView(),
        '/home': (context) => const HomeView(),
        '/activity': (context) => const ActivityView(),
        '/running': (context) => const RunningView(),
      },
    );
  }
}
