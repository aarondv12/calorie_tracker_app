import 'package:flutter/material.dart';
import 'hive_helper.dart';
import 'food_item.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'main.dart';


class _HomePageState extends State<HomePage> {
  List<FoodItem> _foodItems = [];
  int _totalCalories = 0;
  bool _isCurrentDate = true;

  @override
  void initState() {
    super.initState();
    _fetchFoodItems();
  }
}

void _fetchFoodItems() async {
  final items = HiveHelper.foodItemsBox.values.toList();
  setState(() {
    _foodItems = items;
    _totalCalories = items.fold(0, (sum, item) => sum + item.calories);
  });
}

void _addFoodItem(String foodItem, int calories) async {
  final item = FoodItem(name: foodItem, calories: calories);
  await HiveHelper.foodItemsBox.add(item);
  setState(() {
    _foodItems.add(item);
    _totalCalories += calories;
  });
}

void _deleteFoodItem(int index) async {
  final item = _foodItems[index];
  await HiveHelper.foodItemsBox.delete(item.key);
  setState(() {
    _foodItems.removeAt(index);
    _totalCalories -= item.calories;
  });
}
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
