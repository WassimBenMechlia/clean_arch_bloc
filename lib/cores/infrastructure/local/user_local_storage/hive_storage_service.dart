import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../../../src/features/authentication/domain/entities/user_entity.dart';

class AuthLocalDataSource {
  UserEntity? currentUser;
  String? token;

  Future initialize() async {
    await getCurrentUser();
  }

  Future getCurrentUser() async {
    var box = await Hive.openBox('currentUser');
    currentUser = box.get('user', defaultValue: null);
    print("aaaaaaaaaaaaaa${currentUser}");

    token = box.get('token', defaultValue: null);
  }

  Future setToken(String? token) async {
    var box = await Hive.openBox('currentUser');
    await box.put('token', token);
    this.token = token;
  }

  Future setCurrentUser(UserEntity user) async {
    var box = await Hive.openBox('currentUser');
    box.put('user', user);
    currentUser = user;
    print("aaaaaaaaaaaaaa${user}");
  }

  Future logout() async {
    var box = await Hive.openBox('currentUser');
    await box.clear();
    currentUser = null;
    token = null;
  }

  Future<bool> isLoggedIn() async {
    var box = await Hive.openBox('currentUser');
    currentUser = box.get('user', defaultValue: null);
    token = box.get('token', defaultValue: null);
    return currentUser != null && token != null;
  }
}

final storageServiceProvider = Provider((ref) {
  final AuthLocalDataSource storageService = AuthLocalDataSource();

  return storageService;
});
