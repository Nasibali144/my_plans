import 'package:flutter/material.dart';
import 'package:my_plans/pages/signup_page.dart';
import 'package:my_plans/services/auth_service.dart';
import 'package:my_plans/services/design_service.dart';

class SignInPage extends StatefulWidget {
  static final String id = 'signin_page';

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var isLoading = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  _doSignIn() {
    var email = emailController.text.toString().trim();
    var password = passwordController.text.toString().trim();
    if(email.isEmpty || password.isEmpty) return;
    AuthService.signInUser(context, email, password);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Column(
            children: [
              // #header
              Container(
                height: 250,
                alignment: Alignment.center,
                child: Container(
                  width: 200,
                  height: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      color: Colors.white,
                      border: Border.all(color: Colors.white, width: 2),
                      //  boxShadow: [
                      //   BoxShadow(
                      //       color: Colors.white.withOpacity(0.5),
                      //       spreadRadius: 5,
                      //       blurRadius: 7,
                      //       offset: Offset(0, 3))
                      // ]
                  ),
                  child: Center(
                    child: Text(
                      "My Plans",
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.black,
                        // shadows: [
                        //   BoxShadow(
                        //       color: Colors.black.withOpacity(0.5),
                        //       spreadRadius: 5,
                        //       blurRadius: 7,
                        //       offset: Offset(0, 3))
                        // ],
                      ),
                    ),
                  ),
                ),
              ),

              // #body
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(30),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
                      color: Colors.white,
                      // boxShadow: [
                      //   BoxShadow(
                      //       color: Colors.white.withOpacity(0.75),
                      //       spreadRadius: 5,
                      //       blurRadius: 7,
                      //       offset: Offset(4, 0))
                      // ]
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // #text
                        Text(
                          'Login',
                          style: TextStyle(
                              letterSpacing: 1.2,
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),

                        // #email
                        DesignsContainer.textField(emailController, "Email"),
                        SizedBox(height: 40),

                        // #password
                        DesignsContainer.textFieldPassword(passwordController, "Password"),
                        SizedBox(height: 40),

                        // #Login
                        DesignsContainer.flatButton(() {
                          if (this.mounted) { // check whether the state object is in tree
                            setState(() {
                              isLoading = true;
                            });
                          }

                          _doSignIn();

                          if (this.mounted) { // check whether the state object is in tree
                            setState(() {
                              isLoading = false;
                            });
                          }

                        }, "Login"),
                        SizedBox(height: 40),

                        // #signup
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, SignUpPage.id);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),

          isLoading ? Center(
            child: CircularProgressIndicator(),
          ) : SizedBox.shrink()
        ],
      )
    );
  }
}