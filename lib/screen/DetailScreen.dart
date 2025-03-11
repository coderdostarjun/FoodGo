import 'package:flutter/material.dart';
import 'package:food_go/service/widget_support.dart';

class Detailscreen extends StatefulWidget {
String image, name, price;
Detailscreen({required this.image,required this.name,required this.price});

  @override
  State<Detailscreen> createState() => _DetailscreenState();
}

class _DetailscreenState extends State<Detailscreen> {
  int quantity=1,totalprice=0;
  @override
  void initState() {
    // TODO: implement initState
    totalprice=int.parse(widget.price);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 40.0,left: 20.0),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            GestureDetector(
              onTap: ()
              {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color:Color(0xffef2b39),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(Icons.arrow_back,size: 30.0,color: Colors.white,),
              ),
            ),
            Center(child: Image.asset(widget.image,height: MediaQuery.of(context).size.height/3,fit: BoxFit.contain,)),
            Text(widget.name,style: AppWidget.HeadLineTextFieldStyle(),),
            Text("\$${widget.price}",style: AppWidget.priceTextFiledStyle(),),
            SizedBox(height: 10.0,),

              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  textAlign: TextAlign.justify,
                  "We've established that most cheeses will melt when baked atop pizza. But which will not only melt but stretch into those gooey, messy strands that can make pizza eating such a delightfully challenging endeavor?",style: AppWidget.SimpleTextFieldStyle(),),
              ),
            SizedBox(height: 20.0,),
            Text("Quantity",style: AppWidget.boldTextFiledStyle()),
            SizedBox(height: 10.0,),
      // The Material widget is used to wrap a Container widget,
      // giving it a blue background color, elevation for shadow,
      // and rounded corners.
            Row(
              children: [
                GestureDetector(
                  onTap: ()
                  {
                    quantity=quantity+1;
                    totalprice=totalprice+int.parse(widget.price);
                    setState(() {

                    });
                  },
                  child: Material(
                    elevation: 3.0,
                    borderRadius:BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(color:Color(0xffef2b39),borderRadius: BorderRadius.circular(10)
                      ),
                      child:
                      Icon(Icons.add,color: Colors.white,size: 30.0,),
                    ),
                  ),
                ),
                SizedBox(width: 20.0,),
                Text(quantity.toString(),style: AppWidget.HeadLineTextFieldStyle(),),
                SizedBox(width: 20.0,),
                GestureDetector(
                  onTap: (){
                    if(quantity>1)
                      {
                        quantity=quantity-1;
                        totalprice=totalprice-int.parse(widget.price);
                      }
                    setState(() {

                    });
                  },
                  child: Material(
                    elevation: 3.0,
                    borderRadius:BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(color:Color(0xffef2b39),borderRadius: BorderRadius.circular(10)
                      ),
                      child:
                      Icon(Icons.remove,color: Colors.white,size: 30.0,),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  elevation: 3.0,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 60,
                    width: 120,
                    decoration: BoxDecoration(color: Color(0xffef2b39),borderRadius: BorderRadius.circular(20)),
                    child: Center(child: Text("\$$totalprice",style: AppWidget.boldwhiteTextFieldStyle(),)),
                  ),
                ),
                SizedBox(width: 25,),
                Material(
                  elevation: 3.0,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 70,
                    width: 200,
                    decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(20)),
                    child: Center(child: Text("ORDER NOW",style: AppWidget.whiteTextFieldStyle(),)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
