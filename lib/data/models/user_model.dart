class UserModel {
  final String accessToken;
  final String tokenType;
  final String expiresIn;

  UserModel({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      expiresIn: json['expires_in'],
    );
  }
}
