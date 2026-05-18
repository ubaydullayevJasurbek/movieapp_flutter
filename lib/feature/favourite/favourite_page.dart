import 'package:flutter/material.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouriteState();
}

class _FavouriteState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F172A),
      body: Center(
        child: Text(
          "Favourite Page",
          style: TextStyle(fontSize: 32, color: Colors.white),
        ),
      ),
    );
  }
}
