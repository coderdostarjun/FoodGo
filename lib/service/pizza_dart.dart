import 'dart:math';

import 'package:food_go/model/pizza_model.dart';

List<PizzaModel> getPizza()
{
  List<PizzaModel> pizza=[];

  PizzaModel pizzaModel=new PizzaModel();
  pizzaModel.name="Cheese Pizza";
  pizzaModel.image="assets/images/pizza1.png";
  pizzaModel.price="50";
  pizza.add(pizzaModel);
  pizzaModel=new PizzaModel();

  pizzaModel.name="Margherita pizza";
  pizzaModel.image="assets/images/pizza2.png";
  pizzaModel.price="80";
  pizza.add(pizzaModel);
  pizzaModel=new PizzaModel();

  pizzaModel.name="Margherita pizza";
  pizzaModel.image="assets/images/pizza2.png";
  pizzaModel.price="80";
  pizza.add(pizzaModel);
  pizzaModel=new PizzaModel();

  pizzaModel.name="Margherita pizza";
  pizzaModel.image="assets/images/pizza2.png";
  pizzaModel.price="80";
  pizza.add(pizzaModel);
  pizzaModel=new PizzaModel();

  return pizza;

}