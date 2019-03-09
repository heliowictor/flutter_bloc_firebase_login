import 'package:bloc_firebase_login/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum AuthenticationType { GOOGLE, FACEBOOK }

class UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  Future<UserModel> currentUser() async {
    FirebaseUser user = await _auth.currentUser();
    if (user != null) {
      return UserModel(
        token: user.uid,
        userName: user.displayName
      );
    }

    return null;
  }

  Future<String> authenticate({
    @required String username,
    @required String password
  }) async {
    await Future.delayed(Duration(seconds: 1));
    return 'Token';
  }

  Future<UserModel> authenticateWithCredentials({
    @required AuthenticationType authenticationType
  }) async {
    AuthCredential credential;
    UserModel userModel = await currentUser();
    FirebaseUser firebaseUser;

    if (authenticationType == AuthenticationType.GOOGLE) {
      if (userModel == null) {
        credential = await authenticatedWithGoogle();
      }
    } 

    if(userModel == null) {
      firebaseUser = await _auth.signInWithCredential(credential);
    }

    return UserModel(
      token: firebaseUser.uid,
      userName: firebaseUser.displayName
    );
  }

  Future<AuthCredential> authenticatedWithGoogle() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn();
      GoogleSignInAccount googleUser = _googleSignIn.currentUser;

      if (googleUser == null) 
        googleUser = await _googleSignIn.signInSilently();
      if (googleUser == null) 
        googleUser = await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      return GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
      );
    } catch (error) {
      print('Error: $error)');
      throw error;
    }
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}
