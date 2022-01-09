import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:life_friends/service/api.repository.dart';
import 'package:life_friends/ui/utils/style.dart';
import 'package:life_friends/ui/widgets/loading_widget.dart';
import 'package:life_friends/ui/widgets/login_right_text.dart';
import 'package:life_friends/ui/widgets/sign_textfield.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _prenom = TextEditingController();
  final TextEditingController _login = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _mail = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _creationCompte() {
    String prenom = _prenom.text;
    String login = _login.text;
    String password = _password.text;
    String email = _mail.text;
    ApiRepository()
        .insertFriend(
            prenom: prenom, login: login, password: password, email: email)
        .then((value) {
      if (value.isSuccess && value.data!) {
        Navigator.pop(context);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "Compte $prenom créé ! Vous pouvez vous connectez à l'application !"),
        ));
      } else if (!value.hasInternet) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              "Vous n'êtes pas connecté à Internet ! Vérifiez votre connexion !"),
        ));
      } else {
        return AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.RIGHSLIDE,
            headerAnimationLoop: false,
            title: value.error!.title,
            desc: value.error!.content,
            btnOkOnPress: () {},
            btnOkIcon: Icons.cancel,
            btnOkColor: Colors.red)
          ..show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3.5,
            decoration: Style().boxDeco,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Spacer(),
                Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.person,
                    size: 90,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                LoginRightText(
                  title: "Compte",
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 62),
            child: Column(
              children: <Widget>[
                SignTextField(
                  title: "Prénom",
                  controller: _prenom,
                ),
                Style().espace,
                SignTextField(
                  title: "Login",
                  controller: _login,
                ),
                Style().espace,
                SignTextField(
                  title: "Mot de passe",
                  controller: _password,
                ),
                Style().espace,
                SignTextField(title: "Email", controller: _mail),
                Style().espace,
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) => const LoadingWidget(
                            label: 'Création de compte en cours'));
                    _creationCompte();
                  },
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width / 1.2,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff6bceff),
                            Color(0xFF00abff),
                          ],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Center(
                      child: Text(
                        'Créer un compte'.toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
