import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:life_friends/model/firebase/firebase_helper.dart';

import 'package:life_friends/model/firebase/firebase_user.dart';

class ZoneDeTexteWidget extends StatefulWidget {
  final FirebaseUser partenaire;
  final String id;

  const ZoneDeTexteWidget(
      {Key? key, required this.partenaire, required this.id})
      : super(key: key);

  @override
  ZoneState createState() => ZoneState();
}

class ZoneState extends State<ZoneDeTexteWidget> {
  final TextEditingController _textEditingController = TextEditingController();
  late FirebaseUser moi;

  @override
  void initState() {
    super.initState();
    FirebaseHelper().getUser(widget.id).then((user) {
      setState(() {
        moi = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
          IconButton(
              icon: const Icon(Icons.camera_enhance),
              onPressed: () => takePicture(ImageSource.camera)),
          IconButton(
              icon: const Icon(Icons.photo_library),
              onPressed: () => takePicture(ImageSource.gallery)),
          Flexible(
              child: TextField(
            controller: _textEditingController,
            decoration: const InputDecoration.collapsed(
                hintText: "Ecrivez quelque chose"),
            maxLines: null,
          )),
          IconButton(
              icon: const Icon(Icons.send), onPressed: _sendButtonPressed)
        ],
      ),
    );
  }

  _sendButtonPressed() {
    if (_textEditingController.text != "") {
      String text = _textEditingController.text;
      FirebaseHelper()
          .sendMessage(user: widget.partenaire, moi: moi, text: text);
      _textEditingController.clear();
      FocusScope.of(context).requestFocus(FocusNode());
    } else {
      throw "Texte vide ou null";
    }
  }

  Future<void> takePicture(ImageSource source) async {
    // ignore: invalid_use_of_visible_for_testing_member
    PickedFile? file = await ImagePicker.platform
        .pickImage(source: source, maxWidth: 1000.0, maxHeight: 1000.0);
    String date = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseHelper()
        .savePicture(
            file, FirebaseHelper().storageMessages.child(widget.id).child(date))
        .then((string) {
      FirebaseHelper()
          .sendMessage(user: widget.partenaire, moi: moi, text: string);
    });
  }
}
