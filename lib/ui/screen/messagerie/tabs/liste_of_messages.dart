import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:life_friends/model/firebase/firebase_conversation.dart';
import 'package:life_friends/model/firebase/firebase_helper.dart';
import 'package:life_friends/ui/screen/messagerie/chat_controller.dart';
import 'package:provider/provider.dart';

class ListOfMessages extends StatelessWidget {
  const ListOfMessages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String uid = context.read<FirebaseAuth>().currentUser?.uid ?? "";
    return FirebaseAnimatedList(
      padding: const EdgeInsets.only(top: 20),
      query: FirebaseHelper().baseConversation.child(uid),
      itemBuilder: (BuildContext context, DataSnapshot snapshot,
          Animation<double> animation, int index) {
        FirebaseConversation conversation =
            FirebaseConversation.fromMap(snapshot.value);
        String subtitle = (conversation.id == uid) ? "Moi: " : "";
        subtitle += conversation.lastMessage ?? "";
        return ListTile(
          title: Text(conversation.user?.prenom ?? ""),
          subtitle: Text(subtitle),
          trailing: Text(conversation.date),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatController(
                  id: uid,
                  partenaire: conversation.user!,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
