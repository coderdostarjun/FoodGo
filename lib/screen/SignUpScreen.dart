import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_go/screen/BottomNavBarScreen.dart';
import 'package:food_go/screen/LoginScreen.dart';
import 'package:food_go/service/database.dart';
import 'package:food_go/service/shared_pref.dart';
import 'package:food_go/service/widget_support.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  String email = "", password = "", name = "";
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  registration() async {
    if (password != null &&
        nameController.text != "" &&
        emailController.text != "") {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String Id = randomAlphaNumeric(10);
        Map<String, dynamic> userInfoMap = {
          "Name": nameController.text,
          "Email": emailController.text,
          "Id": Id,
        };
        //for store data locally
        await SharedPrefenceHelper().saveUserName(nameController.text);
        await SharedPrefenceHelper().saveUserEmail(emailController.text);
        print("aba username print hoga:");
        print(SharedPrefenceHelper().getUserName().toString());
        //for store data on cloudfirestore
        await DatabaseMethods().addUserDetails(userInfoMap, Id);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Registerd Successfully",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            )));
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>Bottomnavbarscreen()));


      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "The password provided is too weak.",
                style: TextStyle(fontSize: 18.0),
              )));
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "The account already exists for that email.",
                style: TextStyle(fontSize: 18.0),
              )));
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
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
                  height: MediaQuery.of(context).size.height /
                      1.6, //chang the height of the signup box
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Center(
                            child: Text(
                          "SignUp",
                          style: AppWidget.HeadLineTextFieldStyle(),
                        )),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "Name",
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
                              controller: nameController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter Name",
                                  prefixIcon: Icon(Icons.person_outline)),
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
                              controller: emailController,
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
                            if (nameController.text != "" &&
                                passwordController.text != "" &&
                                emailController.text != "") {
                              setState(() {
                                name = nameController.text;
                                email = emailController.text;
                                password = passwordController.text;
                              });
                              registration();
                            }
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
                                  "Sign Up",
                                  style: AppWidget.boldwhiteTextFieldStyle(),
                                ),
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
                              "Already have an account?",
                              style: AppWidget.SimpleTextFieldStyle(),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Loginscreen()));
                                },
                                child: Text(
                                  "LogIn",
                                  style: AppWidget.boldTextFiledStyle(),
                                )),
                          ],
                        )
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
