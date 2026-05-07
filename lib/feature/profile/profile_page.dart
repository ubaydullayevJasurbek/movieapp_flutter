import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F172A),
      body: Center(
        child: Text(
          "Category Page",
          style: TextStyle(fontSize: 32, color: Colors.white),
        ),
      ),
    );
  }
}
