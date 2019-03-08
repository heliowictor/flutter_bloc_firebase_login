import 'package:bloc/bloc.dart';
import 'package:bloc_firebase_login/bloc/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => LoginState.initial();

  @override
  Stream<LoginState> mapEventToState(
    LoginState currentState, 
    LoginEvent event
  ) async* {
    FirebaseUser user;

    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    
    switch (event) {
      case LoginEvent.loginWithGoogle:
        try {
          final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
          final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

          final AuthCredential credential =GoogleAuthProvider.getCredential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken
          );

          user = await _auth.signInWithCredential(credential);
          yield LoginState.success(user.uid);
        } catch (error) {
          print(error);
          yield LoginState.failure(error);
        }
        break;
    }
  }
}