import 'package:flutter/material.dart';
import 'package:food_go/Admin/all_order.dart';
import 'package:food_go/Admin/manage_food.dart';

import '../service/widget_support.dart';
import 'mange_user.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      margin: EdgeInsets.only(top: 40.0,),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text("Home Admin", style: AppWidget.HeadLineTextFieldStyle(),)),
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
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AllOrder()));
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 20.0,right: 20.0),
                      child: Material(
                        elevation: 3.0,
                          borderRadius: BorderRadius.circular(30),
                        child: Container(
                          padding: EdgeInsets.only(left: 20.0,right: 20.0,top: 10.0,bottom: 10.0),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(30)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset("assets/images/delivery-man.png",height: 120,width: 120,fit: BoxFit.cover,),
                                Text("Manage\nOrders",style:TextStyle(color: Colors.black,fontSize: 25.0,fontWeight: FontWeight.bold),),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(color: Color(0xffef2b39),
                                  borderRadius: BorderRadius.circular(30)),
                                  child: Icon(Icons.arrow_forward,color: Colors.white,size: 30.0,),
                                )
                              ],
                            ),

                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 50.0,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MangeUser()));
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 20.0,right: 20.0),
                      child: Material(
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          padding: EdgeInsets.only(left: 20.0,right: 20.0,top: 10.0,bottom: 10.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset("assets/images/team.png",height: 120,width: 120,fit: BoxFit.cover,),
                              Text("Manage\nUsers",style:TextStyle(color: Colors.black,fontSize: 25.0,fontWeight: FontWeight.bold),),
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(color: Color(0xffef2b39),
                                    borderRadius: BorderRadius.circular(30)),
                                child: Icon(Icons.arrow_forward,color: Colors.white,size: 30.0,),
                              )
                            ],
                          ),

                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 50.0,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ManageFood()));
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 20.0,right: 20.0),
                      child: Material(
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          padding: EdgeInsets.only(left: 20.0,right: 20.0,top: 10.0,bottom: 10.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset("assets/images/Food Manager.jpg",height: 120,width: 120,fit: BoxFit.cover,),
                              Text("Manage\nFoods",style:TextStyle(color: Colors.black,fontSize: 25.0,fontWeight: FontWeight.bold),),
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(color: Color(0xffef2b39),
                                    borderRadius: BorderRadius.circular(30)),
                                child: Icon(Icons.arrow_forward,color: Colors.white,size: 30.0,),
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
          ),
        ],
      ),
    ),);
  }
}
