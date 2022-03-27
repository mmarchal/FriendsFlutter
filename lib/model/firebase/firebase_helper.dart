import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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

  Future<User?> registerWithEmailAndPassword(
      {required String name,
      required String password,
      required String email}) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null) {
        user.updateDisplayName(name);
        return user;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<User?> login(String username, String password) async {
    final UserCredential result = await auth.signInWithEmailAndPassword(
        email: username, password: password);
    return result.user;
  }

  //Database

  static final base = FirebaseDatabase.instance.ref();
  final baseUser = base.child("users");
  final baseMessage = base.child("messages");
  final baseConversation = base.child("conversations");

  addUser(String uid, Map map) {
    baseUser.child(uid).set(map);
  }

  Future<FirebaseUser> getUser(String id) async {
    DatabaseEvent snapshot = await baseUser.child(id).once();
    return FirebaseUser.fromMap(snapshot.snapshot.value);
  }

  sendMessage(
      {required FirebaseUser user,
      required FirebaseUser moi,
      required String text,
      String? imageUrl}) {
    String date = DateFormat("dd-MM-yyyy HH:mm:ss").format(DateTime.now());
    Map map = {
      "from": moi.uid,
      "to": user.uid,
      "text": text,
      "imageUrl": imageUrl,
      "dateString": date
    };
    baseMessage.child(getMessageRef(moi.uid, user.uid)).child(date).set(map);
    baseConversation
        .child(moi.uid)
        .child(user.uid)
        .set(getConversation(moi.uid, user, text, date));
    baseConversation
        .child(user.uid)
        .child(moi.uid)
        .set(getConversation(moi.uid, moi, text, date));
  }

  Map getConversation(
      String sender, FirebaseUser user, String text, String dateString) {
    Map map = user.toMap();
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
  static final baseStorage =
      FirebaseStorage.instance.refFromURL('gs://friendchat-4626f.appspot.com');
  final Reference storageUsers = baseStorage.child("users");
  final Reference storageMessages = baseStorage.child("messages");

  Future<String> savePicture(
      PickedFile? file, Reference storageReference) async {
    UploadTask storageUploadTask = storageReference.putFile(File(file!.path));
    TaskSnapshot snapshot = storageUploadTask.snapshot;
    String url = await snapshot.ref.getDownloadURL();
    return url;
  }
}
