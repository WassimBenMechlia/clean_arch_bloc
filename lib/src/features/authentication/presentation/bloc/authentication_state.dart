part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  final UserEntity? userEntity;
  final AppException? appException;
  const AuthenticationState({this.appException, this.userEntity});

  @override
  List<Object> get props => [userEntity!, appException!];
}

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading();
}

class AuthenticationSuccess extends AuthenticationState {
  const AuthenticationSuccess(UserEntity userEntity)
      : super(userEntity: userEntity);
}

class AuthenticationFailure extends AuthenticationState {
  const AuthenticationFailure(AppException appException)
      : super(appException: appException);
}

class Authenticated extends AuthenticationState {
  const Authenticated(UserEntity userEntity) : super(userEntity: userEntity);
}

class UnAuthenticated extends AuthenticationState {
  const UnAuthenticated();
}
