import 'dart:convert';

class FirebaseMessage {
  final String from;
  final String to;
  final String text;
  final String? imageUrl;
  final String dateString;

  FirebaseMessage(
      {required this.from,
      required this.to,
      required this.text,
      this.imageUrl,
      required this.dateString});

  factory FirebaseMessage.fromMap(Object? object) {
    var map = jsonDecode(jsonEncode(object));
    return FirebaseMessage(
      from: map['from'],
      to: map['to'],
      text: map['text'],
      imageUrl: map['imageUrl'],
      dateString: map['dateString'],
    );
  }
}
