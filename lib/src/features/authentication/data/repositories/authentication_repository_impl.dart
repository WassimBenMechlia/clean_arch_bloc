

import 'package:clean_arch_bloc/cores/util/typedef.dart';
import 'package:clean_arch_bloc/src/features/authentication/domain/entities/user_entity.dart';
import 'package:clean_arch_bloc/src/features/authentication/domain/repositories/authentication_repository.dart';

import '../datasources/auth_remote_data_source.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl(this._authenticationDataSource);
  final AuthenticationDataSource _authenticationDataSource;
  @override
  FutureResult<UserEntity> login(
      {required String mail, required String password}) {
    return _authenticationDataSource.login(mail: mail, password: password);
  }
}
