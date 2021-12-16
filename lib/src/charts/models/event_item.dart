class EventItem {
  DateTime start;
  DateTime end;
  String title;

  EventItem({
    required this.start,
    required this.end,
    required this.title,
  });

  factory EventItem.fromJson(Map<String, dynamic> json) => EventItem(
        title: json['title'] ?? '',
        start: DateTime.parse(json['start']),
        end: DateTime.parse(json['end']),
      );
}
