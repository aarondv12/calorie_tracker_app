import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'hive_helper.dart';
import 'food_item.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  DateTime _selectedDate = DateTime.now();
  List<FoodItem> _foodItems = [];

}