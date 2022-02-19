import 'package:flutter/material.dart';
import 'package:life_friends/env/constants.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/api/back/api_back.dart';
import 'package:life_friends/model/friend.dart';
import 'package:life_friends/notifier/friend/friend_notifier.dart';
import 'package:life_friends/notifier/token_notifier.dart';
import 'package:life_friends/service/api.repository.dart';
import 'package:life_friends/service/friend.repository.dart';
import 'package:life_friends/ui/utils/style.dart';
import 'package:life_friends/ui/widgets/advance_custom_alert.dart';
import 'package:life_friends/ui/widgets/copper_text.dart';
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
  final TextEditingController _user = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String domain = context.read<TokenNotifier>().domain ?? devDomain;
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CopperPlateText(label: "Dev", color: Colors.red),
                    Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          //true = prod -- false = dev
                          isSwitched = value;
                          Provider.of<TokenNotifier>(context, listen: false)
                              .setEnvironment((value) ? prodDomain : devDomain);
                        });
                      },
                      activeColor: Colors.green,
                      inactiveTrackColor: Colors.red,
                    ),
                    CopperPlateText(label: "Prod", color: Colors.green),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: LoginText(
                      controller: _user,
                      icon: Icons.person,
                      hint: 'Identifiant'),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
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
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const LoadingWidget(
                                  label: "Connexion en cours");
                            });
                        Provider.of<ApiRepository>(context, listen: false)
                            .login(login: _user.text, password: _pass.text)
                            .then((value) async {
                          Navigator.pop(context);
                          APIResponse<ApiBack> retour = value;
                          if (retour.isSuccess && retour.data != null) {
                            APIResponse<Friend> friend =
                                await Provider.of<FriendRepository>(context,
                                        listen: false)
                                    .loadConnectedFriend(retour.data?.result);
                            friendNotifier.setFriend(friend.data);
                            tokenNotifier.setToken(retour.data?.result);
                            Provider.of<TokenNotifier>(context, listen: false)
                                .setToken(retour.data!.result);
                            Navigator.pushNamed(context, '/home');
                          } else {
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
}
