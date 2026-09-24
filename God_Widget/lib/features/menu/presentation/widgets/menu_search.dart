import 'package:flutter/material.dart';

class MenuSearch extends StatelessWidget {
  const MenuSearch({
    super.key,
    required this.controller,
    required this.query,
    required this.onChanged,
    required this.onClear,
  });

  final TextEditingController controller;
  final String query;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Cari menu...',
          suffixIcon: query.isEmpty
              ? null
              : IconButton(icon: const Icon(Icons.clear), onPressed: onClear),
        ),
        onChanged: onChanged,
      ),
    );
  }
}