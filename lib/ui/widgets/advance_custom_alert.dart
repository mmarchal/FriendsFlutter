import 'package:flutter/material.dart';
import 'package:life_friends/model/api/back/api_back.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/notifier/token_notifier.dart';
import 'package:life_friends/service/api.repository.dart';
import 'package:life_friends/ui/screen/home.dart';
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
            SizedBox(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                  children: [
                    Text(
                      (widget.response.isSuccess)
                          ? "Connexion réussi !"
                          : "Connexion refusé",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      (widget.response.isSuccess)
                          ? "Bienvenue ${widget.response.data!.result.username} !"
                          : "Erreur : ${widget.response.type}",
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (widget.response.isSuccess) {
                          Provider.of<TokenNotifier>(context, listen: false)
                              .setToken(widget.response.data!.result);
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return const HomeScreen();
                          }));
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
}
