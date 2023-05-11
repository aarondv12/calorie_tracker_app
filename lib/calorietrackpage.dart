import 'package:flutter/material.dart';
import 'hive_helper.dart';
import 'food_item.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'main.dart';

/// A StatefulWidget representing the Home page of the Calorie Tracker app.
///
/// Displays a list of food items and their corresponding calories,
/// allowing users to track their daily calorie intake.
class HomePage extends StatefulWidget {
  /// The daily target for calorie intake.
  final int dailyCalories;

  /// Constructs a [HomePage] with a given [dailyCalories] value.
  HomePage({required this.dailyCalories});

  @override
  _HomePageState createState() => _HomePageState();
}

/// The state for the [HomePage] StatefulWidget.
class _HomePageState extends State<HomePage> {
  /// A list of [FoodItem] objects representing the food items added by the user.
  List<FoodItem> _foodItems = [];

  /// The total calorie count of all the food items in [_foodItems].
  int _totalCalories = 0;

  /// A flag to indicate if the selected date is the current date.
  bool _isCurrentDate = true;

  @override
  void initState() {
    super.initState();
    _fetchFoodItems();
  }

  /// Fetches food items from [HiveHelper.foodItemsBox] and updates the state.
  ///
  /// Sets [_foodItems] to the list of fetched items and updates the [_totalCalories].
  void _fetchFoodItems() async {
    final items = HiveHelper.foodItemsBox.values.toList();
    setState(() {
      _foodItems = items;
      _totalCalories = items.fold(0, (sum, item) => sum + item.calories);
    });
  }

  /// Adds a food item with the given [foodItem] name and [calories] to the list.
  ///
  /// Updates [_foodItems] by adding the new item and adjusts the [_totalCalories].
  void _addFoodItem(String foodItem, int calories) async {
    final item = FoodItem(name: foodItem, calories: calories);
    await HiveHelper.foodItemsBox.add(item);
    setState(() {
      _foodItems.add(item);
      _totalCalories += calories;
    });
  }

  /// Deletes a food item at the specified [index] from the list.
  ///
  /// Updates [_foodItems] by removing the item and adjusts the [_totalCalories].
  void _deleteFoodItem(int index) async {
    final item = _foodItems[index];
    await HiveHelper.foodItemsBox.delete(item.key);
    setState(() {
      _foodItems.removeAt(index);
      _totalCalories -= item.calories;
    });
  }

  /// Creates and returns an [ElevatedButton] representing the Save button.
  ///
  /// The Save button allows the user to save their food items for the selected date.
  ElevatedButton saveButton() {
    return ElevatedButton.icon(
      onPressed: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        );

        if (pickedDate != null) {
          await HiveHelper.saveFoodItemsWithDate(pickedDate);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  "Food items saved for ${DateFormat('yyyy-MM-dd').format(
                      pickedDate)}"),
            ),
          );
        }
      },
      icon: Icon(Icons.save),
      label: Text('Save'),
      style: ElevatedButton.styleFrom(
        primary: Colors.redAccent,
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
  /// Creates and returns an [ElevatedButton] representing the Recall button.
  ///
  /// The Recall button allows the user to retrieve their saved food items for a specific date.
  ElevatedButton recallButton() {
    return ElevatedButton.icon(
      onPressed: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        );

        if (pickedDate != null) {
          List<FoodItem> savedFoodItems = await HiveHelper.loadFoodItemsByDate(
              pickedDate);
          setState(() {
            _foodItems = savedFoodItems;
            _totalCalories =
                savedFoodItems.fold(0, (sum, item) => sum + item.calories);
            _isCurrentDate = DateFormat('yyyy-MM-dd').format(pickedDate) ==
                DateFormat('yyyy-MM-dd').format(DateTime.now());
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  "Food items recalled for ${DateFormat('yyyy-MM-dd').format(
                      pickedDate)}"),
            ),
          );
        }
      },
      icon: Icon(Icons.refresh),
      label: Text('Recall'),
      style: ElevatedButton.styleFrom(
        primary: Colors.green,
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Calorie Tracker'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _foodItems.length,
        itemBuilder: (context, index) {
          return _isCurrentDate ? Dismissible(
            key: Key(_foodItems[index].key.toString()),
            background: Container(
              color: Colors.red,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20),
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              _deleteFoodItem(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Food item deleted"),
                ),
              );
            },
            child: ListTile(
              title: Text(_foodItems[index].name),
              trailing: Text('${_foodItems[index].calories} kcal'),
            ),
          ) : ListTile(
            title: Text(_foodItems[index].name),
            trailing: Text('${_foodItems[index].calories} kcal'),
          );
        },
      ),
      floatingActionButton: _isCurrentDate ? FloatingActionButton(
        onPressed: () => _showAddFoodItemDialog(context, _addFoodItem),
        tooltip: 'Add food item',
        child: Icon(Icons.add),
      ) : null,
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20.0),
        color: themeData.primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            saveButton(),
            recallButton(),
            Expanded(
              child: Text(
                'Daily Calories: ${widget
                    .dailyCalories} kcal\nTotal Calories: $_totalCalories kcal',
                style: themeData.textTheme.subtitle1!.copyWith(
                    color: Colors.white),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Displays a dialog allowing users to add a new food item to the list.
  ///
  /// The [onAddFoodItem] function is called when a new item is added.
  void _showAddFoodItemDialog(BuildContext context,
      Function(String, int) onAddFoodItem) {
    TextEditingController caloriesController = TextEditingController();
    String selectedCategory = 'meal';
    showDialog(
        context: context,
        builder: (context) {
          Food? selectedFood;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                title: Text('Add Food Item'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedCategory = 'meal';
                            });
                          },
                          child: Text('Meal'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                selectedCategory == 'meal'
                                    ? Colors.blue
                                    : Colors.grey),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedCategory = 'snack';
                            });
                          },
                          child: Text('Snack'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                selectedCategory == 'snack'
                                    ? Colors.blue
                                    : Colors.grey),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedCategory = 'drink';
                            });
                          },
                          child: Text('Drink'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                selectedCategory == 'drink'
                                    ? Colors.blue
                                    : Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(right: 8.0),
                            child: DropdownButtonFormField<Food>(
                              items: FoodDatabase.foods
                                  .where((food) =>
                              food.category == selectedCategory)
                                  .map((food) {
                                return DropdownMenuItem<Food>(
                                  child: Text(food.name),
                                  value: food,
                                );
                              }).toList(),
                              hint: Text('Select Food Item'),
                              onChanged: (Food? newValue) {
                                setState(() {
                                  selectedFood = newValue;
                                  if (newValue != null) {
                                    caloriesController.text =
                                        newValue.calories.toString();
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextField(
                      controller: caloriesController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Calories'),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (selectedFood != null) {
                        int calories = int.tryParse(caloriesController.text) ??
                            0;
                        onAddFoodItem(selectedFood!.name,
                            calories); // Call the passed callback
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Add'),
                  ),
                ],
              );
            },
          );
        });
  }
}
