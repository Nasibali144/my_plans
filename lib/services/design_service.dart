import 'package:flutter/material.dart';

class DesignsContainer{

  static Widget textField(TextEditingController controller, String text) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3),
          )
        ],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15)),
        color: Colors.white,
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none, hintText: text),
      ),
    );
  }

  static Widget textFieldPassword(TextEditingController controller, String text) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3),
          )
        ],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15)),
        color: Colors.white,
      ),
      child: TextField(
        obscureText: true,
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none, hintText: text),
      ),
    );
  }

  static Widget flatButton(Function function, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.5),
        //     spreadRadius: 3,
        //     blurRadius: 7,
        //     offset: Offset(0, 3),
        //   )
        // ],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15)),
        color: Colors.black,
      ),
      child: FlatButton(
        onPressed: function,
        textColor: Colors.white,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}