import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  const PriceTag({
    super.key, 
    required this.amount, 
    this.currency = 'Rp',
    this.soldOut = false,
  });

  final int amount;
  final String currency;
  final bool soldOut;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$currency $amount',
          style: TextStyle(
            color: soldOut ? Colors.grey : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        if (soldOut) ...[const Chip(label: Text('Habis'))],
      ],
    );
  }
}