class DataItem {
  String name;
  double value;
  DateTime? date;

  DataItem({
    required this.name,
    required this.value,
    this.date,
  });

  factory DataItem.fromJson(Map<String, dynamic> json) => DataItem(
        name: json['name'] ?? '',
        value: json['commits'] ?? 0,
        date: DateTime.parse(json['date'] ?? DateTime.now()),
      );
}
