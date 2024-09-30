import 'package:clean_arch_bloc/src/features/authentication/domain/entities/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel extends UserEntity {
  const UserModel({
    super.id,
    super.email,
    super.firstName,
    super.lastName,
    super.photo,
    super.role,
    super.password,
    super.accessToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
