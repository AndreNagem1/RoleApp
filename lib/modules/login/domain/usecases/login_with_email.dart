import 'package:dartz/dartz.dart';
import 'package:rolesp/modules/login/domain/entities/logged_user.dart';
import 'package:rolesp/modules/login/domain/entities/login_credential.dart';
import 'package:rolesp/modules/login/domain/errors/errors.dart';
import 'package:rolesp/modules/login/domain/repository/login_repository.dart';

abstract class LoginWithEmail {
  Future<Either<Failure, LoggedUser>> call(LoginCredential loginCredential);
}

class LoginWithEmailImpl implements LoginWithEmail {
  final LoginRepository repository;

  LoginWithEmailImpl({required this.repository});

  @override
  Future<Either<Failure, LoggedUser>> call(
      LoginCredential loginCredential) async {
    if (!loginCredential.isValidEmail) {
      return Left(ErrorLoginEmail(message: 'Email inválido'));
    }

    if (!loginCredential.isValidPassword) {
      return Left(ErrorLoginEmail(
          message: 'Senha inválida, ela deve possuir ao menos 3 caractéres'));
    }

    return repository.loginEmail(
      email: loginCredential.email ?? '',
      password: loginCredential.password ?? '',
    );
  }
}
