// ignore_for_file: implementation_imports

import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/password.dart';
import 'package:life_friends/service/api.repository.dart';
import 'package:life_friends/ui/screen/login_head_screen.dart';
import 'package:life_friends/ui/widgets/button_login.dart';
import 'package:life_friends/ui/widgets/loading_widget.dart';
import 'package:life_friends/ui/widgets/sign_textfield.dart';
import 'package:provider/src/provider.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ForgotPassScreenState();
  }
}

class ForgotPassScreenState extends State<ForgotPassScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController reinitController = TextEditingController();
  TextEditingController newPassController = TextEditingController();

  bool isVisible = false;

  String codeString = "Code de réinitialisation reçu";

  @override
  Widget build(BuildContext context) {
    return LoginHeadScreen(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SignTextField(
              title: "Adresse mail",
              controller: usernameController,
            ),
            ButtonLogin(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext buildContext) {
                        return const LoadingWidget(
                            label: "Envoie du mail en cours ...");
                      });
                  FirebaseAuth.instance
                      .sendPasswordResetEmail(email: usernameController.text)
                      .then((_) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text("Lien de réinitiatlisation envoyé par mail !"),
                      ),
                    );
                  });
                },
                title: "Valider"),
          ],
        ),
        value: "Mot de passe oublié");
  }
}
