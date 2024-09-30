import 'package:bloc/bloc.dart';
import 'package:clean_arch_bloc/cores/infrastructure/exceptions/http_exception.dart';
import 'package:clean_arch_bloc/cores/infrastructure/local/user_local_storage/hive_storage_service.dart';
import 'package:clean_arch_bloc/src/features/authentication/domain/entities/user_entity.dart';
import 'package:clean_arch_bloc/src/features/authentication/domain/usecases/login_use_case.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginUseCase _loginUseCase;
  final AuthLocalDataSource _localDataSource;
  AuthenticationBloc(
      {required LoginUseCase loginUseCase,
      required AuthLocalDataSource authLocalDataSource})
      : _loginUseCase = loginUseCase,
        _localDataSource = authLocalDataSource,
        super(const AuthenticationInitial()) {
    on<LogInEvent>(_logInHandler);
    on<CheckUserLoggedInEvent>(_checkUserLoggedInHandler);
  }

  Future<void> _logInHandler(
    LogInEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const AuthenticationLoading());

    final result = await _loginUseCase(
      CustomAuthParams(mail: event.mail, password: event.password),
    );

    result.fold(
      (failure) => emit(AuthenticationFailure(failure)),
      (user) async {
        emit(AuthenticationSuccess(user));

        await _localDataSource.setCurrentUser(user);
        await _localDataSource.setToken(user.accessToken);
      },
    );
  }

  Future<void> _checkUserLoggedInHandler(
    CheckUserLoggedInEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    await _localDataSource.initialize();
    final userData = _localDataSource.currentUser;
    final userToken = _localDataSource.token;

    await _localDataSource.isLoggedIn()
        ? emit(Authenticated(userData!))
        : emit(const UnAuthenticated());
  }
}
