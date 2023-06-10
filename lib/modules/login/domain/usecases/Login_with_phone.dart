import 'package:rolesp/modules/login/domain/entities/logged_user.dart';
import 'package:rolesp/modules/login/domain/entities/login_credential.dart';
import 'package:rolesp/modules/login/domain/errors/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:rolesp/modules/login/domain/repository/login_repository.dart';

abstract class LoginWithPhone {
  Future<Either<Failure, LoggedUser>> call(LoginCredential loginCredential);
}

class LoginWithPhoneImpl implements LoginWithPhone {
  final LoginRepository repository;

  LoginWithPhoneImpl({required this.repository});

  @override
  Future<Either<Failure, LoggedUser>> call(
      LoginCredential loginCredential) async {
    if (!loginCredential.isValidPhone) {
      return Left(ErrorLoginPhone(message: 'Telefone inválido'));
    }

    if (!loginCredential.isValidPassword) {
      return Left(ErrorLoginPhone(message: 'Senha inválido'));
    }

    return repository.loginPhone(
        phone: loginCredential.phone ?? "",
        password: loginCredential.password ?? "");
  }
}
