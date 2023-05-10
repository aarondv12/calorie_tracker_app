import 'package:flutter/material.dart';
import 'hive_helper.dart';
import 'food_item.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'main.dart';


class _HomePageState extends State<HomePage> {
  List<FoodItem> _foodItems = [];
  int _totalCalories = 0;
  bool _isCurrentDate = true;

  @override
  void initState() {
    super.initState();
    _fetchFoodItems();
  }
}

void _fetchFoodItems() async {
  final items = HiveHelper.foodItemsBox.values.toList();
  setState(() {
    _foodItems = items;
    _totalCalories = items.fold(0, (sum, item) => sum + item.calories);
  });
}
