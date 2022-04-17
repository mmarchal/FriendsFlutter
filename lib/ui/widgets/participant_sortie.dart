import 'package:flutter/material.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/friend.dart';
import 'package:life_friends/service/friend.repository.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class ParticipantSortie extends StatefulWidget {
  final List<String> listeIdParticipants;

  const ParticipantSortie({
    Key? key,
    required this.listeIdParticipants,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ParticipantSortieState();
  }
}

class ParticipantSortieState extends State<ParticipantSortie> {
  APIResponse<List<Friend>?>? friends;

  @override
  void initState() {
    super.initState();
    getAllFriends(context);
  }

  getAllFriends(BuildContext context) async {
    final response = await context.read<FriendRepository>().getFriends();
    setState(() {
      friends = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (friends != null && friends!.isSuccess) {
      if (friends!.data != null && friends!.data!.isNotEmpty) {
        List<Friend> list = friends!.data!;
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 4,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemCount: list.length,
          itemBuilder: (BuildContext ctx, index) {
            Friend friend = list[index];
            return Container(
              alignment: Alignment.center,
              child: Text(friend.prenom),
              decoration: BoxDecoration(
                  color: (widget.listeIdParticipants.contains(friend.uid))
                      ? Colors.green
                      : Colors.red,
                  borderRadius: BorderRadius.circular(15)),
            );
          },
        );
      } else {
        return const Center(
          child: Text("Aucun participant n'a été trouvé !"),
        );
      }
    } else if (friends?.error != null) {
      return const Center(
        child: Text(
          "Problème lors de la récupération des participants.\nContactez l'administration !",
          textScaleFactor: 1.25,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.white,
          ),
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
