import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/api/back/api_back.dart';
import 'package:life_friends/model/friend.dart';
import 'package:life_friends/notifier/friend/friend_notifier.dart';
import 'package:life_friends/notifier/token_notifier.dart';
import 'package:life_friends/service/api.repository.dart';
import 'package:life_friends/service/friend.repository.dart';
import 'package:life_friends/ui/utils/style.dart';
import 'package:life_friends/ui/widgets/advance_custom_alert.dart';
import 'package:life_friends/ui/widgets/loading_widget.dart';
import 'package:life_friends/ui/widgets/login_right_text.dart';
import 'package:life_friends/ui/widgets/login_text.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  //TODO Switch pour changer le host : prod(kimsufi) ou dev(raspberry)
  //TODO Vérifier le mot de passe oublié (mail ok ou pas / test)
  final TextEditingController _user = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ApiRepository apiRepository = ApiRepository(context.read(), context.read());
    FriendRepository friendRepository =
        FriendRepository(context.read(), context.read());
    final FriendNotifier friendNotifier =
        Provider.of<FriendNotifier>(context, listen: false);
    final TokenNotifier tokenNotifier =
        Provider.of<TokenNotifier>(context, listen: false);
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
            height: MediaQuery.of(context).size.height / 1.75,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 62),
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(20),
                  child: LoginText(
                      controller: _user,
                      icon: Icons.person,
                      hint: 'Identifiant'),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: LoginText(
                      controller: _pass,
                      icon: Icons.vpn_key,
                      isPassword: true,
                      hint: 'Mot de passe'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          child: Row(
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
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          child: const Text(
                            'Mot de passe oublié ?',
                            style: TextStyle(color: Colors.grey),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/forgot');
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: ElevatedButton(
                      onPressed: () {
                        /*
                        Compte de tests :
                        - firebaseTest (123456)
                        - firebaseMessage (abcdef)
                        */
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const LoadingWidget(
                                  label: "Connexion en cours");
                            });
                        apiRepository
                            .login(login: _user.text, password: _pass.text)
                            .then((value) async {
                          APIResponse<ApiBack> retour = value;
                          if (retour.isSuccess && retour.data != null) {
                            APIResponse<Friend> friend = await friendRepository
                                .loadConnectedFriend(retour.data?.result);
                            friendNotifier.setFriend(friend.data);
                            tokenNotifier.setToken(retour.data?.result);
                            firebaseLogin(
                              context: context,
                              email: friend.data!.email,
                            );
                          } else {
                            Navigator.pop(context);
                            showDialog(
                                context: context,
                                builder: (_) =>
                                    AdvanceCustomAlert(response: retour));
                          }
                        });
                      },
                      child: Center(
                        child: Text(
                          'Login'.toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  void firebaseLogin({
    required BuildContext context,
    required String email,
  }) async {
    var _auth = context.read<FirebaseAuth>();
    try {
      await _auth.signInWithEmailAndPassword(
          email: email, password: _pass.text);
      Navigator.pop(context);
      Navigator.pushNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      AwesomeDialog(
              context: context,
              dialogType: DialogType.ERROR,
              animType: AnimType.RIGHSLIDE,
              headerAnimationLoop: false,
              title: "Erreur",
              desc: e.message,
              btnOkOnPress: () {},
              btnOkIcon: Icons.cancel,
              btnOkColor: Colors.red)
          .show();
    }
  }
}
