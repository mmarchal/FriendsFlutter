import 'package:flutter/material.dart';
import 'package:life_friends/model/api/back/api_back.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/error/type_error.dart';
import 'package:life_friends/notifier/token_notifier.dart';
import 'package:provider/provider.dart';

class AdvanceCustomAlert extends StatefulWidget {
  final APIResponse<ApiBack> response;

  const AdvanceCustomAlert({Key? key, required this.response})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AdvanceCustomAlert();
  }
}

class _AdvanceCustomAlert extends State<AdvanceCustomAlert> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    (widget.response.isSuccess)
                        ? "Connexion réussi !"
                        : "Connexion refusé",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    (widget.response.isSuccess)
                        ? "Bienvenue ${widget.response.data!.result.username} !"
                        : "Erreur : ${_errorMesssage(widget.response.type)}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (widget.response.isSuccess) {
                        Provider.of<TokenNotifier>(context, listen: false)
                            .setToken(widget.response.data!.result);
                        Navigator.pushNamed(context, '/home');
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      (widget.response.isSuccess)
                          ? "Entrer dans l'application"
                          : "Recommencer",
                      style: const TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
                top: -60,
                child: CircleAvatar(
                  backgroundColor: (widget.response.isSuccess)
                      ? Colors.greenAccent
                      : Colors.redAccent,
                  radius: 60,
                  child: Icon(
                    (widget.response.isSuccess)
                        ? Icons.check
                        : Icons.assistant_photo,
                    color: Colors.white,
                    size: 50,
                  ),
                )),
          ],
        ));
  }

  String _errorMesssage(FriendTypeError? type) {
    switch (type) {
      case FriendTypeError.unauthorized:
        return "Connexion non autorisé ! Vérifiez votre identifiant / mot de passe !";
      case FriendTypeError.noInternet:
        return "Vous n'êtes pas connecté à Internet ! Vérifiez votre connexion !";
      case FriendTypeError.notFound:
        return "Non trouvé ! Contactez l'administrateur !";
      default:
        return "Erreur inconnu ! Contactez l'administrateur !";
    }
  }
}
