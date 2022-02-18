import 'package:flutter/material.dart';
import 'package:life_friends/ui/screen/profil/widgets/profil_picture.dart';

class FriendAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? username;
  final String? picture;
  const FriendAppBar({Key? key, this.username, this.picture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: false,
      leading: ProfilPicture(
        profileImage: picture,
      ),
      title: Text(
        username ?? "Bonjour",
        style: const TextStyle(color: Colors.black),
      ),
      actions: [
        IconButton(
            onPressed: () => Navigator.pushNamed(context, '/profil'),
            icon: const Icon(
              Icons.person,
              color: Colors.black,
            ))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
