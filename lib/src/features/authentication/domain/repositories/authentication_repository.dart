

import 'package:clean_arch_bloc/cores/util/typedef.dart';
import 'package:clean_arch_bloc/src/features/authentication/domain/entities/user_entity.dart';

import '../../../../../cores/infrastructure/either.dart';

abstract class AuthenticationRepository {
  FutureResult<UserEntity> login(
      {required String mail, required String password});
}
