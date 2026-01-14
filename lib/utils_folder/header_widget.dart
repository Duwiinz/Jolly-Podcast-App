import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Jolly",
          style: TextStyle(
            color: Colors.greenAccent,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: const [
            Icon(Icons.notifications_none, color: Colors.white),
            SizedBox(width: 16),
            CircleAvatar(radius: 16),
          ],
        )
      ],
    );
  }
}
