import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rolesp/modules/login/domain/entities/logged_user.dart';
import 'package:rolesp/modules/login/domain/entities/login_credential.dart';
import 'package:rolesp/modules/login/domain/errors/errors.dart';
import 'package:rolesp/modules/login/domain/repository/login_repository.dart';
import 'package:rolesp/modules/login/domain/usecases/login_with_email.dart';

class FakeLoginRepository extends Fake implements LoginRepository {
  @override
  Future<Either<Failure, LoggedUser>> loginEmail(
      {required String email, required String password}) async {
    const loggedUserFake =
        LoggedUser(email: 'email', name: 'andre', number: '123');
    return Future.value(const Right(loggedUserFake));
  }
}

class FakeLoginWithEmailImpl extends Fake implements LoginWithEmail {
  final FakeLoginRepository repository;

  FakeLoginWithEmailImpl({required this.repository});

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

main() {
  late FakeLoginRepository repository;
  late FakeLoginWithEmailImpl usecase;

  setUp(() {
    repository = FakeLoginRepository();
    usecase = FakeLoginWithEmailImpl(repository: repository);
  });

  test('should verify if email is not valid', () async {
    var result = await usecase(
        LoginCredential.withEmailAndPassword(email: '', password: ''));

    expect(result.leftMap((l) => l is ErrorLoginEmail), const Left(true));
  });

  test('should verify if password is not valid', () async {
    var result = await usecase(LoginCredential.withEmailAndPassword(
        email: 'andre@gmail.com', password: '123'));

    expect(result.leftMap((l) => l is ErrorLoginEmail), const Left(true));
  });

  test('should consume repository and return LoggedUser', () async {
    const user = LoggedUser(email: 'email', name: 'andre', number: '123');

    final result = await usecase.call(LoginCredential.withEmailAndPassword(
        email: 'andre@gmail.com', password: '1234'));

    expect(result, const Right(user));
  });
}
