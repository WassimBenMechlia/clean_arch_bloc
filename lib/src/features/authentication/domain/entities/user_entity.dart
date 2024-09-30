import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'user_entity.g.dart';

@HiveType(typeId: 1)
class UserEntity extends Equatable {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? firstName;
  @HiveField(2)
  final String? lastName;
  @HiveField(3)
  final String? email;
  @HiveField(4)
  final String? photo;
  @HiveField(5)
  final String? role;
  @HiveField(6)
  final String? password;
  @HiveField(7)
  final String? accessToken;

  const UserEntity({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.photo,
    this.role,
    this.password,
    this.accessToken,
  });

  const UserEntity.empty()
      : this(
            accessToken: 'token',
            id: '1',
            email: 'mail@example.com',
            firstName: 'John',
            lastName: 'doe',
            photo: 'photo',
            role: 'user',
            password: 'password123');

  @override
  List<Object?> get props => [
        id,
        password,
        email,
        firstName,
        lastName,
        photo,
        role,
        accessToken,
      ];
}
