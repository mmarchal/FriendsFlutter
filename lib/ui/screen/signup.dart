import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/firebase/firebase_helper.dart';
import 'package:life_friends/model/friend.dart';
import 'package:life_friends/service/api.repository.dart';
import 'package:life_friends/ui/screen/login_head_screen.dart';
import 'package:life_friends/ui/widgets/button_login.dart';
import 'package:life_friends/ui/widgets/loading_widget.dart';
import 'package:life_friends/ui/widgets/login_text.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _prenom = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _mail = TextEditingController();

  _errorDialog(String desc) {
    AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.RIGHSLIDE,
            headerAnimationLoop: false,
            title: "Erreur",
            desc: desc,
            btnOkOnPress: () {},
            btnOkIcon: Icons.cancel,
            btnOkColor: Colors.red)
        .show();
  }

  _checkMandatoryValue() {
    String contentError = "";
    if (_prenom.text == '' || _password.text == '' || _mail.text == '') {
      contentError =
          'Des champs sont vides ! Il faut remplir l\'ensemble des champs !';
    }

    if (contentError == '') {
      if (_mail.text.contains('@') && _password.text.length >= 6) {
        showDialog(
            context: context,
            builder: (_) =>
                const LoadingWidget(label: 'Création de compte en cours'));
        _creationCompte(context);
      } else if (_password.text.length < 6) {
        _errorDialog("Le mot de passe doit faire au moins 6 caractères !");
      } else {
        _errorDialog("Le format de l'adresse mail est incorrect !");
      }
    } else {
      _errorDialog(contentError);
    }
  }

  void _creationCompte(BuildContext buildContext) async {
    String prenom = _prenom.text;
    String password = _password.text;
    String email = _mail.text;
    User? createdUser = await FirebaseHelper().registerWithEmailAndPassword(
        email: email, password: password, name: prenom);
    if (createdUser != null) {
      APIResponse<Friend> api =
          await ApiRepository(context.read(), context.read()).insertFriend(
        uid: createdUser.uid,
        prenom: prenom,
        password: password,
        email: email,
      );
      if (api.isSuccess) {
        Map<String, String> map = {
          "uid": createdUser.uid,
          "prenom": prenom,
          "email": email,
        };
        FirebaseHelper().addUser(
          createdUser.uid,
          map,
        );
        Navigator.popUntil(context, (route) => route.isFirst);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "Compte $prenom créé ! Vous pouvez vous connectez à l'application !"),
          ),
        );
      }
    } else {
      Navigator.pop(context);
      _errorDialog("Problème de création de compte ! Contactez l'admin !");
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoginHeadScreen(
      value: "Compte",
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            LoginText(
              controller: _prenom,
              icon: Icons.people,
              hint: 'Prénom',
            ),
            LoginText(
              controller: _mail,
              icon: Icons.mail,
              hint: 'Email',
            ),
            LoginText(
              controller: _password,
              icon: Icons.password,
              isPassword: true,
              hint: 'Mot de passe',
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: ButtonLogin(
                  onTap: () {
                    _checkMandatoryValue();
                  },
                  title: 'Créer un compte'),
            ),
          ],
        ),
      ),
    );
  }
}
