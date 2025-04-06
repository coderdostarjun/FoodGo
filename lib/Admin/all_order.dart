import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_go/service/database.dart';
import 'package:food_go/service/widget_support.dart';

class AllOrder extends StatefulWidget {
  const AllOrder({super.key});

  @override
  State<AllOrder> createState() => _AllOrderState();
}

class _AllOrderState extends State<AllOrder> {
  getontheLoad()async
  {
    orderStream=await DatabaseMethods().getAdminOrders();
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getontheLoad();
  }
  //fetching and display all orders
  Stream? orderStream;
  String? id;
  //for displayal orders
  Widget allOrders()
  {
    return StreamBuilder(stream: orderStream, builder: (context,AsyncSnapshot snapshot)
    {
      return snapshot.hasData? ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context,index)
          {
            DocumentSnapshot ds=snapshot.data.docs[index];
            return  Container(
              margin: EdgeInsets.only(left: 20.0,right: 20.0,bottom: 20.0),
              child: Material(
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),)),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight:Radius.circular(10)),
                  ),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on_outlined,color: Color(0xffef2b39),),
                        SizedBox(width: 10.0,),
                        Text(ds["Address"],style: AppWidget.SimpleTextFieldStyle(),)
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        // Image.asset(ds["FoodImage"],height: 100,width: 100,fit: BoxFit.cover,),
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                          child: Image.network(
                            ds["FoodImage"],
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),

                        SizedBox(width: 20.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ds["FoodName"],style: AppWidget.boldTextFiledStyle(),),
                            SizedBox(height: 5.0,),
                            Row(
                              children: [
                                Icon(Icons.format_list_numbered,color: Color(0xffef2b39),),
                                SizedBox(width: 10.0,),
                                Text(ds["Quantity"],style: AppWidget.boldTextFiledStyle(),),
                                SizedBox(width: 30.0,),
                                Icon(Icons.monetization_on,color: Color(0xffef2b39),),
                                SizedBox(width: 10.0,),
                                Text("\$"+ds["TotalAmount"],style: AppWidget.boldTextFiledStyle(),),
                              ],
                            ),
                            SizedBox(height: 5.0,),
                            Row(
                              children: [
                                Icon(Icons.person,color:Color(0xffef2b39) ,),
                                SizedBox(width: 10.0,),
                                Text(ds["Name"],style: AppWidget.SimpleTextFieldStyle(),)
                              ],
                            ),
                            SizedBox(height: 5.0,),
                            Row(
                              children: [
                                Icon(Icons.mail,color:Color(0xffef2b39) ,),
                                SizedBox(width: 10.0,),
                                Text(ds["Email"],style: AppWidget.SimpleTextFieldStyle(),)
                              ],
                            ),
                            SizedBox(height: 5.0,),
                            Text(ds["Status"]+"!",style: TextStyle(color: Color(0xffef2f39),fontSize: 20,fontWeight: FontWeight.bold),),
                            SizedBox(height: 5.0,),
                            GestureDetector(
                              onTap: () async
                              {
                                await DatabaseMethods().updateAdminOrder(ds.id);
                                await DatabaseMethods().updateUserOrder(ds["Id"], ds.id);
                              },
                              child: Container(
                                width: 100,
                                height: 50,
                                decoration: BoxDecoration(color:Colors.black,borderRadius: BorderRadius.circular(10)
                                ),
                                child: Center(child: Text("Delivered",style: AppWidget.whiteTextFieldStyle(),)),
                              ),
                            ),
                            SizedBox(height: 5.0,),
                          ],
                        )
                      ],

                    ),
                  ],
                  ),
                ),
              ),
            );
          }):Container();
    });

  }



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
                Text("All Orders", style: AppWidget.HeadLineTextFieldStyle(),),
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
                    height: MediaQuery.of(context).size.height/1.2,
                    child: allOrders()),
                ],
              ),
            ),
          ),
        ],
      ),
    ),);
  }
}
