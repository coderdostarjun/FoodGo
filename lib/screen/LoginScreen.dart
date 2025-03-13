import 'package:flutter/material.dart';
import 'package:food_go/screen/SignUpScreen.dart';

import '../service/widget_support.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 2.5,
                  padding: EdgeInsets.only(top: 30.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xffffefbf),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40))),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/pan.png",
                        height: 180,
                        width: 240,
                        fit: BoxFit.fill,
                      ),
                      Image.asset(
                        "assets/images/logo.png",
                        height: 50,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 3.0,
                  left: 20.0,
                  right: 20.0),
              child: Material(
                borderRadius: BorderRadius.circular(20),
                elevation: 3.0,
                child: Container(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  height: MediaQuery.of(context).size.height /
                      1.6, //chang the height of the signup box
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      Center(
                          child: Text(
                        "LogIn",
                        style: AppWidget.HeadLineTextFieldStyle(),
                      )),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Email",
                        style: AppWidget.signUpTextFiledStyle(),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Color(0xffececf8),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Email",
                                prefixIcon: Icon(Icons.mail_outline)),
                          )),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Password",
                        style: AppWidget.signUpTextFiledStyle(),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Color(0xffececf8),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Password",
                                prefixIcon: Icon(Icons.password_outlined)),
                          )),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Forgot Password?",
                            style: AppWidget.SimpleTextFieldStyle(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Center(
                        child: Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Color(0xffef2b39),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              "Log In",
                              style: AppWidget.boldwhiteTextFieldStyle(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: AppWidget.SimpleTextFieldStyle(),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          GestureDetector(
                            onTap: ()
                            {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Signupscreen()));
                            },
                            child: Text(
                              "SignUp",
                              style: AppWidget.boldTextFiledStyle(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
