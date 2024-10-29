import 'package:flutter/material.dart';
import 'package:todo_app_with_sharedpreference/common/constants/global_variable.dart';

class FilterChipWidget extends StatefulWidget {
  final String chipName;
  final Function(String?) onSelectedFilter;

  const FilterChipWidget({super.key, required this.chipName,required this.onSelectedFilter});

  @override
  State<FilterChipWidget> createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      padding: const EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
        side:BorderSide.none
      ),
      showCheckmark: false,
      label: Text(widget.chipName),
      labelStyle: textTheme(context).bodySmall,
      selected: _isSelected,
      backgroundColor: Colors.grey.shade800,
      side: BorderSide.none,
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
          // Call the filter function with the specific filter type based on the chip name
          widget.onSelectedFilter(widget.chipName);
        });
      },
      selectedColor: colorScheme(context).primary,
    );
  }
}