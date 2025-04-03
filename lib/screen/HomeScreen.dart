import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_go/model/burger_model.dart';
import 'package:food_go/model/category_model.dart';
import 'package:food_go/model/pizza_model.dart';
import 'package:food_go/screen/DetailScreen.dart';
import 'package:food_go/service/burger_data.dart';
import 'package:food_go/service/category_data.dart';
import 'package:food_go/service/database.dart';
import 'package:food_go/service/pizza_dart.dart';
import 'package:food_go/service/widget_support.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String selectedCategory = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 20.0, top: 30.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      height: 50,
                      width: 130,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      "Order your favourite food!",
                      style: AppWidget.SimpleTextFieldStyle(),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/images/boy.jpg",
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      )),
                )
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            //search food item
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
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search food item..."),
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
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 30.0,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            //create category tile builder
            StreamBuilder<QuerySnapshot>(
              stream: DatabaseMethods().getCategories(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var categories = snapshot.data!.docs; //yesle or var le list of data or list of docs store gareko hunxa
                return Container(
                  height: 75,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: categories.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var category = categories[index];
                        return CategoryTile(
                            name: category["name"],
                            image: category["image"],
                            isSelected: selectedCategory == category["name"],
                            onTap: () {
                              setState(() {
                                selectedCategory = category["name"];
                              });
                            });
                      }),
                );
              },
            ),
            SizedBox(
              height: 15.0,
            ),
            //create productbuilder
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: selectedCategory.isEmpty
                  ? FirebaseFirestore.instance
                      .collection('products')
                      .snapshots()
                  : DatabaseMethods().getProducts(selectedCategory),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                var products = snapshot.data!.docs;
                return GridView.builder(
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.67,
                        mainAxisSpacing: 17.0,
                        crossAxisSpacing: 24.0),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      var product = products[index];
                      return FoodTile(
                        name: product['name'],
                        image: product['image'],
                        price: product['price'],
                        description: product['description'],
                      );
                    });
              },
            ))
          ],
        ),
      ),
    );
  }

  //create CategoryIile widget
  Widget CategoryTile({
    required String name,
    required String image,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.only(left: 10.0,right: 10.0,top: 8,bottom: 8),
        margin: EdgeInsets.only(right: 12.0), // Removed left margin
        decoration: BoxDecoration(
          color: isSelected ? Color(0xffef2b39) : Color(0xffececf8),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
          border: Border.all(
            color: isSelected ? Color(0xffef2b39) : Colors.grey.shade300,
            width: isSelected ? 2.0 : 1.0,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                image,
                height: 48,
                width: 48,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Text(
              name,
              style: isSelected
                  ? AppWidget.whiteTextFieldStyle().copyWith(fontSize:28)
                  : AppWidget.boldTextFiledStyle().copyWith(fontSize: 28),
            ),
          ],
        ),
      ),
    );
  }


  //create FoodTile Widget
  Widget FoodTile(
      {required String name,
      required String image,
      required String price,
      required description}) {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      padding: EdgeInsets.only(left: 10.0, top: 10.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Image.network(
            image,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          )),
          Text(
            name,
            style: AppWidget.boldTextFiledStyle(),
          ),
          Text(
            "\$" + price,
            style: AppWidget.priceTextFiledStyle(),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Detailscreen(
                                image: image,
                                name: name,
                                price: price,
                                description:description,
                              )));
                },
                child: Container(
                  height: 50,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Color(0xffef2b39),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(26),
                          bottomRight: Radius.circular(18))),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
