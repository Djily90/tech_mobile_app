import 'dart:convert';


List<Tickets> postFromJson(String str) =>
    List<Tickets>.from(json.decode(str).map((x) => Tickets.fromMap(x)));

class Tickets {
  Tickets({
    required this.id,
    required this.name,
    required this.date,
  });

  int id;
  String name;
  String date;

  factory Tickets.fromMap(Map<String, dynamic> json) => Tickets(
        id: json["id"],
        name: json["name"],
        date: json["date"],
      );
}
