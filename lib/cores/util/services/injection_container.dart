import 'package:clean_arch_bloc/cores/infrastructure/local/user_local_storage/hive_storage_service.dart';
import 'package:clean_arch_bloc/cores/infrastructure/remote/network_service.dart';
import 'package:clean_arch_bloc/src/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:clean_arch_bloc/src/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:clean_arch_bloc/src/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:clean_arch_bloc/src/features/authentication/domain/usecases/login_use_case.dart';
import 'package:clean_arch_bloc/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';


import '../../infrastructure/remote/dio_network_service.dart';

final sl = GetIt.instance;
Future<void> init() async {
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSource());

  // Register NetworkService with Dio passed to its constructor

  sl
    ..registerFactory(
        () => AuthenticationBloc(loginUseCase: sl(), authLocalDataSource: sl()))
    ..registerLazySingleton(() => LoginUseCase(sl()))
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImpl(sl()))
    ..registerLazySingleton<AuthenticationDataSource>(
        () => AuthenticationRemoteDataSource(sl()))
    ..registerLazySingleton<NetworkService>(() => DioNetworkService(sl<Dio>()));
}
