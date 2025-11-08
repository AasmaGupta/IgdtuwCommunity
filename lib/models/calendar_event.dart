class CalendarEvent {
  final String time;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime date;

  CalendarEvent({
    required this.time,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.date,
  });

  // Add a factory constructor for creating events
  factory CalendarEvent.fromJson(Map<String, dynamic> json) {
    return CalendarEvent(
      time: json['time'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      date: DateTime.parse(json['date'] as String),
    );
  }

  // Add a method to convert event to JSON
  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'date': date.toIso8601String(),
    };
  }
}
