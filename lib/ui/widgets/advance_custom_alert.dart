import 'package:flutter/material.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/error/type_error.dart';

class AdvanceCustomAlert<T> extends StatefulWidget {
  final APIResponse<T> response;

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
                  const Text(
                    "Erreur",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    _errorMesssage(widget.response.type),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Recommencer",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            const Positioned(
                top: -60,
                child: CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  radius: 60,
                  child: Icon(
                    Icons.assistant_photo,
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
        return "${widget.response.error?.content} ! Contactez l'administrateur !";
    }
  }
}
