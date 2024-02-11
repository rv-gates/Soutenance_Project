import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  final String email, firstName, lastName, matricule, role;

  const User({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.matricule,
    required this.role,
  });

  Map<String, dynamic> toJson() => _$UserToJson(this);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

/*User copyWith({
    String? email,
    String? firstName,
    String? matricule,
    String? lastName,
    String? photoUrl,
  }) =>
      User(
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        matricule: matricule ?? this.lastName,
      );*/
}

@JsonSerializable(explicitToJson: true)
class UserCreated extends User {
  final String id;

  const UserCreated(
      {required this.id,
      required super.email,
      required super.firstName,
      required super.lastName,
      required super.matricule,
      required super.role});

  Map<String, dynamic> toJson() => _$UserCreatedToJson(this);

  factory UserCreated.fromJson(Map<String, dynamic> json) =>
      _$UserCreatedFromJson(json);
/*@override
  UserCreated copyWith(
      {String? email,
      String? firstName,
      String? matricule,
      String? lastName,
      String? photoUrl}) {
    // TODO: implement copyWith
    return UserCreated(
      uid: uid,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      matricule: matricule ?? this.lastName,
    );
  }*/
}
