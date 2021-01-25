import 'package:flutter/material.dart';
import 'package:my_plans/pages/calendar_page.dart';
import 'package:my_plans/pages/plans_page.dart';
import 'package:my_plans/pages/signin_page.dart';
import 'package:my_plans/services/auth_service.dart';

class HomePage extends StatefulWidget {

  static final String id = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var _pages = [
    PlansPage(),
    CalendarPage(),
  ];
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        centerTitle: true,
        title: Text('My Plans', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, letterSpacing: 1),),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              AuthService.signOutUser(context);
              Navigator.pushReplacementNamed(context, SignInPage.id);
            },
          )
        ],
      ),
      body: _pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 50,
        currentIndex: currentPage,
        onTap: (i) {
          setState(() {
            currentPage = i;
          });
        },
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.text_snippet_sharp, size: 30,),
            label: 'plan'
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today, size: 30,),
            label: 'calendar'
          ),
        ],
      ),
    );
  }
}
