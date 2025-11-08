import 'package:flutter/material.dart';
import '../services/calendar_service.dart';
import '../models/calendar_event.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({Key? key}) : super(key: key);

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _currentDate = DateTime.now();
  DateTime? _selectedDate;
  List<DateTime> _daysInMonth = [];
  List<CalendarEvent> _currentEvents = [];

  @override
  void initState() {
    super.initState();
    _updateDaysInMonth();
    _selectedDate = DateTime.now();
    _updateEvents();
  }

  void _updateDaysInMonth() {
    setState(() {
      _daysInMonth = CalendarService.getDaysInMonth(_currentDate);
    });
  }

  void _updateEvents() {
    if (_selectedDate != null) {
      setState(() {
        _currentEvents = CalendarService.getEventsForDate(_selectedDate!);
      });
    }
  }

  void _previousMonth() {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month - 1);
      _updateDaysInMonth();
    });
  }

  void _nextMonth() {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month + 1);
      _updateDaysInMonth();
    });
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
      _updateEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 480),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCalendarSection(),
            _buildBottomDivider(),
            const SizedBox(height: 19),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarSection() {
    return Container(
      color: const Color.fromRGBO(222, 240, 211, 0.23),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 40),
            Text(
              'Events Calendar',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                fontFamily: 'SF Pro Display',
                color: Colors.black,
                shadows: [
                  Shadow(
                    offset: const Offset(2, 2),
                    blurRadius: 4,
                    color: Colors.black.withOpacity(0.2),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _buildMonthSelector(),
            const SizedBox(height: 19),
            _buildCalendarGrid(),
            const SizedBox(height: 40),
            if (_currentEvents.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'No events for this day',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'SF Pro Text',
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              )
            else
              ..._currentEvents.map((event) => Padding(
                    padding: const EdgeInsets.only(bottom: 28),
                    child: _buildEventCard(
                      time: event.time,
                      title: event.title,
                      description: event.description,
                      imageUrl: event.imageUrl,
                    ),
                  )),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthSelector() {
    return SizedBox(
      width: 191,
      child: Row(
        children: [
          GestureDetector(
            onTap: _previousMonth,
            child: const Icon(Icons.arrow_back_ios, size: 25, color: Colors.black),
          ),
          Expanded(
            child: Text(
              CalendarService.getMonthYearString(_currentDate, shortForm: true),
              style: const TextStyle(
                fontSize: 24,
                fontFamily: 'SF Pro Text',
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          GestureDetector(
            onTap: _nextMonth,
            child: const Icon(Icons.arrow_forward_ios, size: 25, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid() {
    return Container(
      width: 362,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(222, 240, 211, 1),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 11,
            offset: const Offset(3, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildWeekdayHeader(),
          const SizedBox(height: 25),
          ..._buildCalendarRows(),
        ],
      ),
    );
  }

  Widget _buildWeekdayHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: CalendarService.weekdays
            .map(
              (day) => Text(
                day,
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'SF Pro Text',
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  List<Widget> _buildCalendarRows() {
    List<Widget> rows = [];
    for (int i = 0; i < _daysInMonth.length; i += 7) {
      final weekDays = _daysInMonth.sublist(i, i + 7);
      rows.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: weekDays.map((date) => _buildDayCell(date)).toList(),
          ),
        ),
      );
      if (i + 7 < _daysInMonth.length) {
        rows.add(const SizedBox(height: 21));
      }
    }
    return rows;
  }

  Widget _buildDayCell(DateTime date) {
    final isCurrentMonth = date.month == _currentDate.month;
    final isToday = date.year == DateTime.now().year &&
        date.month == DateTime.now().month &&
        date.day == DateTime.now().day;
    final isSelected = _selectedDate != null &&
        date.year == _selectedDate!.year &&
        date.month == _selectedDate!.month &&
        date.day == _selectedDate!.day;
    final hasEvents = CalendarService.hasEvents(date);

    return GestureDetector(
      onTap: () => _onDateSelected(date),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.green
              : isToday
                  ? Colors.green.withOpacity(0.3)
                  : Colors.transparent,
          shape: BoxShape.circle,
          border: isSelected
              ? Border.all(color: Colors.green, width: 2)
              : null,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              date.day.toString(),
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'SF Pro Text',
                fontWeight: FontWeight.w700,
                color: isCurrentMonth
                    ? (isSelected ? Colors.white : Colors.black)
                    : Colors.grey,
              ),
            ),
            if (hasEvents)
              Positioned(
                bottom: 0,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard({
    required String time,
    required String title,
    required String description,
    required String imageUrl,
  }) {
    return Container(
      width: 362,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(174, 216, 149, 1),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 9,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: ClipOval(
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.event,
                    color: Colors.green,
                    size: 20,
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 10,
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  softWrap: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomDivider() {
    return Container(
      width: 357,
      height: 42, // Approximate height based on aspect ratio
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 2),
        ),
      ),
    );
  }
}
