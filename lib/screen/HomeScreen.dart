import 'package:flutter/material.dart';
import 'package:food_go/model/category_model.dart';
import 'package:food_go/service/category_data.dart';
import 'package:food_go/service/widget_support.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<CategoryModel> categoires=[];
  String track="0";

  @override
  void initState() {
    // TODO: implement initState
    categoires=getCategories();
    // print(categoires[2].name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: 
      Container(
        margin: EdgeInsets.only(left: 20.0,top: 30.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset("assets/images/logo.png",height: 50,width: 130,fit: BoxFit.contain,),
                    Text("Order your favourite food!",style: AppWidget.SimpleTextFieldStyle(),),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                      child: Image.asset("assets/images/boy.jpg",height: 60,width: 60,fit: BoxFit.cover,)),
                )
              ],
            ),
            SizedBox(height: 30.0,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 10.0),
                    margin: EdgeInsets.only(right: 20.0),
                    decoration: BoxDecoration(
                      color: Color(0xffececf8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      decoration: InputDecoration(border: InputBorder.none,hintText: "Search food item..."),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 12.0),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xffef2b39),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.search,color: Colors.white,size: 30.0,),
                )
              ],
            ),
             SizedBox(height: 20.0,),
             Container(
               height: 60,
               child: ListView.builder(
                 shrinkWrap: true,
                   itemCount: categoires.length,
                   scrollDirection: Axis.horizontal,
                   itemBuilder: (context,index){
                 return CategoryTile(name: categoires[index].name!, image: categoires[index].image!,categoryIndex: index.toString(),);
               }),
             )
          ],
        ),
      ),);
  }
  Widget CategoryTile({required String name,required String image, required String categoryIndex})
  {
    return GestureDetector(
      onTap: (){
        track=categoryIndex.toString();
        setState(() {

        });
      },
      child:track==categoryIndex? Container(
        padding: EdgeInsets.only(left: 20.0,right: 20.0),
        margin: EdgeInsets.only(right: 20.0),
        decoration: BoxDecoration(color: Color(0xffef2b39),borderRadius: BorderRadius.circular(20)),
        child:Row(
          children: [
            Image.asset(image,height: 40,width: 40,fit: BoxFit.cover,),
            Text(name,style:AppWidget.whiteTextFieldStyle(),),
          ],
        ) ,
      ):Container(
        padding: EdgeInsets.only(left: 20.0,right: 20.0),
        margin: EdgeInsets.only(right: 20.0),
        decoration: BoxDecoration(color: Color(0xffececf8),borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Image.asset(image,height: 40,width: 40,fit: BoxFit.cover,),
            Text(name,style:AppWidget.SimpleTextFieldStyle(),),
          ],
        ),
      ),
    );
  }
}

