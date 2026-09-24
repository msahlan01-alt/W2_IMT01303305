```
── features/menu/presentation/
    ── menu_screen.dart
    ── widgets/
        ── menu_header.dart
            ── MenuHeader (const)
                ── Column → Text, SizedBox, Row → Icon, Text
        ── menu_search_field.dart
            ── MenuSearchField (const)
                ── Padding → TextField → InputDecoration, IconButton
        ── menu_empty_state.dart
            ── MenuEmptyState (const)
                ── Center → Column → Icon, Text, TextButton
        ── price_chip.dart
            ── PriceChip (const)
                ── Text
        ── quantity_stepper.dart
            ── QuantityStepper (const)
                ── Row → IconButton, Text, IconButton
        ── menu_item_card.dart
            ── MenuItemCard (const)
                ── Column → Row → Text, Text(PROMO), PriceChip, QuantityStepper → Divider
        ── order_total_bar.dart
            ── OrderTotalBar (const)
                ── Column → Divider, Row → Text, PriceChip, FilledButton
```
