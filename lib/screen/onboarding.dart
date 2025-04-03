import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_go/UiHelper.dart';
import 'package:food_go/screen/LoginScreen.dart';
import 'package:food_go/screen/SignUpScreen.dart';
import 'package:food_go/service/widget_support.dart';
class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {

  void initState() {
    Timer(Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Loginscreen()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: 40),
        child: Column(
          children: [
           UiHelper.CustomImage(img: "onboard.png"),
            SizedBox(height: 20.0,),
            Text("The Fastest\n Food Delivery",
              textAlign: TextAlign.center,
              style:AppWidget.HeadLineTextFieldStyle(),),
            
            SizedBox(height: 20.0,),
            Text("Craving something delicious?\n Order now and get your favorites\n deliverd fast!",
              textAlign: TextAlign.center,
              style: AppWidget.SimpleTextFieldStyle(),),

            SizedBox(
              height: 12.0,
            ),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width/2,
              decoration: BoxDecoration(color: Color(0xff8c592a),borderRadius: BorderRadius.circular(20)),
              child:
              Center(
                child:Text("Get Started",style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),),
              )
            )
          ],
        ),
      ),
    );
  }
}
