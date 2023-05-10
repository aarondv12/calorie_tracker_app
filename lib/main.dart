import 'package:flutter/material.dart';
import 'hive_helper.dart';
import 'food_item.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'start_page.dart';

enum FoodType { meal, snack, drink }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveHelper.init();
  runApp(CalorieTrackerApp());
}
