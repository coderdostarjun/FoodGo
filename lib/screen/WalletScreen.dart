import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_go/service/database.dart';
import 'package:food_go/service/shared_pref.dart';
import 'package:food_go/service/widget_support.dart';
import 'package:http/http.dart' as http;
import 'package:random_string/random_string.dart';

import '../service/key_constants.dart';

class Walletscreen extends StatefulWidget {
  const Walletscreen({super.key});

  @override
  State<Walletscreen> createState() => _WalletscreenState();
}

class _WalletscreenState extends State<Walletscreen> {
  //get wallet data from firestore
  String? email,id,wallet;
  getsharedpref() async
  {
    email=await SharedPrefenceHelper().getUserEmail();
    id=await SharedPrefenceHelper().getUserId();
  }
   getUserWallet()async
   {
     QuerySnapshot querySnapshot=await DatabaseMethods().getUserWalletByEmail(email!);
     wallet="${querySnapshot.docs[0]["Wallet"]}";
     print("ma sanga vako paisa $wallet");
     setState(() {

     });
   }
@override
  void initState() {
    // TODO: implement initState
  getsharedpref().then((_) {
    getUserWallet();
  });
    super.initState();

  }
  //payment integration methods
  Map<String, dynamic>? paymentIntent;
  int quantity=1,totalprice=0;

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
      await displayPaymentSheet(amount);
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

  displayPaymentSheet(String amount) async {
    try {
      await Stripe.instance.presentPaymentSheet().then(
            (value) async {

              //jati paisa add garxa tyo database ma ni update hunxa
              int updatedWallet=int.parse(wallet!)+int.parse(amount!);
              await DatabaseMethods().updateUserWallet(updatedWallet.toString(), id!);
              await getUserWallet();
              setState(() {

              });

          // On successful payment, show success message using Snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("\nAmount:\$$amount added Successfully on Wallet"),
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

  //display dialog box method for add money
  void showAddMoneyDialog() {
    TextEditingController amountController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text("Add Money to Wallet", style: TextStyle(color: Color(0xff008080),fontSize: 20.0,fontWeight: FontWeight.bold)),
          content: TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Enter amount",
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
                if (amountController.text.isNotEmpty) {
                  makePayment(amountController.text);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please enter an amount")),
                  );
                }
              },
              child: Text("Add"),),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:wallet==null?Center(child: CircularProgressIndicator()): Container(
        margin: EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Wallet",style: AppWidget.HeadLineTextFieldStyle(),)
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
                      child: Material(
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:
                          Row(
                            children: [
                              Image.asset("assets/images/wallet.png",height: 70,width: 70,fit: BoxFit.cover,),
                              SizedBox(width: 50.0,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Your Wallet",style: AppWidget.boldTextFiledStyle(),),
                                  Text("\$"+wallet!,style: AppWidget.HeadLineTextFieldStyle(),),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.0,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap:()
                      {
                        makePayment("100");
                      },
                            child: Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black45,width: 2.0,),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(child: Text("\$100",style: AppWidget.priceTextFiledStyle(),)),
                            ),
                          ),
                          GestureDetector(
                            onTap:()
                            {
                              makePayment("50");
                            },
                            child: Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black45,width: 2.0,),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(child: Text("\$50",style: AppWidget.priceTextFiledStyle(),)),
                            ),
                          ),
                          GestureDetector(
                            onTap:()
                            {
                              makePayment("200");
                            },
                            child: Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black45,width: 2.0,),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(child: Text("\$200",style: AppWidget.priceTextFiledStyle(),)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30.0),
                    GestureDetector(
                 onTap:(){
                   showAddMoneyDialog();
                    },
                      child: Container(
                        margin: EdgeInsets.only(left: 20.0,right: 20.0),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xffef2b39),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(child: Text("Add Money",style: AppWidget.boldwhiteTextFieldStyle(),)),
                      ),
                    )
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
