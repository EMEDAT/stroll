import 'package:equatable/equatable.dart';

/// User Entity - Domain model for user data
class User extends Equatable {
  final String id;
  final String name;
  final int age;
  final String profileImageUrl;
  final bool isOnline;

  const User({
    required this.id,
    required this.name,
    required this.age,
    required this.profileImageUrl,
    required this.isOnline,
  });

  User copyWith({
    String? id,
    String? name,
    int? age,
    String? profileImageUrl,
    bool? isOnline,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  @override
  List<Object?> get props => [id, name, age, profileImageUrl, isOnline];

  @override
  String toString() {
    return 'User(id: $id, name: $name, age: $age, profileImageUrl: $profileImageUrl, isOnline: $isOnline)';
  }
}