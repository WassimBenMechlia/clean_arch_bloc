

import 'package:clean_arch_bloc/cores/infrastructure/either.dart';
import 'package:clean_arch_bloc/cores/infrastructure/exceptions/http_exception.dart';

typedef FutureResult<T> = Future<Either<AppException, T>>;

typedef VoidResult = FutureResult<void>;
