import 'package:flutter/material.dart';

class DaySelector extends StatefulWidget {
  final Function(int)? onDaySelected;
  final int? initialSelectedIndex;
  final Color selectedColor;

  const DaySelector({
    Key? key,
    this.onDaySelected,
    this.initialSelectedIndex,
    this.selectedColor = const Color(0xFF618F46),
  }) : super(key: key);

  @override
  State<DaySelector> createState() => _DaySelectorState();
}

class _DaySelectorState extends State<DaySelector> {
  int selectedIndex = DateTime.now().weekday % 7;
  final List<String> days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  @override
  void initState() {
    super.initState();
    if (widget.initialSelectedIndex != null) {
      selectedIndex = widget.initialSelectedIndex!;
    }
  }

  Widget _dayButton(String day, int index) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        if (widget.onDaySelected != null) {
          widget.onDaySelected!(index);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: isSelected ? widget.selectedColor : Colors.grey[300],
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: widget.selectedColor.withOpacity(0.4),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            day,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: List.generate(
          days.length,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: _dayButton(days[index], index),
          ),
        ),
      ),
    );
  }
}
