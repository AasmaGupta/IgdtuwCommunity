import 'package:flutter/material.dart';
import '../models/calendar_event.dart';

class CalendarService {
  static List<String> weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  // Sample events data
  static Map<DateTime, List<CalendarEvent>> get events {
    final now = DateTime.now();
    final currentYear = now.year;
    final currentMonth = now.month;

    return {
      DateTime(currentYear, currentMonth, 1): [
        CalendarEvent(
          time: '09:00',
          title: 'Team Meeting',
          description: 'Weekly team sync',
          imageUrl: 'assets/images/msc.png',
          date: DateTime(currentYear, currentMonth, 1),
        ),
      ],
      DateTime(currentYear, currentMonth, 5): [
        CalendarEvent(
          time: '11:00',
          title: 'Rotaract Meeting',
          description: 'Discussion regarding new changes in design and user flow',
          imageUrl: 'assets/images/rotaract.png',
          date: DateTime(currentYear, currentMonth, 5),
        ),
      ],
      DateTime(currentYear, currentMonth, 10): [
        CalendarEvent(
          time: '13:00',
          title: 'MSC Meeting',
          description: 'Ideating the designs and flow for the app',
          imageUrl: 'assets/images/msc.png',
          date: DateTime(currentYear, currentMonth, 10),
        ),
      ],
      DateTime(currentYear, currentMonth, 15): [
        CalendarEvent(
          time: '15:00',
          title: 'GDG Meeting',
          description: 'Daily status report and upcoming projects discussion',
          imageUrl: 'assets/images/gdg.png',
          date: DateTime(currentYear, currentMonth, 15),
        ),
      ],
      DateTime(currentYear, currentMonth, 20): [
        CalendarEvent(
          time: '14:00',
          title: 'Project Review',
          description: 'Review of current sprint progress',
          imageUrl: 'assets/images/msc.png',
          date: DateTime(currentYear, currentMonth, 20),
        ),
      ],
      DateTime(currentYear, currentMonth, 25): [
        CalendarEvent(
          time: '10:00',
          title: 'Morning Standup',
          description: 'Daily team standup meeting',
          imageUrl: 'assets/images/msc.png',
          date: DateTime(currentYear, currentMonth, 25),
        ),
        CalendarEvent(
          time: '14:00',
          title: 'Client Meeting',
          description: 'Meeting with client to discuss project requirements',
          imageUrl: 'assets/images/rotaract.png',
          date: DateTime(currentYear, currentMonth, 25),
        ),
        CalendarEvent(
          time: '16:00',
          title: 'Workshop',
          description: 'Flutter workshop for beginners',
          imageUrl: 'assets/images/gdg.png',
          date: DateTime(currentYear, currentMonth, 25),
        ),
      ],
      DateTime(currentYear, currentMonth, 26): [
        CalendarEvent(
          time: '17:00',
          title: 'Mohit Chauhan Live',
          description: 'Live concert by Mohit Chauhan',
          imageUrl: 'assets/images/mohit.png',
          date: DateTime(currentYear, currentMonth, 26),
        ),
      ],
      DateTime(currentYear, 5, 5): [
        CalendarEvent(
          time: '10:00',
          title: 'Probability and Statistics',
          description: 'End Term Exam',
          imageUrl: 'assets/images/endterm.png',
          date: DateTime(currentYear, 5, 5),
        ),
      ],
      DateTime(currentYear, 5, 7): [
        CalendarEvent(
          time: '11:00',
          title: 'IDS',
          description: 'End Term Exam',
          imageUrl: 'assets/images/endterm.png',
          date: DateTime(currentYear, 5, 7),
        ),
      ],
      DateTime(currentYear, 5, 9): [
        CalendarEvent(
          time: '09:00',
          title: 'MAD',
          description: 'End Term Exam',
          imageUrl: 'assets/images/endterm.png',
          date: DateTime(currentYear, 5, 9),
        ),
      ],
      DateTime(currentYear, 5, 14): [
        CalendarEvent(
          time: '14:00',
          title: 'DSA',
          description: 'End Term Exam',
          imageUrl: 'assets/images/endterm.png',
          date: DateTime(currentYear, 5, 14),
        ),
      ],
      DateTime(currentYear, 5, 16): [
        CalendarEvent(
          time: '13:00',
          title: 'SSPD',
          description: 'End Term Exam',
          imageUrl: 'assets/images/endterm.png',
          date: DateTime(currentYear, 5, 16),
        ),
      ],
      DateTime(currentYear, 5, 20): [
        CalendarEvent(
          time: '15:00',
          title: 'EVS',
          description: 'End Term Exam',
          imageUrl: 'assets/images/endterm.png',
          date: DateTime(currentYear, 5, 20),
        ),
      ],
    };
  }

