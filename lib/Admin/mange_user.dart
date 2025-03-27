import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_go/service/database.dart';

import '../service/widget_support.dart';

class MangeUser extends StatefulWidget {
  const MangeUser({super.key});

  @override
  State<MangeUser> createState() => _MangeUserState();
}
class _MangeUserState extends State<MangeUser> {
  Stream? userStream;
  String? id;
  //load user detailfunction
  getontheLoad() async
  {
    userStream=await DatabaseMethods().getAllUsers();
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    getontheLoad();
  }
  Widget allUsers()
  {
    return StreamBuilder(stream:userStream, builder: (context,AsyncSnapshot snapshot)
    {
      return snapshot.hasData? ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context,index)
          {
            DocumentSnapshot ds=snapshot.data.docs[index];
            return Container(
              margin: EdgeInsets.only(left: 20.0,right: 20.0,bottom: 20.0),
              child: Material(
                elevation: 3.0,
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child:Column(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius:BorderRadius.circular(60),
                            child: Image.asset("assets/images/boy.jpg",height: 90,width: 90,fit: BoxFit.cover,),),
                          SizedBox(width: 20.0,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.person,color: Color(0xffef2b39),),
                                  SizedBox(width: 10.0,),
                                  Text(ds["Name"],style: AppWidget.boldTextFiledStyle(),),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.mail,color: Color(0xffef2b39),),
                                  SizedBox(width: 10.0,),
                                  Text(ds["Email"],style: AppWidget.SimpleTextFieldStyle(),),
                                ],
                              ),
                              SizedBox(height: 10.0,),
                              Container(
                                height: 30,
                                decoration: BoxDecoration(color: Colors.black,
                                    borderRadius: BorderRadius.circular(10)),
                                width: 100,
                                child: Center(child: Text("Remove",style: AppWidget.whiteTextFieldStyle(),)),
                              )
                            ],
                          )
                        ],
                      )
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
                      height: MediaQuery.of(context).size.height/2,
                      child: allUsers())
                ],
              ),
            ),
          ),
        ],
      ),
    ),);
  }
}
