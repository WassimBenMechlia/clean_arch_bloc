import 'package:clean_arch_bloc/cores/util/typedef.dart';
import 'package:clean_arch_bloc/cores/util/use_case/use_case.dart';
import 'package:clean_arch_bloc/src/features/authentication/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';


import '../repositories/authentication_repository.dart';

class LoginUseCase extends UseCaseWithParams<UserEntity, CustomAuthParams> {
  LoginUseCase(this._authenticationRepository);
  final AuthenticationRepository _authenticationRepository;

  @override
  FutureResult<UserEntity> call(CustomAuthParams params) {
    return _authenticationRepository.login(
        mail: params.mail, password: params.password);
  }
}

class CustomAuthParams extends Equatable {
  final String mail;
  final String password;

  const CustomAuthParams({required this.mail, required this.password});

  @override
  List<Object?> get props => [mail, password];
}
