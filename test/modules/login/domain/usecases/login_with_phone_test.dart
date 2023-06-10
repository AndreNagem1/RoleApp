import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rolesp/modules/login/domain/entities/logged_user.dart';
import 'package:rolesp/modules/login/domain/entities/login_credential.dart';
import 'package:rolesp/modules/login/domain/errors/errors.dart';
import 'package:rolesp/modules/login/domain/repository/login_repository.dart';
import 'package:rolesp/modules/login/domain/usecases/Login_with_phone.dart';

class LoginRepositoryFake extends Fake implements LoginRepository {
  @override
  Future<Either<Failure, LoggedUser>> loginPhone(
      {required String phone, required String password}) {
    const loggedUserFake =
        LoggedUser(email: 'andre@gmail.com', name: 'andre', number: '123');
    return Future.value(const Right(loggedUserFake));
  }
}

class LoginWithPhoneFake extends Fake implements LoginWithPhone {
  final LoginRepository repository;

  LoginWithPhoneFake({required this.repository});

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

main() {
  late LoginRepositoryFake repository;
  late LoginWithPhoneFake useCase;

  setUp(() {
    repository = LoginRepositoryFake();
    useCase = LoginWithPhoneFake(repository: repository);
  });

  test('should return LoggedUser with correct phone and password', () async {
    var credential =
        LoginCredential.withPhone(phone: '011123456789', password: '1234');
    var result = await useCase(credential);

    expect(
      result,
      const Right(
        LoggedUser(email: 'andre@gmail.com', name: 'andre', number: '123'),
      ),
    );
  });

  test('should return error when when number is less then 11 numbers',
      () async {
    var credential =
        LoginCredential.withPhone(phone: '123456789', password: '1234');
    var result = await useCase(credential);

    expect(result.leftMap((l) => l is ErrorLoginPhone), const Left(true));
  });

  test('should return error when when password is less then 3 numbers',
      () async {
    var credential =
        LoginCredential.withPhone(phone: '011123456789', password: '12');
    var result = await useCase(credential);

    expect(result.leftMap((l) => l is ErrorLoginPhone), const Left(true));
  });
}
