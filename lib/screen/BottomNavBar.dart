import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_go/screen/HomeScreen.dart';
import 'package:food_go/screen/OrderScreen.dart';
import 'package:food_go/screen/ProfileScreen.dart';
import 'package:food_go/screen/WalletScreen.dart';
class Bottomnavbar extends StatefulWidget {
  const Bottomnavbar.bottomNavBar({super.key});

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  late List<Widget> screens;
  late Homescreen homescreen;
  late Orderscreen orderscreen;
  late Walletscreen walletscreen;
  late Profilescreen profilescreen;
  int currentTableindex=0;
  @override
  void initState() {
    // TODO: implement initState
    homescreen=Homescreen();
    orderscreen=Orderscreen();
    walletscreen=Walletscreen();
    profilescreen=Profilescreen();
    screens=[homescreen,orderscreen,walletscreen,profilescreen];
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 70,
          backgroundColor: Colors.white,
          color: Colors.black,
          animationDuration: Duration(milliseconds: 500),
          onTap: (int index)
          {
            setState(() {
              currentTableindex=index;
            });
          },
          items:[Icon(Icons.home,color: Colors.white,size: 30.0,),
            Icon(Icons.shopping_bag,color: Colors.white,size: 30.0,),
            Icon(Icons.wallet,color: Colors.white,size: 30.0,),
            Icon(Icons.person,color: Colors.white,size: 30.0,)
          ]),
      body:screens[currentTableindex],
    );

  }
}

