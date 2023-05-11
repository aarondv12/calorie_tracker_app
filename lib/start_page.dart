import 'package:flutter/material.dart';
import 'historypage.dart';
import 'calorietrackpage.dart';
import 'user_info_page.dart';

/// [StartPage] is a [StatelessWidget] that serves as the landing page for the application.
/// It offers three options for the user: Start Tracking Calories, Enter User Information, and History.
/// Each option navigates to a different page in the application.
class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff1A237E), Color(0xff3949AB)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Calorie Tracker',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 90),
              ElevatedButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage(dailyCalories: 2000)),
                ),
                icon: Icon(Icons.add_box_rounded),
                label: Text('Start Tracking Calories'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffBBDEFB),
                  onPrimary: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
              SizedBox(height: 90),
              ElevatedButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserInfoPage()),
                ),
                icon: Icon(Icons.person),
                label: Text('Enter User Information'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
              SizedBox(height: 90),
              ElevatedButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryPage()),
                ),
                icon: Icon(Icons.history),
                label: Text('History'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}