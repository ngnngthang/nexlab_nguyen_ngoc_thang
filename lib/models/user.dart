import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.phone,
    this.email,
    this.image,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String username;
  final String phone;
  final String? email;
  final String? image;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return 'User{id: $id, firstName: $firstName, lastName: $lastName, username: $username, phone: $phone, email: $email, image: $image}';
  }
}
