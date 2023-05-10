import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'food_item.dart';
import 'package:intl/intl.dart';


class HiveHelper {

  static const String _foodItemsBoxName = 'foodItems';


  static Future<void> init() async {
    await Hive.initFlutter((await getApplicationDocumentsDirectory()).path);
    Hive.registerAdapter(FoodItemAdapter());
    await Hive.openBox<FoodItem>(_foodItemsBoxName);
  }

  static Future<void> saveFoodItemsWithDate(DateTime date) async {
    final formattedDate = DateFormat('yyyy-MM-dd').format(date);
    final savedBox = await Hive.openBox<FoodItem>('savedFoodItems_$formattedDate');
    await savedBox.clear();
    List<FoodItem> newFoodItems = foodItemsBox.values.map((item) => FoodItem(name: item.name, calories: item.calories)).toList();
    await savedBox.addAll(newFoodItems);
  }


  static Box<FoodItem> get foodItemsBox =>
      Hive.box<FoodItem>(_foodItemsBoxName);


  static Future<List<FoodItem>> loadFoodItemsByDate(DateTime date) async {
    final formattedDate = DateFormat('yyyy-MM-dd').format(date);
    final boxName = 'savedFoodItems_$formattedDate';

    Box<FoodItem> savedBox;
    if (Hive.isBoxOpen(boxName)) {
      savedBox = Hive.box<FoodItem>(boxName);
    } else {
      savedBox = await Hive.openBox<FoodItem>(boxName);
    }

    return savedBox.values.toList();
  }

}
