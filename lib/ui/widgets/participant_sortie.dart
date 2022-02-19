import 'package:flutter/material.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/friend.dart';
import 'package:life_friends/notifier/friend/friend_list_notifier.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class ParticipantSortie extends StatelessWidget {
  final List<int> listeIdParticipants;

  const ParticipantSortie({Key? key, required this.listeIdParticipants})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    APIResponse<List<Friend>?>? friends =
        context.watch<FriendListNotifier>().listeFriends;
    if (friends != null && friends.isSuccess) {
      if (friends.data != null && friends.data!.isNotEmpty) {
        return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 4,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: friends.data!.length,
            itemBuilder: (BuildContext ctx, index) {
              Friend friend = friends.data![index];
              return Container(
                alignment: Alignment.center,
                child: Text(friend.prenom),
                decoration: BoxDecoration(
                    color: (listeIdParticipants.contains(friend.id))
                        ? Colors.green
                        : Colors.red,
                    borderRadius: BorderRadius.circular(15)),
              );
            });
      } else {
        return const Center(
          child: Text("Aucun participant n'a été trouvé !"),
        );
      }
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}
