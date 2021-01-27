import 'package:flutter/material.dart';
import 'package:my_plans/pages/calendar_page.dart';
import 'package:my_plans/pages/detail_page.dart';
import 'package:my_plans/pages/home_page.dart';
import 'package:my_plans/pages/plans_page.dart';
import 'package:my_plans/pages/signin_page.dart';
import 'package:my_plans/pages/signup_page.dart';
import 'package:my_plans/pages/splash_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  static final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashPage(),
      routes: {
        HomePage.id: (context) => HomePage(),
        SignInPage.id: (context) => SignInPage(),
        SignUpPage.id: (context) => SignUpPage(),
        SplashPage.id: (context) => SplashPage(),
        DetailPage.id: (context) => DetailPage(),
        PlansPage.id: (context) => PlansPage(),
        CalendarPage.id: (context) => CalendarPage(),
      },
    );
  }
}