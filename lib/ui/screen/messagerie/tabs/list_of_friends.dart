import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:life_friends/ui/utils/firebase_helper.dart';
import 'package:life_friends/ui/widgets/custom_image.dart';

class ListOfFriends extends StatelessWidget {
  const ListOfFriends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirebaseAnimatedList(
      query: FirebaseHelper().base_user,
      sort: (a, b) => a.value["prenom"].compareTo(b.value["prenom"]),
      itemBuilder: (BuildContext context, DataSnapshot snapshot,
          Animation<double> animation, int index) {
        User newUser = User(snapshot);
        if (newUser.id == widget.id) {
          return Container();
        } else {
          // C'est pas nous
          return ListTile(
            leading: CustomImage(
              imageUrl: newUser.imageUrl,
              initiales: newUser.initiales,
              radius: 20.0,
            ),
            title: Text("${newUser.prenom}  ${newUser.nom}"),
            trailing: IconButton(
              icon: const Icon(Icons.message),
              onPressed: () {},
            ),
          );
        }
      },
    );
  }
}
