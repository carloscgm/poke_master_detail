import 'package:flutter/material.dart';

class EmptyGridCard extends StatelessWidget {
  const EmptyGridCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 2,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
    );
  }
}
