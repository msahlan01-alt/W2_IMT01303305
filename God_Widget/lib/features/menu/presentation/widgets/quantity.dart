import 'package:flutter/material.dart';

class Quantity extends StatelessWidget {
  const Quantity({
    super.key,
    required this.quantity,
    required this.onDecrement,
    required this.onIncrement,
  });

  final int quantity;
  final VoidCallback? onDecrement;
  final VoidCallback? onIncrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(onPressed: onDecrement, icon: const Icon(Icons.remove_circle_outline)),
        SizedBox(
          width: 28,
          child: Text('$quantity', textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        IconButton(onPressed: onIncrement, icon: const Icon(Icons.add_circle_outline)),
      ],
    );
  }
}