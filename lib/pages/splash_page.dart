import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_plans/pages/signin_page.dart';
import 'package:my_plans/services/pref_service.dart';
import 'home_page.dart';

class SplashPage extends StatefulWidget {

  static final String id = 'splash_page';

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  Widget _startPage() {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if(snapshot.hasData) {
          Prefs.saveUserId(snapshot.data.uid);
          return HomePage();
        } else {
          Prefs.removeUserId();
          return SignInPage();
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
            () => Navigator.pushReplacement(context, new MaterialPageRoute(builder: (BuildContext context) { return _startPage();})));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(2),
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Container(
                    width: 140,
                    height: 140,
                    child: Image.asset('assets/images/ic_book2.jpg', fit: BoxFit.cover,),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  //padding: EdgeInsets.all(2),
                  color: Colors.white,
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 140,
                    width: 140,
                    alignment: Alignment.center,
                    color: Colors.black,
                    child: Text(
                      'My Plans',
                      style: TextStyle(fontSize: 27.5, fontWeight: FontWeight.bold, color: Colors.white,),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.all(100),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}