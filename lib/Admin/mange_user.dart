import 'package:flutter/material.dart';

import '../service/widget_support.dart';

class MangeUser extends StatefulWidget {
  const MangeUser({super.key});

  @override
  State<MangeUser> createState() => _MangeUserState();
}

class _MangeUserState extends State<MangeUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      margin: EdgeInsets.only(top: 40.0,),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(0xffef2b39),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(Icons.arrow_back_rounded,color: Colors.white,),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width/6,),
                Text("Current Users", style: AppWidget.HeadLineTextFieldStyle(),),
              ],
            ),
          ),
          SizedBox(height: 20.0,),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color:Color(0xffececf8),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight:Radius.circular(30))),
              child: Column(
                children: [
                  SizedBox(height: 20.0,),
                  Container(
                    margin: EdgeInsets.only(left: 20.0,right: 20.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child:Column(
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                  child: Image.asset("assets/images/boy.jpg",height: 90,width: 90,fit: BoxFit.cover,),)
                            ],
                          )
                        ],
                      ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),);
  }
}
