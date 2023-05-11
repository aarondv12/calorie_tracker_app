import 'package:hive/hive.dart';

part 'food_item.g.dart';

/// A [FoodItem] class representing an individual food item with its name and calories.
///
/// This class is annotated with `@HiveType` to enable Hive support for serialization.
/// The `typeId` is set to 0 to uniquely identify the class within Hive.
@HiveType(typeId: 0)
class FoodItem extends HiveObject {
  /// The name of the food item.
  ///
  /// Annotated with `@HiveField(0)` for Hive support.
  @HiveField(0)
  String name;


  /// The number of calories in the food item.
  ///
  /// Annotated with `@HiveField(1)` for Hive support.
  @HiveField(1)
  int calories;

  /// Constructs a [FoodItem] instance with the given [name] and [calories].
  FoodItem({required this.name, required this.calories});

}
