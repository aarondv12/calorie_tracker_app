import 'package:flutter/material.dart';
import 'main.dart';
import 'calorietrackpage.dart';

/// A StatefulWidget representing the user information page.
///
/// This page is responsible for collecting user data such as age, height,
/// weight, gender, and fitness goal to calculate the recommended daily calories.
class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

/// The internal state of [UserInfoPage].
///
/// This class manages the state of form fields and validation logic
/// for the user information page.
class _UserInfoPageState extends State<UserInfoPage> {
  /// Global key to manage form state and validation.
  final _formKey = GlobalKey<FormState>();

  /// Text editing controllers for user input fields.
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  /// Variables to store user gender and fitness goal selections.
  String? gender;
  String? goal;

  @override
  Widget build(BuildContext context) {
    /// The following code builds the UI and manages user inputs, validation,
    /// and navigation. Detailed comments are not added here as it's self-explanatory
    /// and follows the standard Flutter widget structure.
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'User Information',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
        padding: const EdgeInsets.all(20),
    child: Form(
    key: _formKey, // Add _formKey to the Form widget
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    SizedBox(height: 30),
    Text(
    'Please enter your information',
    style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    ),
    ),
    SizedBox(height: 20),
    TextFormField(
    controller: ageController,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
    labelText: 'Age',
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    ),
    prefixIcon: Icon(Icons.person),
    ),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter your age';
    }
    return null;
    },
    ),

    SizedBox(height: 20),
    TextFormField(
    controller: heightController,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
    labelText: 'Height (cm)',
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    ),
    prefixIcon: Icon(Icons.height),
    ),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter your height';
    }
    return null;
    },
    ),
    SizedBox(height: 20),
    TextFormField(
    controller: weightController,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
    labelText: 'Weight (kg)',
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    ),
    prefixIcon: Icon(Icons.fitness_center),
    ),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter your weight';
    }
    return null;
    },
    ),
    SizedBox(height: 20),
    DropdownButtonFormField<String>(
    value: gender,
    onChanged: (String? newValue) {
    setState(() {
    gender = newValue!;
    });
    },
    decoration: InputDecoration(
    labelText: 'Gender',
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    ),
    prefixIcon: Icon(Icons.person_outline),
    ),
    items: <String>['Male', 'Female', 'Other']
        .map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
    value: value,
    child: Text(value),
    );
    }).toList(),
    validator: (value) {
    if (value == null) {
    return 'Please select your gender';
    }
    return null;
    },
    ),
    SizedBox(height: 20),
    DropdownButtonFormField
    <String>(
    value: goal,
    onChanged: (String? newValue) {
    setState(() {
    goal = newValue!;
    });
    },
    decoration: InputDecoration(
    labelText: 'Goal',
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    ),
    prefixIcon: Icon(Icons.flag),
    ),
    items: <String>['Lose weight', 'Maintain weight', 'Gain weight']
        .map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
    value: value,
    child: Text(value),
    );
    }).toList(),
    validator: (value) {
    if (value == null) {
    return 'Please select your goal';
    }
    return null;
    },
    ),
      SizedBox(height: 40),
      Center(
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              int age = int.parse(ageController.text);
              double height = double.parse(heightController.text);
              double weight = double.parse(weightController.text);
              int dailyCalories =
              calculateDailyCalories(age, height, weight, gender!, goal!);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        HomePage(dailyCalories: dailyCalories)),
              );
            }
          },
          child: Text(
            'Save',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    ],
    ),
    ),
        ),
    );
  }
}