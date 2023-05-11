import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'hive_helper.dart';
import 'food_item.dart';

/// [HistoryPage] is a StatefulWidget that displays a history page.
/// The purpose of the page is to show a list of consumed food items
/// with their calorie count on a specific date.
/// The user can select the desired date to see the food items consumed on that date.
class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  /// [_selectedDate] holds the date that the user selects from the date picker.
  DateTime _selectedDate = DateTime.now();

  /// [_foodItems] holds the list of food items for the selected date.
  List<FoodItem> _foodItems = [];

  @override
  void initState() {
    super.initState();
    _fetchFoodItems();
  }

  /// Fetches food items for the selected date from the Hive database.
  /// Sets the state with the fetched items and updates the UI accordingly.
  void _fetchFoodItems() async {
    final items = await HiveHelper.loadFoodItemsByDate(_selectedDate);
    setState(() {
      _foodItems = items;
    });
  }
  /// Calculates the total calories of the food items in [_foodItems].
  /// It returns the sum of calories of all the food items.
  int _calculateTotalCalories() {
    return _foodItems.fold(0, (sum, item) => sum + item.calories);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'History',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Date',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _selectedDate = pickedDate;
                      });
                      _fetchFoodItems();
                    }
                  },
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today),
                      SizedBox(width: 5),
                      Text(
                        DateFormat('yyyy-MM-dd').format(_selectedDate),
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(thickness: 2),
          SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              itemCount: _foodItems.length,
              itemBuilder: (context, index) => CustomListTile(foodItem: _foodItems[index]),
              separatorBuilder: (context, index) => Divider(),
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Calories:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${_calculateTotalCalories()} kcal',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// [CustomListTile] is a StatelessWidget that represents a custom list tile
/// displaying a food item and its calorie count.
///
/// It provides a visually consistent way to show the food item's name
/// and calorie count in the list.
class CustomListTile extends StatelessWidget {
  /// The [FoodItem] to be displayed in the list tile.

  final FoodItem foodItem;
  /// Constructs a [CustomListTile] instance with the given [foodItem].
  /// The [foodItem] parameter is required and cannot be null.
  CustomListTile({required this.foodItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            foodItem.name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${foodItem.calories} kcal',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}