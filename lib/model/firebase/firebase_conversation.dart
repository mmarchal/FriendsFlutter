import 'dart:convert';

import 'package:life_friends/model/firebase/firebase_user.dart';

class FirebaseConversation {
  final String id;
  final String? lastMessage;
  final String date;
  final FirebaseUser? user;

  FirebaseConversation({
    required this.id,
    this.lastMessage,
    required this.date,
    this.user,
  });

  factory FirebaseConversation.fromMap(Object? object) {
    var map = jsonDecode(jsonEncode(object));
    return FirebaseConversation(
      id: map['monId'],
      lastMessage: map['last_message'],
      date: map['dateString'],
      user: FirebaseUser(
        uid: map['uid'],
        prenom: map['prenom'],
      ),
    );
  }
}
