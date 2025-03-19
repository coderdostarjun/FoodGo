import 'package:flutter/material.dart';
import 'package:food_go/service/widget_support.dart';

class Orderscreen extends StatefulWidget {
  const Orderscreen({super.key});

  @override
  State<Orderscreen> createState() => _OrderscreenState();
}

class _OrderscreenState extends State<Orderscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Orders",style: AppWidget.HeadLineTextFieldStyle(),)
              ],
            ),
            SizedBox(height: 10.0,),

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
                      decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight:Radius.circular(20)),
                     ),
                      child: Material(
                        elevation: 3.0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color:Colors.white,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight:Radius.circular(20)),
                        ),
                          child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.location_on_outlined,color: Color(0xffef2b39),),
                            SizedBox(width: 10.0,),
                            Text("Near Devinagar",style: AppWidget.SimpleTextFieldStyle(),)
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Image.asset("assets/images/burger1.png",height: 100,width: 100,fit: BoxFit.cover,),
                            SizedBox(width: 20.0,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Cheese Burger",style: AppWidget.boldTextFiledStyle(),),
                                SizedBox(height: 5.0,),
                                Row(
                                  children: [
                                    Icon(Icons.format_list_numbered,color: Color(0xffef2b39),),
                                    SizedBox(width: 10.0,),
                                    Text("4",style: AppWidget.boldTextFiledStyle(),),
                                    SizedBox(width: 30.0,),
                                    Icon(Icons.monetization_on,color: Color(0xffef2b39),),
                                    SizedBox(width: 10.0,),
                                    Text("\$40",style: AppWidget.boldTextFiledStyle(),),
                                  ],
                                ),
                                SizedBox(height: 5.0,),
                                Text("Pending!",style: TextStyle(color: Color(0xffef2f39),fontSize: 20,fontWeight: FontWeight.bold),)
                              ],
                            )
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
            ),
          ],
        ),
      ),
    );
  }
}
