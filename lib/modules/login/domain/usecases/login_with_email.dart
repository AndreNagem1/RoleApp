import 'package:rolesp/modules/login/domain/entities/logged_user.dart';
import 'package:rolesp/modules/login/domain/entities/login_credential.dart';
import 'package:dartz/dartz.dart';
import 'package:rolesp/modules/login/domain/errors/errors.dart';

abstract class LoginWithEmail {
  Future<Either<Failure, LoggedUser>> call(LoginCredential loginCredential);
}

class LoginWithEmailImpl implements LoginWithEmail{
  @override
  Future<Either<Failure, LoggedUser>> call(LoginCredential loginCredential) async {

    throw UnimplementedError();
  }

}
