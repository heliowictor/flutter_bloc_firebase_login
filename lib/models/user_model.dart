class UserModel {
  final String token;
  final String userName;

  UserModel({
    this.token,
    this.userName
  });

  factory UserModel.logIn(String token, String username) => UserModel(token: token, userName: username);
}
