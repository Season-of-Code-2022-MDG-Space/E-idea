// ignore: file_names
import 'package:assignment/model/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthenticationProvider {
  final FirebaseAuth firebaseAuth;
  //FirebaseAuth instance
  AuthenticationProvider(this.firebaseAuth);
  //Constuctor to initalize the FirebaseAuth instance

  //Using Stream to listen to Authentication State
  Stream<User?> get authState => firebaseAuth.idTokenChanges();

  //SIGN UP METHOD
  Future<String?> signUpUser(String email, String password, String name,
      String enrollment, String branch, String batch) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      final _auth = FirebaseAuth.instance;
      User? user = _auth.currentUser;

      usermodel userModel = usermodel();

      userModel.email = user!.email;
      userModel.uid = user.uid;
      userModel.name = name;
      userModel.enrollment = enrollment;
      userModel.branch = branch;
      userModel.batch = batch;

      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .set(userModel.toMap());
      Fluttertoast.showToast(msg: "Account created successfully :) ");

      /*Navigator.pushAndRemoveUntil(
          (context),
          MaterialPageRoute(builder: (context) => const homepage()),
          (route) => false);*/
      return "Signed up!";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN IN METHOD
  Future<String?> loginUser(
      {required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed in!";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

/*class CurrentUser extends ChangeNotifier {
  late String _uid;
  late String _email;

  String get getUid => _uid;
  String get getEmail => _email;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> onstartup() async {
    String retVal = 'error';
    try {
      User user = await _auth.currentUser!;
      _uid = user.uid;
      _email = user.email!;
      retVal = 'success';
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<bool> signUpUser(String email, String password) async {
    bool retVal = false;

    try {
      debugPrint(email);
      User? user = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password))
          .user;

      if (user != null) {
        retVal = true;
      }
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<bool> loginUser(String email, String password) async {
    bool retVal = false;
    try {
      User? user = (await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: email.trim(), password: password))
          .user;

      if (user != null) {
        _uid = user.uid;
        _email = user.email!;
        retVal = true;
      }
    } catch (e) {
      print(e);
    }
    return retVal;
  }
}*/
}
