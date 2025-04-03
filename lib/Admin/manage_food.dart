import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_go/service/database.dart';

import '../service/widget_support.dart';

class ManageFood extends StatefulWidget {
  const ManageFood({super.key});

  @override
  State<ManageFood> createState() => _ManageFoodState();
}

class _ManageFoodState extends State<ManageFood> {
  final TextEditingController categoryNameController = TextEditingController();
  final TextEditingController categoryImageController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productImageController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController productDescriptionController = TextEditingController();
  String selectedCategory = "";

  void addCategory() {
    DatabaseMethods().addCategory(categoryNameController.text, categoryImageController.text);
    categoryNameController.clear();
    categoryImageController.clear();
  }

  void addProduct() {
    DatabaseMethods().addProduct(
      selectedCategory,
      productNameController.text,
      productImageController.text,
      productPriceController.text,
      productDescriptionController.text,
    );
    productNameController.clear();
    productImageController.clear();
    productPriceController.clear();
    productDescriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xffef2b39),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.arrow_back_rounded, color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    "Manage Food",
                    style: AppWidget.HeadLineTextFieldStyle(),
                  ),
                ],
              ),
              SizedBox(height: 30),

              // Add Category Section
              _buildSectionTitle("Add Category"),
              _buildTextField(categoryNameController, "Category Name"),
              _buildTextField(categoryImageController, "Category Image URL"),
              _buildActionButton("Add Category", addCategory),
              SizedBox(height: 20),

              // Select Category Dropdown
              _buildSectionTitle("Select Category"),
              StreamBuilder<QuerySnapshot>(
                stream: DatabaseMethods().getCategories(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                  var categories = snapshot.data!.docs;
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: Text("Select Category"),
                        value: selectedCategory.isEmpty ? null : selectedCategory,
                        onChanged: (value) => setState(() => selectedCategory = value!),
                        items: categories.map((category) {
                          return DropdownMenuItem<String>(
                            value: category['name'],
                            child: Text(category['name']),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),

              // Add Product Section
              _buildSectionTitle("Add Product"),
              _buildTextField(productNameController, "Product Name"),
              _buildTextField(productImageController, "Product Image URL"),
              _buildTextField(productPriceController, "Price"),
              _buildTextField(productDescriptionController, "Description"),
              _buildActionButton("Add Product", addProduct),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable Section Title Widget
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
  }

  // Reusable TextField Widget
  Widget _buildTextField(TextEditingController controller, String hintText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        ),
      ),
    );
  }

  // Reusable Action Button Widget
  Widget _buildActionButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xffef2b39),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: EdgeInsets.symmetric(vertical: 12),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
