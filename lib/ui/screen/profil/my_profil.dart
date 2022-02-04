import 'package:flutter/material.dart';
import 'package:life_friends/model/friend.dart';
import 'package:life_friends/notifier/friend/friend_notifier.dart';
import 'package:provider/src/provider.dart';

// ignore: must_be_immutable
class MyProfil extends StatelessWidget {
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  TextEditingController textController3 = TextEditingController();

  MyProfil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Friend? friend = context.watch<FriendNotifier>().friend;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          'Votre profil',
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
              child: Container(
                width: 120,
                height: 120,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                  'https://picsum.photos/seed/220/600',
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: Text(
                'Adresse mail',
              ),
            ),
            TextFormField(
              controller: textController1,
              obscureText: false,
              decoration: InputDecoration(
                hintText: friend?.email ?? "",
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                ),
              ),
            ),
            const Text(
              'Identifiant',
            ),
            TextFormField(
              controller: textController2,
              obscureText: false,
              decoration: InputDecoration(
                hintText: friend?.login ?? "",
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                ),
              ),
            ),
            const Text(
              'Prénom',
            ),
            TextFormField(
              controller: textController3,
              obscureText: false,
              decoration: InputDecoration(
                hintText: friend?.prenom ?? "",
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  print('Button pressed ...');
                },
                child: const Text('Valider les modifications'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