  static List<DateTime> getDaysInMonth(DateTime date) {
    final firstDay = DateTime(date.year, date.month, 1);
    final lastDay = DateTime(date.year, date.month + 1, 0);
    
    // Get the weekday of the first day (0-6, where 0 is Sunday)
    final firstWeekday = firstDay.weekday;
    
    // Get the weekday of the last day
    final lastWeekday = lastDay.weekday;
    
    // Calculate the number of days to show from previous month
    final daysFromPrevMonth = firstWeekday % 7;
    
    // Calculate the number of days to show from next month
    final daysFromNextMonth = 6 - (lastWeekday % 7);
    
    // Get the total number of days to show
    final totalDays = lastDay.day + daysFromPrevMonth + daysFromNextMonth;
    
    List<DateTime> days = [];
    
    // Add days from previous month
    final prevMonth = DateTime(date.year, date.month - 1, 1);
    for (int i = 0; i < daysFromPrevMonth; i++) {
      days.add(DateTime(prevMonth.year, prevMonth.month, prevMonth.day + i));
    }
    
    // Add days from current month
    for (int i = 1; i <= lastDay.day; i++) {
      days.add(DateTime(date.year, date.month, i));
    }
    
    // Add days from next month
    final nextMonth = DateTime(date.year, date.month + 1, 1);
    for (int i = 0; i < daysFromNextMonth; i++) {
      days.add(DateTime(nextMonth.year, nextMonth.month, nextMonth.day + i));
    }
    
    return days;
  }

  static String getMonthYearString(DateTime date, {bool shortForm = false}) {
    return '${_getMonthName(date.month, shortForm: shortForm)} ${date.year}';
  }

  static String _getMonthName(int month, {bool shortForm = false}) {
    if (shortForm) {
      switch (month) {
        case 1: return 'JAN';
        case 2: return 'FEB';
        case 3: return 'MAR';
        case 4: return 'APR';
        case 5: return 'MAY';
        case 6: return 'JUN';
        case 7: return 'JUL';
        case 8: return 'AUG';
        case 9: return 'SEP';
        case 10: return 'OCT';
        case 11: return 'NOV';
        case 12: return 'DEC';
        default: return '';
      }
    } else {
      switch (month) {
        case 1: return 'JANUARY';
        case 2: return 'FEBRUARY';
        case 3: return 'MARCH';
        case 4: return 'APRIL';
        case 5: return 'MAY';
        case 6: return 'JUNE';
        case 7: return 'JULY';
        case 8: return 'AUGUST';
        case 9: return 'SEPTEMBER';
        case 10: return 'OCTOBER';
        case 11: return 'NOVEMBER';
        case 12: return 'DECEMBER';
        default: return '';
      }
    }
  }

  static List<CalendarEvent> getEventsForDate(DateTime date) {
    // Normalize the date to remove time component
    final normalizedDate = DateTime(date.year, date.month, date.day);
    return events[normalizedDate] ?? [];
  }

  static bool hasEvents(DateTime date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    return events.containsKey(normalizedDate);
  }
} 