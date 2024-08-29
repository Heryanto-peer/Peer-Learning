import 'dart:convert';

class GroupModel {
  final String? groupId;
  final String? classId;
  final dynamic chatId;
  final String? groupName;
  final int? totalPoin;

  GroupModel({
    this.groupId,
    this.classId,
    this.chatId,
    this.groupName,
    this.totalPoin,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
        groupId: json['group_id'],
        classId: json['class_id'],
        chatId: json['chat_id'],
        groupName: json['group_name'],
        totalPoin: json['total_poin'],
      );

  factory GroupModel.fromRawJson(String str) => GroupModel.fromJson(json.decode(str));

  GroupModel copyWith({
    String? groupId,
    String? classId,
    dynamic chatId,
    String? groupName,
    int? totalPoin,
  }) =>
      GroupModel(
        groupId: groupId ?? this.groupId,
        classId: classId ?? this.classId,
        chatId: chatId ?? this.chatId,
        groupName: groupName ?? this.groupName,
        totalPoin: totalPoin ?? this.totalPoin,
      );

  Map<String, dynamic> toJson() => {
        'group_id': groupId,
        'class_id': classId,
        'chat_id': chatId,
        'group_name': groupName,
        'total_poin': totalPoin,
      };

  String toRawJson() => json.encode(toJson());
}
