import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:life_friends/model/firebase/firebase_user.dart';
import 'package:life_friends/ui/screen/messagerie/chat_controller.dart';
import 'package:provider/provider.dart';

class ListOfFriends extends StatefulWidget {
  const ListOfFriends({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ListOfFriendsState();
  }
}

class ListOfFriendsState extends State<ListOfFriends> {
  @override
  Widget build(BuildContext context) {
    String uid = context.read<FirebaseAuth>().currentUser?.uid ?? "";
    return StreamBuilder(
      stream: FirebaseDatabase.instance.ref().child("users").onValue,
      builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
        if (snapshot.hasData) {
          Map map = snapshot.data!.snapshot.value as Map;
          List<FirebaseUser> list = [];
          for (var element in map.values) {
            FirebaseUser firebaseUser = FirebaseUser.fromMap(element);
            if (firebaseUser.uid != uid) list.add(firebaseUser);
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: list.length,
            padding: const EdgeInsets.all(2.0),
            itemBuilder: (BuildContext context, int index) {
              FirebaseUser user = list[index];
              return GestureDetector(
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
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    height: 150,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          gradient: LinearGradient(
                              colors: [
                                Colors.black,
                                Color(0x19000000),
                              ],
                              begin: FractionalOffset(0.0, 1.0),
                              end: FractionalOffset(0.0, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        child: Center(
                          child: Text(
                            user.prenom,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
