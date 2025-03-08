import 'package:food_go/model/category_model.dart';

List<CategoryModel>getCategories()
{
  List<CategoryModel> category=[];

  category.add(CategoryModel(name: "Pizza", image: "assets/images/pizza.png"));
  category.add(CategoryModel(name: "Burger", image: "assets/images/burger.png"));
  category.add(CategoryModel(name: "Chinese", image: "assets/images/chinese.png"));
  category.add(CategoryModel(name: "Mexican", image: "assets/images/tacos.png"));

  return category;

}