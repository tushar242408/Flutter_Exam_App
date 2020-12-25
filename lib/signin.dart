import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class reg{
  String email, password;
  FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future googlr() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount
          .authentication;


      AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      var result = await auth.signInWithCredential(credential);
      print(result.user.uid);
      return result.user.uid;
    }
  }

  Future singIn(String email, String pass) async {
    try {
      var result =await auth.signInWithEmailAndPassword(email: email, password: pass);
      return result.user.uid;

    } catch (err) {
      print(err.code);
    }

  }

  signout() async {
    var user = await auth.signOut();
    //user.unlink(id);

  }


  Future singup(String email, String pass) async {
    try {
      var result = await auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      print(result.user.uid);
      return result.user.uid;
    } catch (err) {
      print(err.code);
    }
  }
}