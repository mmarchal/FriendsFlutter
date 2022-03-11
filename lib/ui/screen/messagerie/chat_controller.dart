import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:life_friends/model/firebase/firebase_helper.dart';
import 'package:life_friends/model/firebase/firebase_message.dart';
import 'package:life_friends/model/firebase/firebase_user.dart';
import 'package:life_friends/ui/screen/messagerie/widgets/chat_bubble.dart';
import 'package:life_friends/ui/screen/messagerie/widgets/zone_de_texte.dart';

class ChatController extends StatefulWidget {
  final String id;
  final FirebaseUser partenaire;

  const ChatController({
    Key? key,
    required this.id,
    required this.partenaire,
  }) : super(key: key);

  @override
  ChatControllerState createState() => ChatControllerState();
}

class ChatControllerState extends State<ChatController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text(widget.partenaire.prenom)],
        ),
      ),
      body: InkWell(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Column(
          children: <Widget>[
            // Zone de chat
            Flexible(
                child: FirebaseAnimatedList(
                    query: FirebaseHelper().baseMessage.child(FirebaseHelper()
                        .getMessageRef(widget.id, widget.partenaire.uid)),
                    itemBuilder: (BuildContext context, DataSnapshot snapshot,
                        Animation<double> animation, int index) {
                      FirebaseMessage message =
                          FirebaseMessage.fromMap(snapshot.value);
                      return ChatBubble(
                          message: message,
                          partenaire: widget.partenaire,
                          monId: widget.id,
                          animation: animation);
                    })),
            const Divider(
              height: 1.5,
            ),
            ZoneDeTexteWidget(
              id: widget.id,
              partenaire: widget.partenaire,
            ),
          ],
        ),
      ),
    );
  }
}
