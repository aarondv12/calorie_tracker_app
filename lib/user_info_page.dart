import 'package:flutter/material.dart';
import 'main.dart';
import 'calorietrackpage.dart';

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final _formKey = GlobalKey<FormState>(); // Define _formKey here
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  String? gender;
  String? goal;

  @override
  Widget build(BuildContext context) {
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