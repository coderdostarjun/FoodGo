import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_go/service/database.dart';
import 'package:food_go/service/shared_pref.dart';
import 'package:food_go/service/widget_support.dart';
import 'package:random_string/random_string.dart';

import '../service/key_constants.dart';
import 'package:http/http.dart' as http;

class Detailscreen extends StatefulWidget {
String image, name, price;
Detailscreen({required this.image,required this.name,required this.price});

  @override
  State<Detailscreen> createState() => _DetailscreenState();
}

class _DetailscreenState extends State<Detailscreen> {
  //default quantity and price
  int quantity=1,totalprice=0;
  @override
  void initState() {
    // TODO: implement initState
    totalprice=int.parse(widget.price);
    getthesharedPref();
    super.initState();
  }
  //payment integration methods
  Map<String, dynamic>? paymentIntent;
  
  //get user name,id  which is stored locally during signup
  String? name,id,email;
  //method for getidAndName
  getthesharedPref()async
  {
    name=await SharedPrefenceHelper().getUserName();
    //testing
    email=await SharedPrefenceHelper().getUserEmail();
    print("email is +$email");
    id=await SharedPrefenceHelper().getUserId();

    setState(() {
    });
  }

  //this methods are for payment integration and display payment success or failure message
  Future<void> makePayment(String amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, "USD");
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              customFlow: true,
              merchantDisplayName: 'Food Go',
              paymentIntentClientSecret: paymentIntent!['client_secret'],
              style: ThemeMode.dark,
              googlePay: const PaymentSheetGooglePay(
                merchantCountryCode: 'US',
                currencyCode: 'USD',
                testEnv: true,
              )));
      await displayPaymentSheet();
    } catch (e) {
      log(e.toString());
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'currency': currency,
        // Convert amount to cents (or the smallest unit)
        'amount': ((int.parse(amount)*100)).toString(), // Convert dollars to cents
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer $secret_key',
            'Content-Type': 'application/x-www-form-urlencoded'
          });

      return jsonDecode(response.body);
    } catch (e) {
      log(e.toString());
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then(
            (value) async {

              //on successful payment store the user details and it's quantity ,totalamount price on cloudfirestore directly using map
              String orderId=randomAlphaNumeric(10);
              Map<String,dynamic> userOrderMap={
                "Name":name,
                "Email":email,
                "Id":id,
                "FoodName":widget.name,
                "FoodImage":widget.image,
                "Quantity":quantity.toString(),
                "TotalAmount":totalprice.toString(),
                "OrderId":orderId,
                "Status":"Pending",
                "Address":"Belbas",
              };
              //kuna user le kuna order leyo store garna ko lagi
              await DatabaseMethods().addUserOrderDetails(userOrderMap, id!, orderId);
              //admin le order kuna kuna gayo herna ko lagi without integrate on user
              //for ordermanagement: admin ko lagi
              await DatabaseMethods().addAdminOrderDetails(userOrderMap, orderId);

          // On successful payment, show success message using Snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Payment Successful\nAmount: \$$totalprice"),
              backgroundColor: Colors.green,
            ),
          );
        },
      );
      paymentIntent = null;
    } on StripeException catch (e) {
      log(e.toString());
      // Handle error (failed payment)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Payment Failed\nPlease try again."),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      log(e.toString());
      // Handle any other exception
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Payment Failed\nPlease try again."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }


  // displayPaymentSheet() async {
  //   try {
  //     await Stripe.instance.presentPaymentSheet().then(
  //           (value) async {
  //             showDialog(context: context, builder: (_)=>AlertDialog(
  //               content: Column(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 children: [
  //                   Row(
  //                     children: [
  //                       Icon(Icons.check_circle,color: Colors.green,),
  //                       Text("Payment Successfull")
  //                     ],
  //                   )
  //                 ],
  //               ),
  //             ));
  //         // await Stripe.instance.confirmPaymentSheetPayment();
  //       },
  //     );
  //     paymentIntent = null;
  //   } on StripeException catch (e) {
  //     log(e.toString());
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 40.0,left: 20.0),
        child:
        SingleChildScrollView(
          child: Column(
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
                      child: GestureDetector(
                          onTap:(){
                            makePayment(totalprice.toString());
                          },
                          child: Center(child: Text("ORDER NOW",style: AppWidget.whiteTextFieldStyle(),))),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
