import 'package:bloc_firebase_login/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum CredentialType {
  GOOGLE,
  FACEBOOK
}

class UserRepository {
  FirebaseUser user;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> authenticate({
    @required String username,
    @required String password
  }) async {
    await Future.delayed(Duration(seconds: 1));
    return 'Token';
  }

  Future<UserModel> authenticateWithCredentials({
    @required CredentialType credentialType
  }) async {
    AuthCredential credential;
    user = await _auth.currentUser();

    if (credentialType == CredentialType.GOOGLE) {
      if (user == null) {
        credential = await authenticatedWithGoogle();
      }
    } 

    if(user == null) {
      user = await _auth.signInWithCredential(credential);
    }

    return UserModel(
      token: user.uid,
      userName: ''
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
}