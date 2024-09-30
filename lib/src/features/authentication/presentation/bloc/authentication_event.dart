part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class LogInEvent extends AuthenticationEvent {
  final String mail;
  final String password;

  const LogInEvent({required this.mail, required this.password});
  @override
  List<Object> get props => [mail, password];
}

class CheckUserLoggedInEvent extends AuthenticationEvent {
  final UserEntity? userEntity;

  const CheckUserLoggedInEvent({this.userEntity});

  @override
  List<Object> get props => [userEntity ?? Object];
}
