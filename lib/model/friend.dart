import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';
import 'package:life_friends/ui/utils/uint8_list_converter.dart';

part 'friend.g.dart';

@JsonSerializable(explicitToJson: true)
class Friend {
  final int? id;
  final String prenom;
  final String login;
  final String password;
  final String email;
  final String? profileImage;
  final bool? mdpProvisoire;
  final String? codeMdp;
  final DateTime? dateExpiration;

  Friend(
      {this.id,
      required this.prenom,
      required this.login,
      required this.email,
      this.profileImage,
      required this.password,
      this.mdpProvisoire,
      this.codeMdp,
      this.dateExpiration});

  factory Friend.fromJson(Map<String, dynamic> json) => _$FriendFromJson(json);

  Map<String, dynamic> toJson() => _$FriendToJson(this);
}
