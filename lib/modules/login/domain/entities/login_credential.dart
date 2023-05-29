import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:string_validator/string_validator.dart' as validator;

part 'login_credential.g.dart';

@JsonSerializable()
class LoginCredential {
  String? email;
  String? password;
  String? phone;
  String? code;
  String? verificationId;

  LoginCredential(
      {this.email, this.password, this.phone, this.code, this.verificationId});

  bool get isValidEmail => validator.isEmail(email ?? "");

  bool get isValidPassword =>
      password != null &&
      password?.isNotEmpty == true &&
      password?.length.isGreaterThan(3) == true;

  bool get isValidPhone =>
      phone != null &&
      phone?.isNotEmpty == true &&
      phone?.length.isGreaterThan(13) == true;

  bool get isValidCode => code != null && code?.isNotEmpty == true;

  bool get isValidVerificationId =>
      verificationId != null && verificationId?.isNotEmpty == true;

  factory LoginCredential.withEmailAndPassword(
      {required String email, required String password}) {
    return LoginCredential(email: email, password: password);
  }

  factory LoginCredential.withPhone({required String phone}) {
    return LoginCredential(phone: phone);
  }

  factory LoginCredential.withVerificationCode(
      {required String code, required String verificationId}) {
    return LoginCredential(
      code: code,
      verificationId: verificationId,
    );
  }
}
