import 'dart:convert';

class FirebaseUser {
  final String uid;
  final String prenom;

  FirebaseUser({required this.uid, required this.prenom});

  factory FirebaseUser.fromMap(Object? object) {
    var map = jsonDecode(jsonEncode(object));
    return FirebaseUser(
      uid: map['uid'],
      prenom: map['prenom'],
    );
  }
}
