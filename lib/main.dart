import 'package:flutter/material.dart';
import 'hive_helper.dart';
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
    Food(name: 'Yogurt', calories: 100, category: 'snack'),
    Food(name: 'Apple', calories: 95, category: 'snack'),
    Food(name: 'Orange Juice', calories: 110, category: 'drink'),
    Food(name: 'Milk', calories: 150, category: 'drink'),
    Food(name: 'Apple', calories: 95, category: 'snack'),
    Food(name: 'Banana', calories: 105, category: 'snack'),
    Food(name: 'Orange', calories: 62, category: 'snack'),
    Food(name: 'Pear', calories: 57, category: 'snack'),
    Food(name: 'Grapes', calories: 69, category: 'snack'),
    Food(name: 'Strawberries', calories: 49, category: 'snack'),
    Food(name: 'Blueberries', calories: 84, category: 'snack'),
    Food(name: 'Raspberries', calories: 65, category: 'snack'),
    Food(name: 'Pineapple', calories: 82, category: 'snack'),
    Food(name: 'Watermelon', calories: 46, category: 'snack'),
    Food(name: 'Cantaloupe', calories: 56, category: 'snack'),
    Food(name: 'Honeydew melon', calories: 64, category: 'snack'),
    Food(name: 'Dried apricots', calories: 212, category: 'snack'),
    Food(name: 'Dried cranberries', calories: 123, category: 'snack'),
    Food(name: 'Dried mango', calories: 107, category: 'snack'),
    Food(name: 'Raisins', calories: 85, category: 'snack'),
    Food(name: 'Almonds', calories: 164, category: 'snack'),
    Food(name: 'Peanuts', calories: 176, category: 'snack'),
    Food(name: 'Cashews', calories: 155, category: 'snack'),
    Food(name: 'Pistachios', calories: 159, category: 'snack'),
    Food(name: 'Walnuts', calories: 185, category: 'snack'),
    Food(name: 'Pecans', calories: 196, category: 'snack'),
    Food(name: 'Hummus', calories: 25, category: 'snack'),
    Food(name: 'Pita chips', calories: 130, category: 'snack'),
    Food(name: 'Trail mix', calories: 200, category: 'snack'),
    Food(name: 'Granola', calories: 120, category: 'snack'),
    Food(name: 'Cheese and crackers', calories: 200, category: 'snack'),
    Food(name: 'Vegetable sticks with dip', calories: 100, category: 'snack'),
    Food(name: 'Popcorn', calories: 30, category: 'snack'),
    Food(name: 'Rice cakes', calories: 35, category: 'snack'),
    Food(name: 'Hard boiled eggs', calories: 78, category: 'snack'),
    Food(name: 'Beef jerky', calories: 80, category: 'snack'),
    Food(name: 'Turkey jerky', calories: 70, category: 'snack'),
    Food(name: 'String cheese', calories: 80, category: 'snack'),
    Food(name: 'Protein bar', calories: 200, category: 'snack'),
    Food(name: 'Energy balls', calories: 120, category: 'snack'),
    Food(name: 'Smoothie', calories: 150, category: 'snack'),
    Food(name: 'Protein shake', calories: 130, category: 'snack'),
    Food(name: 'Fruit and nut bars', calories: 200, category: 'snack'),
    Food(name: 'Rice crackers', calories: 110, category: 'snack'),
    Food(name: 'Edamame', calories: 150, category: 'snack'),
    Food(name: 'Popcorn chicken', calories: 140, category: 'snack'),
    Food(name: 'Pork rinds', calories: 80, category: 'snack'),
    Food(name: 'Sweet potato fries', calories: 140, category: 'snack'),
    Food(name: 'Kale chips', calories: 60, category: 'snack'),
    Food(name: 'Beef sticks', calories: 100, category: 'snack'),
    Food(name: 'Turkey sticks', calories: 60, category: 'snack'),
    Food(name: 'Mini quesadillas', calories: 180, category: 'snack'),
    Food(name: 'Guacamole', calories: 25, category: 'snack'),
    Food(name: 'Salsa', calories: 10, category: 'snack'),
    Food(name: 'Water', calories: 0, category: 'drink'),
    Food(name: 'Black coffee', calories: 2, category: 'drink'),
    Food(name: 'Green tea', calories: 0, category: 'drink'),
    Food(name: 'Herbal tea', calories: 0, category: 'drink'),
    Food(name: 'Iced tea', calories: 90, category: 'drink'),
    Food(name: 'Orange juice', calories: 112, category: 'drink'),
    Food(name: 'Apple juice', calories: 114, category: 'drink'),
    Food(name: 'Cranberry juice', calories: 137, category: 'drink'),
    Food(name: 'Grapefruit juice', calories: 96, category: 'drink'),
    Food(name: 'Tomato juice', calories: 41, category: 'drink'),
    Food(name: 'Pineapple juice', calories: 132, category: 'drink'),
    Food(name: 'Ginger ale', calories: 90, category: 'drink'),
    Food(name: 'Soda (cola)', calories: 140, category: 'drink'),
    Food(name: 'Soda (lemon-lime)', calories: 140, category: 'drink'),
    Food(name: 'Soda (orange)', calories: 150, category: 'drink'),
    Food(name: 'Sports drink', calories: 80, category: 'drink'),
    Food(name: 'Coconut water', calories: 45, category: 'drink'),
    Food(name: 'Almond milk', calories: 60, category: 'drink'),
    Food(name: 'Soy milk', calories: 80, category: 'drink'),
    Food(name: 'Cow milk', calories: 102, category: 'drink'),
    Food(name: 'Chocolate milk', calories: 200, category: 'drink')
  ];
}
