import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rolesp/modules/login/domain/entities/login_credential.dart';
import 'package:rolesp/modules/login/domain/errors/errors.dart';
import 'package:rolesp/modules/login/domain/usecases/login_with_email.dart';

main() {
  final usecase = LoginWithEmailImpl();

  test('should verify if email is not valid', () async {
    var result = await usecase(
        LoginCredential.withEmailAndPassword(email: '', password: ''));

    expect(result.leftMap((l) => l is ErrorLoginEmail), const Left(true));
  });
}
