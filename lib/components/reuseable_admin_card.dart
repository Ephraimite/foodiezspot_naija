import 'dart:ui';

import 'package:flutter/material.dart';

class AdminReuseableCard extends StatelessWidget {

  final IconData icon;
  final double iconSize;


  AdminReuseableCard({required this.icon, required this.iconSize});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            Icon(icon, size: iconSize),
            SizedBox(height: 10),

          ],
        ),
      ),
    );
  }
}