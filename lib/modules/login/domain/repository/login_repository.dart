import 'package:rolesp/modules/login/domain/entities/logged_user.dart';
import 'package:rolesp/modules/login/domain/errors/errors.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoggedUser>> loginEmail(
      {required String email, required String password});

  Future<Either<Failure, LoggedUser>> loginPhone(
      {required String phone, required String password});
}
