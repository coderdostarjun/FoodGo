import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_go/screen/LoginScreen.dart';
import 'package:food_go/screen/onboarding.dart';
import 'package:food_go/service/auth.dart';
import 'package:food_go/service/shared_pref.dart';
import 'package:food_go/service/widget_support.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  //get userdetail from local storage
  String? name, email;

  getthesharedpref() async {
    name = await SharedPrefenceHelper().getUserName();
    email = await SharedPrefenceHelper().getUserEmail();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getthesharedpref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30.0),
            child: Center(
                child: Text(
              "Profile",
              style: AppWidget.HeadLineTextFieldStyle(),
            )),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 5.0),
              padding: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Color(0xffececf8),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage("assets/images/boy.jpg"),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: Material(
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person_outline,
                                color: Color(0xffef2b39),
                                size: 40,
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name",
                                    style: AppWidget.SimpleTextFieldStyle(),
                                  ),
                                  Text(
                                    name ?? "Loading...",
                                    style: AppWidget.boldTextFiledStyle(),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: Material(
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.mail_outline,
                                color: Color(0xffef2b39),
                                size: 40,
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Email",
                                    style: AppWidget.SimpleTextFieldStyle(),
                                  ),
                                  Text(
                                    email ?? "Loading...",
                                    style: AppWidget.boldTextFiledStyle(),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await AuthMethods().SignOut();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Loginscreen()));
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Material(
                          elevation: 3.0,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                                top: 20.0,
                                bottom: 20.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.logout_outlined,
                                  color: Color(0xffef2b39),
                                  size: 40,
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "LogOut",
                                      style: AppWidget.boldTextFiledStyle(),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Icon(
                                  Icons.chevron_right,
                                  color: Color(0xffef2b39),
                                  size: 40,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            TextEditingController passwordController =
                                TextEditingController();

                            return AlertDialog(
                              title: Text(
                                "Confirm Delete",
                                style: AppWidget.HeadLineTextFieldStyle(),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Please enter your password to delete your account.",
                                    style: AppWidget.SimpleTextFieldStyle(),
                                  ),
                                  SizedBox(height: 10),
                                  SizedBox(
                                    child: TextField(
                                      controller: passwordController,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        labelText: "Password",
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  child: Text(
                                    "Cancel",
                                    style: AppWidget.SimpleTextFieldStyle(),
                                  ),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                                TextButton(
                                  child: Text("Delete",
                                      style: AppWidget.boldTextFiledStyle()
                                          .apply(color: Colors.red)),
                                  onPressed: () async {
                                    String password =
                                        passwordController.text.trim();
                                    String? email = FirebaseAuth
                                        .instance.currentUser?.email;

                                    if (email != null && password.isNotEmpty) {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog first
                                      // Reauthenticate and delete the user, then navigate
                                     await AuthMethods().deleteUser(email, password, context);

                                    } else {
                                      // Show error if password is empty
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Please enter your password")),
                                      );
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },

                      // await AuthMethods().deleteUser();
                      // Navigator.push(context,MaterialPageRoute(builder: (context)=>Onboarding()));

                      child: Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Material(
                          elevation: 3.0,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                                top: 20.0,
                                bottom: 20.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: Color(0xffef2b39),
                                  size: 40,
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Delete Account",
                                      style: AppWidget.boldTextFiledStyle(),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Icon(
                                  Icons.chevron_right,
                                  color: Color(0xffef2b39),
                                  size: 40,
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
            ),
          ),
        ],
      ),
    );
  }
}
