
import 'package:flutter/material.dart';
import '../widgets/calendar_widget.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Calendar'),
        backgroundColor: const Color.fromRGBO(174, 216, 149, 1),
      ),
      body: const SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: CalendarWidget(),
          ),
        ),
      ),
    );
  }
}