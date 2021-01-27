import 'package:flutter/material.dart';
import 'package:my_plans/pages/signin_page.dart';
import 'package:my_plans/services/auth_service.dart';
import 'package:my_plans/services/design_service.dart';

class SignUpPage extends StatefulWidget {

  static final String id = "signup_page";

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  var isLoading = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();


  _doSignUp() {
    var firstName = firstNameController.text.toString();
    var lastName = lastNameController.text.toString();
    var email = emailController.text.toString();
    var password = passwordController.text.toString();

    var name = firstName + ' ' + lastName;

    if(name.isEmpty || email.isEmpty || password.isEmpty) return;
    setState(() {
      isLoading = true;
    });

    AuthService.signUpUser(context, name, email, password);
    setState(() {
      isLoading = false;
    });
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
                height: 140,
                alignment: Alignment.center,
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                      letterSpacing: 1.2,
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      shadows: [
                        BoxShadow(
                            color: Colors.white.withOpacity(0.5),
                            spreadRadius: 10,
                            blurRadius: 5,
                            offset: Offset(3, 0))
                      ]),
                ),
              ),

              // #body
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 40, horizontal: 35),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
                      color: Colors.white.withOpacity(0.9),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.white.withOpacity(0.75),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(4, 0))
                      ]),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [

                        // #firstname
                        DesignsContainer.textField(firstNameController, 'Firstname'),
                        SizedBox(height: 40),

                        // #lastname
                        DesignsContainer.textField(lastNameController, 'Lastname'),
                        SizedBox(height: 40),

                        // #email
                        DesignsContainer.textField(emailController, 'Email'),
                        SizedBox(height: 40),

                        // #password
                        DesignsContainer.textField(passwordController, 'Password'),
                        SizedBox(height: 40),

                        // #SignUp
                        DesignsContainer.flatButton(_doSignUp, "SignUp"),
                        SizedBox(height: 70),

                        // #signIn
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, SignInPage.id);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already you have an account? ",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                " Sign In",
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