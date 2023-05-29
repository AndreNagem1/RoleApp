import 'package:json_annotation/json_annotation.dart';
part 'login_credential.g.dart';

@JsonSerializable()
class LoginCredential {
  final String email;
  final String password;
  final String phone;
  final String code;
  final String verificationId;

  LoginCredential({
    required this.email,
    required this.password,
    required this.phone,
    required this.code,
    required this.verificationId,
  });
}
