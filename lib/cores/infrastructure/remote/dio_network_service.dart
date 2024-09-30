import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import '../response.dart' as response;
import '../either.dart';
import '../exceptions/exception_handler_mixin.dart';
import '../exceptions/http_exception.dart';
import 'network_service.dart';

class DioNetworkService extends NetworkService with ExceptionHandlerMixin {
  final Dio dio;
  Duration DEFAULT_TIMEOUT = const Duration(seconds: 30);

  DioNetworkService(this.dio) {
    dio.options = dioBaseOptions;
  }

  BaseOptions get dioBaseOptions {
    return BaseOptions(
      baseUrl: AppConfigs.baseUrl,
      headers: {
        'accept': 'application/json',
        'content-type': 'application/json',
      },
        connectTimeout: Duration(seconds: 30),
        sendTimeout: Duration(seconds: 30),
        receiveTimeout: Duration(seconds: 30),
    );
  }

  @override
  String get baseUrl => AppConfigs.baseUrl;

  @override
  Map<String, Object> get headers => {
        'accept': 'application/json',
        'content-type': 'application/json',
      };

  Future<String?> getAccessToken() async {
    final box = await Hive.openBox('currentUser');
    final token = box.get('token', defaultValue: null);
    return token;
  }

  @override
  Future<Map<String, dynamic>?> updateHeader(Map<String, dynamic> data) async {
    final accessToken = await getAccessToken();

    Map<String, dynamic> headers = {
      ...this.headers,
      ...data,
    };

    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    } else {
      headers.remove('Authorization');
    }

    dio.options.headers = headers;

    return headers;
  }

  @override
  Future<Either<AppException, response.Response>> post(String endpoint,
      {Map<String, dynamic>? data}) async {
    final headers = await updateHeader({});

    final res = handleException(
      () async {
        return dio.post(
          endpoint,
          data: data,
          options: Options(
            headers: headers,
          ),
        );
      },
      endpoint: endpoint,
    );

    return res;
  }

  @override
  Future<Either<AppException, response.Response>> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    final headers = await updateHeader({});
    final res = handleException(
      () => dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      ),
      endpoint: endpoint,
    );
    return res;
  }

  @override
  Future<Either<AppException, response.Response>> patch(String endpoint,
      {FormData? data, Map<String, dynamic>? otherData}) async {
    final headers = await updateHeader({});
    final res = handleException(
      () => dio.patch(
        endpoint,
        data: data ?? otherData,
        options: Options(
          headers: headers,
        ),
      ),
      endpoint: endpoint,
    );
    return res;
  }

  @override
  Future<Either<AppException, response.Response>> delete(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    final headers = await updateHeader({});
    final res = handleException(
      () => dio.delete(
        endpoint,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      ),
      endpoint: endpoint,
    );
    return res;
  }

  @override
  Future<Either<AppException, response.Response>> put(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    final headers = await updateHeader({});
    final res = handleException(
      () => dio.put(
        endpoint,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      ),
      endpoint: endpoint,
    );
    return res;
  }

  void closeBox() {
    Hive.close();
  }
}

class AppConfigs {
  static String baseUrl = 'http://192.168.1.24:3000';
}
