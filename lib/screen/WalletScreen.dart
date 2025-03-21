import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
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
                                  Text("\$0.00",style: AppWidget.HeadLineTextFieldStyle(),),
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
                          Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black45,width: 2.0,),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(child: Text("\$100",style: AppWidget.priceTextFiledStyle(),)),
                          ),
                          Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black45,width: 2.0,),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(child: Text("\$100",style: AppWidget.priceTextFiledStyle(),)),
                          ),
                          Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black45,width: 2.0,),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(child: Text("\$100",style: AppWidget.priceTextFiledStyle(),)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Container(
                      margin: EdgeInsets.only(left: 20.0,right: 20.0),
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xffef2b39),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(child: Text("Add Money",style: AppWidget.boldwhiteTextFieldStyle(),)),
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
