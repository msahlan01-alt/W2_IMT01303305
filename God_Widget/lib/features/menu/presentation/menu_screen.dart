import 'package:flutter/material.dart';
import 'widgets/menu_header.dart';
import 'widgets/menu_search.dart';
import 'widgets/menu_empty_state.dart';
import 'widgets/menu_item_card.dart';
import 'widgets/order_total.dart';

/// Belongs in features/menu/domain/ once that folder exists.
/// Week 7 turns this into a real model with serialisation. Leave it for now.
class MenuItem {
  MenuItem({
    required this.id,
    required this.name,
    required this.price,
    this.promo = false,
  });

  final String id;
  final String name;
  final int price;
  final bool promo;
}

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final List<MenuItem> _items = [
    MenuItem(id: 'm1', name: 'Nasi Goreng Spesial', price: 18000, promo: true),
    MenuItem(id: 'm2', name: 'Mie Ayam Bakso', price: 15000),
    MenuItem(id: 'm3', name: 'Sate Ayam (10 tusuk)', price: 25000),
    MenuItem(id: 'm4', name: 'Ayam Geprek Sambal Matah', price: 20000, promo: true),
    MenuItem(id: 'm5', name: 'Soto Ayam Lamongan', price: 17000),
    MenuItem(id: 'm6', name: 'Es Teh Manis', price: 5000),
    MenuItem(id: 'm7', name: 'Es Jeruk Peras', price: 8000),
    MenuItem(id: 'm8', name: 'Kopi Susu Gula Aren', price: 12000),
  ];

  final Map<String, int> _quantities = {};

  late final TextEditingController _searchController;
  late final ScrollController _listController;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _listController = ScrollController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _listController.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() => _query = '');
  }

  void _setQuantity(String id, int qty) {
    setState(() => _quantities[id] = qty);
  }

  void _saveOrder(int total) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Pesanan disimpan: Rp $total')),
    );
    setState(() => _quantities.clear());
  }

  @override
  Widget build(BuildContext context) {
    final visible = _items
        .where((item) =>
            _query.isEmpty ||
            item.name.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    int total = 0;
    int lineCount = 0;
    for (final item in _items) {
      final qty = _quantities[item.id] ?? 0;
      if (qty > 0) {
        lineCount++;
        total += item.price * qty;
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Warung Digital')),
      body: Column(
        children: [
          const MenuHeader(),
          MenuSearch(
            controller: _searchController,
            query: _query,
            onChanged: (value) => setState(() => _query = value),
            onClear: _clearSearch,
          ),
          Expanded(
            child: visible.isEmpty
                ? MenuEmptyState(query: _query, onClear: _clearSearch)
                : ListView.builder(
                    controller: _listController,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: visible.length,
                    itemBuilder: (context, index) {
                      final item = visible[index];
                      final qty = _quantities[item.id] ?? 0;
                      return MenuItemCard(
                        item: item,
                        quantity: qty,
                        onDecrement: qty == 0
                            ? null
                            : () => _setQuantity(item.id, qty - 1),
                        onIncrement: qty >= 99
                            ? null
                            : () => _setQuantity(item.id, qty + 1),
                      );
                    },
                  ),
          ),
          OrderTotalBar(
            lineCount: lineCount,
            total: total,
            onSave: total == 0 ? null : () => _saveOrder(total),
          ),
        ],
      ),
    );
  }
}