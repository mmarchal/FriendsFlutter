import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/password.dart';
import 'package:life_friends/service/api.repository.dart';
import 'package:life_friends/ui/screen/login_head_screen.dart';
import 'package:life_friends/ui/widgets/button_login.dart';
import 'package:life_friends/ui/widgets/loading_widget.dart';
import 'package:life_friends/ui/widgets/sign_textfield.dart';
import 'package:provider/src/provider.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ForgotPassScreenState();
  }
}

class ForgotPassScreenState extends State<ForgotPassScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController reinitController = TextEditingController();
  TextEditingController newPassController = TextEditingController();

  bool isVisible = false;

  String codeString = "Code de réinitialisation reçu";

  _forgotPassword(BuildContext context) async {
    ApiRepository apiRepository = ApiRepository(context.read(), context.read());
    APIResponse<bool> response =
        await apiRepository.getForgotPassword(usernameController.text);
    if (response.isSuccess) {
      Navigator.pop(context);
      if (response.data!) {
        CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            title: "Mot de passe réinitialisé",
            text:
                "Consultez vos mails pour obtenir votre code de réinitialisation");
      } else {
        CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            title: "Erreur",
            text: "Contactez votre admin !");
      }
    } else {
      Navigator.pop(context);
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: "Erreur",
          text: "Contactez votre admin !");
    }
  }

  _reinitPassWithCode(BuildContext context) async {
    ApiRepository apiRepository = ApiRepository(context.read(), context.read());
    APIResponse<bool> response = await apiRepository.checkingTempPassword(
        usernameController.text, reinitController.text);
    if (response.isSuccess) {
      Navigator.pop(context);
      if (response.data!) {
        CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            title: "Autorisation accordé !",
            widget: Container(
              margin: const EdgeInsets.only(top: 20),
              width: 200,
              child: SignTextField(
                title: "Nouveau mot de passe",
                controller: newPassController,
              ),
            ),
            onConfirmBtnTap: () {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (BuildContext buildContext) {
                    return const LoadingWidget(
                        label: "Mise à jour du mot de passe");
                  });
              _reinitPass(context);
            },
            text:
                "(Vous avez 10 minutes)\nVeuillez renseigner votre nouveau mot de passe : ");
      } else {
        CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            title: "Erreur",
            text: "Contactez votre admin !");
      }
    } else {
      Navigator.pop(context);
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: "Erreur",
          text: "Contactez votre admin !");
    }
  }

  _reinitPass(BuildContext context) async {
    ApiRepository apiRepository = ApiRepository(context.read(), context.read());
    Password password = Password(
        userLogin: usernameController.text,
        token: reinitController.text,
        newPassword: newPassController.text);
    APIResponse<bool> response = await apiRepository.resetPassword(password);
    if (response.isSuccess) {
      Navigator.pop(context);
      if (response.data!) {
        CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            title: "Mot de passe modifié avec succés !",
            onConfirmBtnTap: () {
              Navigator.pushNamed(context, '/');
            },
            text: "Vous allez être redirigé vers la page de login !");
      } else {
        CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            title: "Erreur",
            text: "Contactez votre admin !");
      }
    } else {
      Navigator.pop(context);
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: "Erreur",
          text: "Contactez votre admin !");
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoginHeadScreen(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SignTextField(
              title: "Nom d'utilisateur",
              controller: usernameController,
            ),
            Visibility(
              child: SignTextField(
                title: "Code de réinitialisation",
                controller: reinitController,
              ),
              visible: isVisible,
            ),
            ButtonLogin(
                onTap: () {
                  setState(() {
                    isVisible = !isVisible;
                    (isVisible)
                        ? codeString = "Code de réinitialisation non reçu"
                        : codeString = "Code de réinitialisation reçu";
                  });
                },
                title: codeString),
            ButtonLogin(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext buildContext) {
                        return LoadingWidget(
                            label: (isVisible)
                                ? "Vérification du code ..."
                                : "Envoie du mail en cours ...");
                      });
                  if (isVisible) {
                    _reinitPassWithCode(context);
                  } else {
                    _forgotPassword(context);
                  }
                },
                title: "Valider"),
          ],
        ),
        value: "Mot de passe oublié");
  }
}
