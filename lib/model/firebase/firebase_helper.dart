import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:life_friends/model/firebase/firebase_user.dart';

class FirebaseHelper {
  // Authentification

  final auth = FirebaseAuth.instance;

  Future<bool> handleLogOut() async {
    await auth.signOut();
    return true;
  }

  Future<String> myId() async {
    User? user = auth.currentUser;
    return user?.uid ?? "";
  }

  //Database

  static final base = FirebaseDatabase.instance.ref();
  final base_user = base.child("users");
  final base_message = base.child("messages");
  final base_conversation = base.child("conversations");

  addUser(String uid, Map map) {
    base_user.child(uid).set(map);
  }

  Future<FirebaseUser> getUser(String id) async {
    DatabaseEvent snapshot = await base_user.child(id).once();
    return FirebaseUser.fromMap(snapshot.snapshot.value);
  }

  sendMessage(User user, User moi, String text, String imageUrl) {
    String date = DateTime.now().millisecondsSinceEpoch.toString();
    Map map = {
      "from": moi.uid,
      "to": user.uid,
      "text": text,
      "imageUrl": imageUrl,
      "dateString": date
    };
    base_message.child(getMessageRef(moi.uid, user.uid)).child(date).set(map);
    base_conversation
        .child(moi.uid)
        .child(user.uid)
        .set(getConversation(moi.uid, user, text, date));
    base_conversation
        .child(user.uid)
        .child(moi.uid)
        .set(getConversation(moi.uid, moi, text, date));
  }

  Map getConversation(
      String sender, User user, String text, String dateString) {
    print(user.toString());
    Map map = {};
    map["monId"] = sender;
    map["last_message"] = text;
    map["dateString"] = dateString;
    return map;
  }

  String getMessageRef(String from, String to) {
    String resultat = "";
    List<String> liste = [from, to];
    liste.sort((a, b) => a.compareTo(b));
    for (var x in liste) {
      resultat += x + "+";
    }
    return resultat;
  }

  //Storage
  static final base_storage = FirebaseStorage.instance.ref();
  final Reference storage_users = base_storage.child("users");
  final Reference storage_messages = base_storage.child("messages");

  Future<String> savePicture(
      PickedFile? file, Reference storageReference) async {
    UploadTask storageUploadTask = storageReference.putFile(File(file!.path));
    TaskSnapshot snapshot = storageUploadTask.snapshot;
    String url = await snapshot.ref.getDownloadURL();
    return url;
  }
}
