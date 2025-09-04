import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final T? selectedValue;
  final List<T> items;
  final String Function(T) itemToString;
  final ValueChanged<T?> onChanged;
  final double? width;

  const CustomDropdown({
    super.key,
    required this.selectedValue,
    required this.items,
    required this.itemToString,
    required this.onChanged,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 50,
      child: DropdownButton<T>(
        value: selectedValue,
        items: items.map((item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(itemToString(item)),
          );
        }).toList(),
        onChanged: onChanged,
        isExpanded: true,
      ),
    );
  }
}