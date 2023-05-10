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
class Food {
  final String name;
  final int calories;
  final String category;
  Food({required this.name, required this.calories, required this.category});
}
class FoodDatabase {
  static List<Food> foods = [
    Food(name: 'Oatmeal', calories: 150, category: 'meal'),
    Food(name: 'Salmon poke bowl', calories: 400, category: 'meal'),
    Food(name: 'Chicken Caesar wrap', calories: 320, category: 'meal'),
    Food(name: 'Quinoa salad', calories: 280, category: 'meal'),
    Food(name: 'Soba noodle salad', calories: 350, category: 'meal'),
    Food(name: 'Hummus and pita bread', calories: 200, category: 'meal'),
    Food(name: 'Miso soup', calories: 70, category: 'meal'),
    Food(name: 'Roast beef sandwich', calories: 400, category: 'meal'),
    Food(name: 'Greek yogurt parfait', calories: 250, category: 'meal'),
    Food(name: 'Roasted sweet potatoes', calories: 180, category: 'meal'),
    Food(name: 'Taco salad', calories: 350, category: 'meal'),
    Food(name: 'Caprese sandwich', calories: 320, category: 'meal'),
    Food(name: 'Spinach and feta omelet', calories: 320, category: 'meal'),
    Food(name: 'Broccoli cheddar soup', calories: 200, category: 'meal'),
    Food(name: 'Blackened fish tacos', calories: 400, category: 'meal'),
    Food(name: 'Tomato and mozzarella salad', calories: 150, category: 'meal'),
    Food(name: 'Green smoothie', calories: 200, category: 'drink'),
    Food(name: 'Iced tea', calories: 70, category: 'drink'),
    Food(name: 'Cranberry juice', calories: 120, category: 'drink'),
    Food(name: 'Chicken Shawerma', calories: 840, category: 'meal'),
    Food(name: 'Grilled chicken breast', calories: 165, category: 'meal'),
    Food(name: 'Beef burger', calories: 354,category: 'meal'),
    Food(name: 'Veggie burger', calories: 124, category: 'meal'),
    Food(name: 'Caesar salad', calories: 163, category: 'meal'),
    Food(name: 'Margherita pizza', calories: 250, category: 'meal'),
    Food(name: 'Spaghetti & meatball', calories: 410, category: 'meal'),
    Food(name: 'Fish and chips', calories: 800, category: 'meal'),
    Food(name: 'Chicken stir-fry', calories: 250, category: 'meal'),
    Food(name: 'Tuna sandwich', calories: 290, category: 'meal'),
    Food(name: 'PB and jam sandwich', calories: 360, category: 'meal'),
    Food(name: 'Grilled cheese sandwich', calories: 440, category: 'meal'),
    Food(name: 'Cheese omelet', calories: 310, category: 'meal'),
    Food(name: 'Baked salmon', calories: 206, category: 'meal'),
    Food(name: 'Beef chili', calories: 275, category: 'meal'),
    Food(name: 'Chicken quesadilla', calories: 330, category: 'meal'),
    Food(name: 'Sushi roll ', calories: 255, category: 'meal'),
    Food(name: 'Pad Thai', calories: 350, category: 'meal'),
    Food(name: 'Fried rice', calories: 400, category: 'meal'),
    Food(name: 'Chicken Alfredo', calories: 540, category: 'meal'),
    Food(name: 'Beef stir-fry', calories: 400, category: 'meal'),
    Food(name: 'Chicken fajitas', calories: 420, category: 'meal'),
    Food(name: 'Grilled steak', calories: 250, category: 'meal'),
    Food(name: 'Lentil soup', calories: 200, category: 'meal'),
    Food(name: 'Turkey sandwich', calories: 320, category: 'meal'),
    Food(name: 'Vegetable stir-fry', calories: 200, category: 'meal'),
    Food(name: 'Grilled shrimp', calories: 100, category: 'meal'),
    Food(name: 'Beef stroganoff', calories: 400, category: 'meal'),
    Food(name: 'Roasted chicken breast', calories: 165, category: 'meal'),
    Food(name: 'Falafel wrap', calories: 350, category: 'meal'),
    Food(name: 'Chicken noodle soup', calories: 100, category: 'meal'),
    Food(name: 'Caesar salad with shrimp', calories: 225, category: 'meal'),
    Food(name: 'Veggie stir-fry with tofu', calories: 250, category: 'meal'),
    Food(name: 'Lasagna', calories: 400, category: 'meal'),
    Food(name: 'Beef and broccoli', calories: 300, category: 'meal'),
    Food(name: 'Grilled pork chop', calories: 200, category: 'meal'),
    Food(name: 'Mushroom risotto', calories: 450, category: 'meal'),
    Food(name: 'Grilled cheeseburger', calories: 500, category: 'meal'),
    Food(name: 'Broiled swordfish', calories: 146, category: 'meal'),
    Food(name: 'Greek salad', calories: 200, category: 'meal'),
    Food(name: 'Vegetable lasagna', calories: 350, category: 'meal'),
    Food(name: 'Grilled vegetables ', calories: 150, category: 'meal'),
    Food(name: 'Tofu stir-fry with vegetables', calories: 200, category: 'meal'),
    Food(name: 'Chicken tikka masala', calories: 350, category: 'meal'),
    Food(name: 'Shrimp scampi', calories: 300, category: 'meal'),
    Food(name: 'Lentil salad', calories: 250, category: 'meal'),
    Food(name: 'Turkey chili', calories: 225, category: 'meal'),
    Food(name: 'Grilled eggplant Parmesan', calories: 280, category: 'meal'),
    Food(name: 'Baked chicken thigh', calories: 160, category: 'meal'),
    Food(name: 'Black bean soup', calories: 150, category: 'meal'),
    Food(name: 'Beef and bean burrito', calories: 400, category: 'meal'),
    Food(name: 'Vegetable soup', calories: 100, category: 'meal'),
  ];
}

