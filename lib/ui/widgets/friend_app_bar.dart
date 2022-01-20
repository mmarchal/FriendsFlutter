import 'package:flutter/material.dart';

class FriendAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? username;
  const FriendAppBar({Key? key, this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: false,
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.exit_to_app),
        color: Colors.black,
      ),
      title: Text(
        username ?? "Bonjour",
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
