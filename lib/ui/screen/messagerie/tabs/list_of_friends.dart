import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListOfFriends extends StatelessWidget {
  const ListOfFriends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String uid = context.read<FirebaseAuth>().currentUser?.uid ?? "";
    return FirebaseAnimatedList(
      query: FirebaseDatabase.instance.ref().child("users"),
      itemBuilder: (BuildContext context, DataSnapshot snapshot,
          Animation<double> animation, int index) {
        print(snapshot);
        return Container();
      },
    );
  }
}
