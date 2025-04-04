class UserModel {
  final int empID;
  final String email;
  final bool success;
  final String message;

  UserModel({
    required this.empID,
    required this.email,
    required this.success,
    required this.message,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      empID: json['empID'],
      email: json['email'],
      success: json['success'],
      message: json['message'],
    );
  }
}
