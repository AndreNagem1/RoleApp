import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rolesp/modules/login/domain/entities/login_credential.dart';
import 'package:rolesp/modules/login/domain/usecases/login_with_email.dart';

main() {
  final usecase = LoginWithEmailImpl();

  test('deve retornar LoggedUser', () {
    final LoginCredential credentialMocked = LoginCredential(
      email: "email",
      password: "",
      phone: "phone",
      code: "code",
      verificationId: "verificationId",);

    final result = usecase(credentialMocked);

    expect(result, isA<Right>);
   // expect(result, matcher)
  });
}
