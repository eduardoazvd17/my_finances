import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String password;
  final String? photoUrl;
  final String? _nickname;

  String get nickname => _nickname ?? name.split(' ').first;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.photoUrl,
    String? nickname,
  }) : _nickname = nickname;

  UserModel editAndCopy({
    String? name,
    String? password,
    required String? photoUrl,
    required String? nickname,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email,
      password: password ?? this.password,
      photoUrl: photoUrl,
      nickname: nickname,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'photoUrl': photoUrl,
      'nickname': _nickname,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      photoUrl: map['photoUrl'],
      nickname: map['nickname'],
    );
  }

  @override
  List<Object?> get props => [id];
}
