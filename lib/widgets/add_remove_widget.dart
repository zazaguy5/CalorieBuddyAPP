import 'package:flutter/material.dart';

class AddRemoveWidget extends StatelessWidget {
  final String value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const AddRemoveWidget({
    super.key,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onDecrement,
          icon: const Icon(Icons.remove, size: 32, color: Colors.white),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        IconButton(
          onPressed: onIncrement,
          icon: const Icon(Icons.add, size: 32, color: Colors.white),
        ),
      ],
    );
  }
}