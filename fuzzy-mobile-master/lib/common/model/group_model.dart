import 'dart:convert';

import 'package:fuzzy_mobile_user/common/model/siswa_model.dart';

class GroupModel {
  final String? groupId;
  final String? classId;
  final String? groupName;
  final String? className;
  final int? totalPoin;
  final dynamic chatId;
  final List<SiswaModel>? listStudent;

  GroupModel({
    this.groupId,
    this.classId,
    this.groupName,
    this.className,
    this.totalPoin,
    this.chatId,
    this.listStudent,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
        groupId: json['group_id'],
        classId: json['class_id'],
        groupName: json['group_name'],
        className: json['class_name'],
        totalPoin: json['total_poin'],
        chatId: json['chatID'],
        listStudent: json['list_Student'] == null ? [] : List<SiswaModel>.from(json['list_Student']!.map((x) => SiswaModel.fromJson(x))),
      );

  factory GroupModel.fromRawJson(String str) => GroupModel.fromJson(json.decode(str));

  GroupModel copyWith({
    String? groupId,
    String? classId,
    String? groupName,
    String? className,
    int? totalPoin,
    dynamic chatId,
    List<SiswaModel>? listStudent,
  }) =>
      GroupModel(
        groupId: groupId ?? this.groupId,
        classId: classId ?? this.classId,
        groupName: groupName ?? this.groupName,
        className: className ?? this.className,
        totalPoin: totalPoin ?? this.totalPoin,
        chatId: chatId ?? this.chatId,
        listStudent: listStudent ?? this.listStudent,
      );

  Map<String, dynamic> toJson() => {
        'group_id': groupId,
        'class_id': classId,
        'group_name': groupName,
        'class_name': className,
        'total_poin': totalPoin,
        'chatID': chatId,
        'list_Student': listStudent == null ? [] : List<dynamic>.from(listStudent!.map((x) => x.toJson())),
      };

  String toRawJson() => json.encode(toJson());
}
