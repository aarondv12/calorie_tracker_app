import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'food_item.dart';
import 'package:intl/intl.dart';

/// [HiveHelper] is a utility class that provides helper methods for managing
/// the Hive database. It is used to store and retrieve food items data.
class HiveHelper {
  /// The constant name of the box that holds the food items.
  static const String _foodItemsBoxName = 'foodItems';

  /// Initializes the Hive database and registers the [FoodItemAdapter].
  /// This method should be called before using any other HiveHelper methods.
  static Future<void> init() async {
    await Hive.initFlutter((await getApplicationDocumentsDirectory()).path);
    Hive.registerAdapter(FoodItemAdapter());
    await Hive.openBox<FoodItem>(_foodItemsBoxName);
  }
  /// Saves the current food items from [_foodItemsBoxName] box into
  /// a separate box specific to the [date]. It clears the existing data
  /// in the box and stores the new [FoodItem] list.
  static Future<void> saveFoodItemsWithDate(DateTime date) async {
    final formattedDate = DateFormat('yyyy-MM-dd').format(date);
    final savedBox = await Hive.openBox<FoodItem>('savedFoodItems_$formattedDate');
    await savedBox.clear();
    List<FoodItem> newFoodItems = foodItemsBox.values.map((item) => FoodItem(name: item.name, calories: item.calories)).toList();
    await savedBox.addAll(newFoodItems);
  }

  /// Returns the box containing the [FoodItem] objects.
  static Box<FoodItem> get foodItemsBox =>
      Hive.box<FoodItem>(_foodItemsBoxName);

  /// Loads the list of [FoodItem] objects for a specific [date].
  /// Opens the box if it's not already open and returns the list of
  /// food items as [List<FoodItem>].
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
