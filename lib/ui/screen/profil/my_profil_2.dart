import 'package:flutter/material.dart';
import 'package:life_friends/model/friend.dart';
import 'package:life_friends/notifier/friend/friend_notifier.dart';
import 'package:life_friends/ui/utils/hexcolor.dart';
import 'package:life_friends/ui/widgets/copper_text.dart';
import 'package:provider/src/provider.dart';
import 'package:random_string/random_string.dart';

// ignore: must_be_immutable
class MyProfilV2 extends StatelessWidget {
  MyProfilV2({Key? key}) : super(key: key);

  TextEditingController mailController = TextEditingController();
  TextEditingController loginController = TextEditingController();
  TextEditingController nameController = TextEditingController();

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
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          child: Card(
            color: HexColor("#dff5e9"),
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    color: HexColor("#134287"),
                    padding: const EdgeInsets.all(8.0),
                    child: CopperPlateText(
                      label: "FRIEND",
                      color: Colors.white,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CopperPlateText(
                        label: "Ami : Important", color: Colors.black),
                    CopperPlateText(
                        label: "Code : ${randomAlphaNumeric(10)}",
                        color: Colors.black)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Container(
                        width: 120,
                        height: 120,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        //TODO image à stocker et modifiable
                        child: Image.network(
                          'https://picsum.photos/seed/220/600',
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CopperPlateText(
                          label: "Prénom : ${friend?.prenom}",
                          color: Colors.black,
                        ),
                        CopperPlateText(
                          label: "Adresse mail : ${friend?.email}",
                          color: Colors.black,
                        ),
                        CopperPlateText(
                          label: "Identifiant : ${friend?.login}",
                          color: Colors.black,
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    padding: const EdgeInsets.all(8.0),
                    child: CopperPlateText(
                      label: "FRIEND",
                      color: Colors.black,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
