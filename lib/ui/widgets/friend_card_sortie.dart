import 'package:flutter/material.dart';

class FriendCardSortie extends StatelessWidget {
  final String title;
  final String subTitle;
  final Icon icon;

  const FriendCardSortie(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: const Color(0xFF424B5E),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          icon,
          Expanded(
            child: ListTile(
              title: Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
              subtitle:
                  Text(subTitle, style: const TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}
