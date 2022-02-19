import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/friend.dart';
import 'package:life_friends/model/proposition.dart';
import 'package:life_friends/model/type_proposition.dart';
import 'package:life_friends/notifier/friend/friend_notifier.dart';
import 'package:life_friends/notifier/typeproposition/typeproposition_list_notifier.dart';
import 'package:life_friends/service/proposition.repository.dart';
import 'package:life_friends/ui/widgets/button_login.dart';
import 'package:life_friends/ui/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

class AllFieldsFormBloc extends FormBloc<String, String> {
  TextFieldBloc nomFriend = TextFieldBloc();

  final titreDemande = TextFieldBloc();

  final typeDemande = SelectFieldBloc<TypeProposition, dynamic>(
    items: [],
  );

  final contenuDemande = TextFieldBloc();

  AllFieldsFormBloc() {
    addFieldBlocs(
        fieldBlocs: [nomFriend, titreDemande, typeDemande, contenuDemande]);
  }

  @override
  void onSubmitting() {}
}

class AllFieldsForm extends StatefulWidget {
  const AllFieldsForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AllFieldsForm();
  }
}

class _AllFieldsForm extends State<AllFieldsForm> {
  double value = 0.0;
  @override
  Widget build(BuildContext context) {
    Friend? friend = context.watch<FriendNotifier>().friend;
    List<TypeProposition>? typePropositions =
        context.watch<TypePropositionListNotifier>().listeTypes;
    return BlocProvider(
      create: (context) => AllFieldsFormBloc(),
      child: Builder(
        builder: (context) {
          final formBloc = BlocProvider.of<AllFieldsFormBloc>(context);
          formBloc.nomFriend.updateInitialValue(friend?.prenom);
          if (typePropositions != null) {
            formBloc.typeDemande.updateItems(typePropositions);
          }
          return Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: FormBlocListener<AllFieldsFormBloc, String, String>(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      TextFieldBlocBuilder(
                        readOnly: true,
                        textFieldBloc: formBloc.nomFriend,
                        decoration: const InputDecoration(
                          labelText: 'Votre nom',
                          prefixIcon: Icon(Icons.text_fields),
                        ),
                      ),
                      (typePropositions != null)
                          ? RadioButtonGroupFieldBlocBuilder<TypeProposition>(
                              selectFieldBloc: formBloc.typeDemande,
                              decoration: const InputDecoration(
                                labelText: 'Type de demande',
                                prefixIcon: SizedBox(),
                              ),
                              itemBuilder: (context, item) => item.type,
                            )
                          : const CircularProgressIndicator(),
                      TextFieldBlocBuilder(
                        textFieldBloc: formBloc.contenuDemande,
                        minLines: 2,
                        maxLines: 10,
                        decoration: const InputDecoration(
                          labelText: 'Votre demande',
                          prefixIcon: Icon(Icons.text_fields),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ButtonLogin(
                          title: "Envoyer ma proposition",
                          onTap: () async {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const LoadingWidget(
                                      label: "Connexion en cours");
                                });
                            Proposition p = Proposition(
                                nom: formBloc.nomFriend.value!,
                                typeProposition: formBloc.typeDemande.value!,
                                dateProposition: DateTime.now(),
                                demande: formBloc.contenuDemande.value!);
                            APIResponse<bool> api =
                                await Provider.of<PropositionRepository>(
                                        context,
                                        listen: false)
                                    .addProposition(p);
                            if (api.isSuccess && api.data!) {
                              Navigator.pop(context);
                              await CoolAlert.show(
                                context: context,
                                type: CoolAlertType.success,
                                text: 'Proposition envoyé !',
                              );
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/home', (route) => false);
                            } else {
                              Navigator.pop(context);
                              await CoolAlert.show(
                                context: context,
                                type: CoolAlertType.error,
                                onConfirmBtnTap: () => Navigator.pop(context),
                                text:
                                    'Erreur rencontré : ${api.error?.content} !',
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key? key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => LoadingDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(12.0),
            child: const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.tag_faces, size: 100),
            const SizedBox(height: 10),
            const Text(
              'Success',
              style: TextStyle(fontSize: 54, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const AllFieldsForm())),
              icon: const Icon(Icons.replay),
              label: const Text('AGAIN'),
            ),
          ],
        ),
      ),
    );
  }
}
