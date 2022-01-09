import 'package:flutter/material.dart';
import 'package:life_friends/model/api/back/api_back.dart';
import 'package:life_friends/model/api/api_response.dart';

class AdvanceCustomAlert extends StatelessWidget {
  final APIResponse<ApiBack> response;

  const AdvanceCustomAlert({Key? key, required this.response})
      : super(key: key);

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
                      (response.isSuccess)
                          ? "Connexion réussi !"
                          : "Connexion refusé",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      (response.isSuccess)
                          ? "Bienvenue ${response.data!.result.username} !"
                          : "Erreur : ${response.type}",
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (response.isSuccess) {
                          //todo
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        (response.isSuccess)
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
                  backgroundColor: (response.isSuccess)
                      ? Colors.greenAccent
                      : Colors.redAccent,
                  radius: 60,
                  child: Icon(
                    (response.isSuccess) ? Icons.check : Icons.assistant_photo,
                    color: Colors.white,
                    size: 50,
                  ),
                )),
          ],
        ));
  }
}
