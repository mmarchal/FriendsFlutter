import 'package:flutter/material.dart';
import 'package:life_friends/model/firebase/firebase_message.dart';
import 'package:life_friends/model/firebase/firebase_user.dart';
import 'package:life_friends/ui/widgets/custom_image.dart';

class ChatBubble extends StatelessWidget {
  final FirebaseMessage message;
  final FirebaseUser partenaire;
  final String monId;
  final Animation<double> animation;

  const ChatBubble({
    Key? key,
    required this.message,
    required this.partenaire,
    required this.monId,
    required this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(parent: animation, curve: Curves.easeIn),
      child: Container(
        margin: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: widgetsBubble(message.from == monId),
        ),
      ),
    );
  }

  List<Widget> widgetsBubble(bool moi) {
    CrossAxisAlignment alignement =
        (moi) ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    Color? bubbleColor = (moi) ? Colors.pink[100] : Colors.blue[400];
    Color? textColor = (moi) ? Colors.black : Colors.grey[200];

    return <Widget>[
      const Padding(padding: EdgeInsets.all(8.0)),
      Expanded(
          child: Column(
        crossAxisAlignment: alignement,
        children: <Widget>[
          Text(message.dateString),
          Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: bubbleColor,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: (!message.text.contains('firebasestorage'))
                  ? Text(
                      message.text,
                      style: TextStyle(
                          color: textColor,
                          fontSize: 15.0,
                          fontStyle: FontStyle.italic),
                    )
                  : CustomImage(imageUrl: message.text),
            ),
          )
        ],
      ))
    ];
  }
}
