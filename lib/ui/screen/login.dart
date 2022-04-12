import 'package:flutter/material.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/api/back/api_back.dart';
import 'package:life_friends/model/error/api_error.dart';
import 'package:life_friends/model/error/type_error.dart';
import 'package:life_friends/model/friend.dart';
import 'package:life_friends/notifier/friend/friend_notifier.dart';
import 'package:life_friends/service/api.repository.dart';
import 'package:life_friends/ui/utils/style.dart';
import 'package:life_friends/ui/widgets/advance_custom_alert.dart';
import 'package:life_friends/ui/widgets/loading_widget.dart';
import 'package:life_friends/ui/widgets/login_right_text.dart';
import 'package:life_friends/ui/widgets/login_text.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _user = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FriendNotifier friendNotifier =
        Provider.of<FriendNotifier>(context, listen: false);
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
                      hint: 'Adresse mail'),
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
                      onPressed: () async {
                        final apiRepo = ApiRepository(
                          context.read(),
                          context.read(),
                        );
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const LoadingWidget(
                                label: "Connexion en cours",
                              );
                            });
                        try {
                          APIResponse<ApiBack> response = await apiRepo.login(
                            login: _user.text,
                            password: _pass.text,
                          );
                          if (response.isSuccess) {
                            APIResponse<Friend> resp = await apiRepo.getFriend(
                              id: response.data!.result.userId,
                              token: response.data!.result.token,
                            );
                            if (resp.isSuccess) {
                              Friend friend = Friend(
                                uid: resp.data!.uid,
                                prenom: resp.data!.prenom,
                                email: _user.text,
                                password: _pass.text,
                                login: _user.text,
                              );
                              friendNotifier.setFriend(friend);
                              Navigator.pushNamed(context, '/home');
                            } else {
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder: (_) => AdvanceCustomAlert(
                                  response: APIResponse(
                                    type: FriendTypeError.notFound,
                                  ),
                                ),
                              );
                            }
                          } else {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (_) => AdvanceCustomAlert(
                                response: APIResponse(
                                  type: FriendTypeError.notFound,
                                ),
                              ),
                            );
                          }
                        } on Exception catch (e) {
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (_) => AdvanceCustomAlert(
                              response: APIResponse(
                                error: APIError(
                                  systemMessage: "Login",
                                  title: "Erreur",
                                  content: e.toString(),
                                ),
                              ),
                            ),
                          );
                        }
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
