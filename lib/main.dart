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

int calculateDailyCalories(int age, double height, double weight, String gender, String goal) {
  double bmr;

  if (gender == 'Male') {
    bmr = 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
  } else {
    bmr = 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
  }

  double multiplier;

  switch (goal) {
    case 'Lose weight':
      multiplier = 1.2;
      break;
    case 'Maintain weight':
      multiplier = 1.55;
      break;
    case 'Gain weight':
      multiplier = 1.9;
      break;
    default:
      multiplier = 1.55;
  }

  int dailyCalories = (bmr * multiplier).round();

  return dailyCalories;
}
}
class CalorieTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calorie Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StartPage(),
    );
  }
}
