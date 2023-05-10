import 'package:hive/hive.dart';



@HiveType(typeId: 0)
class FoodItem extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int calories;

  FoodItem({required this.name, required this.calories});
}
