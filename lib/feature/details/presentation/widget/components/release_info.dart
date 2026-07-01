import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReleaseInfo extends StatelessWidget {
  final DateTime releaseDate;

  const ReleaseInfo({
    super.key,
    required this.releaseDate,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "Released ${DateFormat('MMMM d, yyyy').format(releaseDate)}",
      style: const TextStyle(
        color: Colors.white60,
        fontSize: 15,
      ),
    );
  }
}