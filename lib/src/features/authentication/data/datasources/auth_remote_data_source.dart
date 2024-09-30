
import 'package:clean_arch_bloc/src/features/authentication/data/models/user_model.dart';

import '../../../../../cores/infrastructure/either.dart';
import '../../../../../cores/infrastructure/exceptions/http_exception.dart';
import '../../../../../cores/infrastructure/remote/network_service.dart';
import '../../../../../cores/util/typedef.dart';

abstract class AuthenticationDataSource {
  FutureResult<UserModel> login(
      {required String mail, required String password});
}

class AuthenticationRemoteDataSource implements AuthenticationDataSource {
  final NetworkService networkService;
  AuthenticationRemoteDataSource(this.networkService);

  @override
  FutureResult<UserModel> login(
      {required String mail, required String password}) async {
    try {
      UserModel user = UserModel(email: mail, password: password);
      final eitherType = await networkService.post(
        '/api/auth/login',
        data: user.toJson(),
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          final user = UserModel.fromJson(response.data);
          networkService.updateHeader(
            {'Authorization': '${user.accessToken}'},
          );
          return Right(user);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          message: 'Unknown error occurred',
          statusCode: 1,
          identifier: '${e.toString()}\ngetCarRemoteDataSource.getCar',
        ),
      );
    }
  }
}
