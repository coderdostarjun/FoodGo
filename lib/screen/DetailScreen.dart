import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_go/service/database.dart';
import 'package:food_go/service/shared_pref.dart';
import 'package:food_go/service/widget_support.dart';
import 'package:random_string/random_string.dart';

import '../service/key_constants.dart';
import 'package:http/http.dart' as http;

class Detailscreen extends StatefulWidget {
String image, name, price,description;
Detailscreen({required this.image,required this.name,required this.price,required this.description});

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
    getthesharedPref().then((_) {
      getUserWallet();
    });
    super.initState();
  }
  //payment integration methods
  Map<String, dynamic>? paymentIntent;
  
  //get user name,id  which is stored locally during signup
  String? name,id,email,address,wallet;
  //method for getidAndName
  getthesharedPref()async
  {
    name=await SharedPrefenceHelper().getUserName();
    //testing
    email=await SharedPrefenceHelper().getUserEmail();
    print("email is +$email");
    id=await SharedPrefenceHelper().getUserId();
    address=await SharedPrefenceHelper().getUserLocation();

    setState(() {
    });
  }
  //getuserQallet
  getUserWallet()async
  {
    QuerySnapshot querySnapshot=await DatabaseMethods().getUserWalletByEmail(email!);
    wallet="${querySnapshot.docs[0]["Wallet"]}";
    print("ma sanga vako paisa $wallet");
    setState(() {

    });
  }
//display dialog box method for add Address
  TextEditingController addressController = TextEditingController();

  void showAddAddressDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text("Add Your Current Location", style: TextStyle(color: Color(0xff008080),fontSize: 20.0,fontWeight: FontWeight.bold)),
          content: TextField(
            controller: addressController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: "Enter your location",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel", style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                backgroundColor: Colors.greenAccent.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
                shadowColor: Colors.greenAccent,
              ),
              onPressed: () {
                if (addressController.text.isNotEmpty) {
                  // makePayment(totalprice.toString());
                  deductAmountFromWallet();
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please enter an address")),
                  );
                }
              },
              child: Text("Pay"),),
          ],
        );
      },
    );
  }
  deductAmountFromWallet() async {
    // Check if the user has enough funds
    if (int.parse(wallet!) >= totalprice) {
      // Deduct the amount from the wallet
      int updatedWallet = int.parse(wallet!) - totalprice;

      // Update the user's wallet in the database
      await DatabaseMethods().updateUserWallet(updatedWallet.toString(),id!);

      // Create order ID
      String orderId = DateTime.now().millisecondsSinceEpoch.toString();

      // Store order in Firestore for user and admin
      Map<String, dynamic> userOrderMap = {
        "Name": name,
        "Email": email,
        "Id": id,
        "FoodName": widget.name,
        "FoodImage": widget.image,
        "Quantity": quantity.toString(),
        "TotalAmount": totalprice.toString(),
        "OrderId": orderId,
        "Status": "Pending",
        "Address": address ?? addressController.text,
      };

      await DatabaseMethods().addUserOrderDetails(userOrderMap, id!, orderId);
      await DatabaseMethods().addAdminOrderDetails(userOrderMap, orderId);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Payment Successful\nAmount: \$$totalprice"),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      // If not enough balance, show error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Insufficient funds in your wallet"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  //this methods are for payment integration and display payment success or failure message
  // Future<void> makePayment(String amount) async {
  //   try {
  //     paymentIntent = await createPaymentIntent(amount, "USD");
  //     await Stripe.instance.initPaymentSheet(
  //         paymentSheetParameters: SetupPaymentSheetParameters(
  //             customFlow: true,
  //             merchantDisplayName: 'Food Go',
  //             paymentIntentClientSecret: paymentIntent!['client_secret'],
  //             style: ThemeMode.dark,
  //             googlePay: const PaymentSheetGooglePay(
  //               merchantCountryCode: 'US',
  //               currencyCode: 'USD',
  //               testEnv: true,
  //             )));
  //     await displayPaymentSheet();
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }
  //
  // createPaymentIntent(String amount, String currency) async {
  //   try {
  //     Map<String, dynamic> body = {
  //       'currency': currency,
  //       // Convert amount to cents (or the smallest unit)
  //       'amount': ((int.parse(amount)*100)).toString(), // Convert dollars to cents
  //       'payment_method_types[]': 'card'
  //     };
  //
  //     var response = await http.post(
  //         Uri.parse('https://api.stripe.com/v1/payment_intents'),
  //         body: body,
  //         headers: {
  //           'Authorization': 'Bearer $secret_key',
  //           'Content-Type': 'application/x-www-form-urlencoded'
  //         });
  //
  //     return jsonDecode(response.body);
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }
  //
  // displayPaymentSheet() async {
  //   try {
  //     await Stripe.instance.presentPaymentSheet().then(
  //           (value) async {
  //
  //             // After successful payment, reduce the wallet balance
  //             if (int.parse(wallet!) >= totalprice) {
  //               int updatedWallet = int.parse(wallet!) - totalprice;
  //               await DatabaseMethods().updateUserWallet(email!, updatedWallet.toString());
  //
  //             //on successful payment store the user details and it's quantity ,totalamount price on cloudfirestore directly using map
  //             String orderId=randomAlphaNumeric(10);
  //             Map<String,dynamic> userOrderMap={
  //               "Name":name,
  //               "Email":email,
  //               "Id":id,
  //               "FoodName":widget.name,
  //               "FoodImage":widget.image,
  //               "Quantity":quantity.toString(),
  //               "TotalAmount":totalprice.toString(),
  //               "OrderId":orderId,
  //               "Status":"Pending",
  //               "Address":address??addressController.text,
  //             };
  //               // Store order in Firestore for user and admin
  //               //kuna user le kuna order leyo store garna ko lagi
  //             await DatabaseMethods().addUserOrderDetails(userOrderMap, id!, orderId);
  //             //admin le order kuna kuna gayo herna ko lagi without integrate on user
  //             //for ordermanagement: admin ko lagi
  //             await DatabaseMethods().addAdminOrderDetails(userOrderMap, orderId);
  //
  //         // On successful payment, show success message using Snackbar
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text("Payment Successful\nAmount: \$$totalprice"),
  //             backgroundColor: Colors.green,
  //           ),
  //         );
  //             } else {
  //               // If not enough balance, show error
  //               ScaffoldMessenger.of(context).showSnackBar(
  //                 SnackBar(
  //                   content: Text("Insufficient funds in your wallet"),
  //                   backgroundColor: Colors.red,
  //                 ),
  //               );
  //             }
  //       },
  //     );
  //     paymentIntent = null;
  //   } on StripeException catch (e) {
  //     log(e.toString());
  //     // Handle error (failed payment)
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text("Payment Failed\nPlease try again."),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   } catch (e) {
  //     log(e.toString());
  //     // Handle any other exception
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text("Payment Failed\nPlease try again."),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
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
              Center(child: Image.network(widget.image,height: MediaQuery.of(context).size.height/3,fit: BoxFit.contain,)),
              Text(widget.name,style: AppWidget.HeadLineTextFieldStyle(),),
              Text("\$${widget.price}",style: AppWidget.priceTextFiledStyle(),),
              SizedBox(height: 10.0,),
          
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    textAlign: TextAlign.justify,
                    widget.description,
                    style: AppWidget.SimpleTextFieldStyle(),),
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
                            // makePayment(totalprice.toString());
                            showAddAddressDialog();
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
