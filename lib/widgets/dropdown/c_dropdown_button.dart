import 'package:flutter/material.dart';

class CDropdownButton extends StatefulWidget {
  final Map<String, String> items;
  final String initialKey;
  final Function(String) onItemChanged;

  const CDropdownButton({
    Key? key,
    required this.items,
    required this.initialKey,
    required this.onItemChanged,
  }) : super(key: key);

  @override
  State<CDropdownButton> createState() => _CDropdownButtonState();
}

class _CDropdownButtonState extends State<CDropdownButton> {
  late String dropdownKey;

  @override
  void initState() {
    super.initState();
    dropdownKey =
        widget.initialKey; // Initialize with the key of the initial item
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      // Initial Value
      value: dropdownKey,

      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),

      // Array list of items
      items: widget.items.entries.map((MapEntry<String, String> entry) {
        return DropdownMenuItem<String>(
          value: entry.key,
          child: Text(entry.value),
        );
      }).toList(),

      // After selecting the desired option, it will
      // change button value to the key of the selected value
      // and call the onItemChanged callback.
      onChanged: (String? newKey) {
        if (newKey != null) {
          setState(() {
            dropdownKey = newKey;
          });

          widget.onItemChanged(newKey);
        }
      },
    );
  }
}
