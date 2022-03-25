import 'package:json_annotation/json_annotation.dart';

part 'friend.g.dart';

@JsonSerializable(explicitToJson: true)
class Friend {
  final String uid;
  final String prenom;
  final String password;
  final String email;
  final String? profileImage;
  final bool? mdpProvisoire;
  final String? codeMdp;
  final DateTime? dateExpiration;

  Friend({
    required this.uid,
    required this.prenom,
    required this.email,
    this.profileImage,
    required this.password,
    this.mdpProvisoire,
    this.codeMdp,
    this.dateExpiration,
  });

  factory Friend.fromJson(Map<String, dynamic> json) => _$FriendFromJson(json);

  Map<String, dynamic> toJson() => _$FriendToJson(this);
}
