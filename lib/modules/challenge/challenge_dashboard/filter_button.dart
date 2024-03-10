import 'package:flutter/material.dart';
import 'package:wiwalk_app/core/extensions/context_extensions.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    Key? key,
    required this.label,
    required this.isSelected,
    this.count,
    this.margin,
  }) : super(key: key);

  final String label;
  final bool isSelected;
  final int? count;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ChoiceChip(
        label: count != null ? Text('$label ($count)') : Text(label),
        selected: isSelected,
        onSelected: (bool selected) {
          // Handle tap if necessary
        },
        selectedColor: context.theme.primaryColor,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : context.colors.text2,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        backgroundColor: context.theme.cardTheme.color,
        shape: StadiumBorder(
          side: BorderSide(
            color: isSelected ? Colors.blue.shade700 : Colors.transparent,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        labelPadding: const EdgeInsets.symmetric(horizontal: 12.0),
      ),
    );
  }
}
