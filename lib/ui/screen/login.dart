import 'package:flutter/material.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/api/back/api_back.dart';
import 'package:life_friends/service/api.repository.dart';
import 'package:life_friends/ui/utils/style.dart';
import 'package:life_friends/ui/widgets/advance_custom_alert.dart';
import 'package:life_friends/ui/widgets/loading_widget.dart';
import 'package:life_friends/ui/widgets/login_right_text.dart';
import 'package:life_friends/ui/widgets/login_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _user = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  @override
  void initState() {
    super.initState();
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
              children: <Widget>[
                const Spacer(),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                      ),
                    ),
                    child: Image.asset(
                      "asset/friends.jpeg",
                      width: MediaQuery.of(context).size.width / 2.5,
                    ),
                  ),
                ),
                const Spacer(),
                const LoginRightText(
                  title: "Friends",
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
                LoginText(
                    controller: _user, icon: Icons.person, hint: 'Identifiant'),
                const SizedBox(
                  height: 50,
                ),
                LoginText(
                    controller: _pass,
                    icon: Icons.vpn_key,
                    isPassword: true,
                    hint: 'Mot de passe'),
                const Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    child: Padding(
                      padding: EdgeInsets.only(top: 16, right: 32),
                      child: Text(
                        'Mot de passe oublié ?',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    const LoadingWidget(label: "Connexion en cours");
                    ApiRepository()
                        .login(login: _user.text, password: _pass.text)
                        .then((value) {
                      APIResponse<ApiBack> retour = value;
                      showDialog(
                          context: context,
                          builder: (_) => AdvanceCustomAlert(response: retour));
                    });
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
                        'Login'.toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text("Pas de compte ?"),
                Text(
                  " Crée en 1",
                  style: TextStyle(color: Color(0xff6bceff)),
                ),
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, '/signup');
            },
          ),
        ],
      ),
    );
  }
}
