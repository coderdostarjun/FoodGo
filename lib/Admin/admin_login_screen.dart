import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_go/Admin/admin_home_screen.dart';

import '../service/widget_support.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  
  //login Admin
  loginAdmin()
  {
    FirebaseFirestore.instance.collection("Admin").get().then(
            (snapshot){
            snapshot.docs.forEach((result){
              if(result.data()['username']!=usernameController.text.trim())
                {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.orangeAccent,
                      content: Text(
                        "Your username is not correct",
                        style: TextStyle(fontSize: 18.0),
                      )));
                }
              else if(result.data()['password']!=passwordController.text)
                {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.orangeAccent,
                      content: Text(
                        "Your password is not correct",
                        style: TextStyle(fontSize: 18.0),
                      )));
                }
              else
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminHomeScreen()));
                }
            });
    });
  }
  
  
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
                  height: MediaQuery.of(context).size.height / 2.1, //chang the height of the signup box
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Center(
                            child: Text(
                          "Admin",
                          style: AppWidget.HeadLineTextFieldStyle(),
                        )),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "Username",
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
                              controller: usernameController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter UserName",
                                  prefixIcon: Icon(Icons.person_outline)),
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
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter Password",
                                  prefixIcon: Icon(Icons.password_outlined)),
                            )),
                        SizedBox(
                          height: 30.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            loginAdmin();
                          },
                          child: Center(
                            child: Container(
                              height: 50,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Color(0xffef2b39),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  "Log in",
                                  style: AppWidget.boldwhiteTextFieldStyle(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                      ],
                    ),
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
