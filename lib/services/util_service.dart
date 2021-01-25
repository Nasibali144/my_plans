import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_plans/models/plan_model.dart';

class Utils {
  static fireToast(String msg) {
    Fluttertoast.showToast(
      msg:  msg,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      backgroundColor: Colors.grey,
      fontSize: 16,
      gravity: ToastGravity.BOTTOM,
    );
  }

  static void showDialogWithImage( BuildContext context,Plan plan) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),//this right here
            child: Container(
              height: 350,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(plan.title, style: TextStyle(color: Colors.black, fontSize: 18),),
                    Text(plan.content, style: TextStyle(fontSize: 16),),
                    Text("Was the result achieved?  ${plan.completed ? "Yes" : "No"}", style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 10,),
                    Container(
                      height: 200,
                      child: plan.imgUrl != null ?
                      Image.network(plan.imgUrl,fit: BoxFit.cover,):
                      Image.asset("assets/images/placeholder.jpg"),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      height: 40,
                      width: 200,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          )
                        ],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        color: Colors.black,
                      ),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        textColor: Colors.white,
                        child: Text('Close'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}