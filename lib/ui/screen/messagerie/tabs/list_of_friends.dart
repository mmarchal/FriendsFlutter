import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:life_friends/model/firebase/firebase_user.dart';
import 'package:life_friends/ui/screen/messagerie/chat_controller.dart';
import 'package:provider/provider.dart';

class ListOfFriends extends StatelessWidget {
  const ListOfFriends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String uid = context.read<FirebaseAuth>().currentUser?.uid ?? "";
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: FirebaseAnimatedList(
        query: FirebaseDatabase.instance.ref().child("users"),
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          FirebaseUser user = FirebaseUser.fromMap(snapshot.value);
          if (user.uid == uid) {
            // C'est nous
            return Container();
          } else {
            return InkWell(
              child: Card(
                elevation: 10,
                child: ListTile(
                  title: Text(user.prenom),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatController(
                      id: uid,
                      partenaire: user,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
