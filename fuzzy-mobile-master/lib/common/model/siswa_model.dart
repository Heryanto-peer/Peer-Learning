import 'dart:convert';

import 'package:fuzzy_mobile_user/common/model/group_model.dart';

class ClassModel {
  final String? classId;
  final String? classAdvisor;
  final String? className;

  ClassModel({
    this.classId,
    this.classAdvisor,
    this.className,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) => ClassModel(
        classId: json['class_id'],
        classAdvisor: json['class_advisor'],
        className: json['class_name'],
      );

  factory ClassModel.fromRawJson(String str) => ClassModel.fromJson(json.decode(str));

  ClassModel copyWith({
    String? classId,
    String? classAdvisor,
    String? className,
  }) =>
      ClassModel(
        classId: classId ?? this.classId,
        classAdvisor: classAdvisor ?? this.classAdvisor,
        className: className ?? this.className,
      );

  Map<String, dynamic> toJson() => {
        'class_id': classId,
        'class_advisor': classAdvisor,
        'class_name': className,
      };

  String toRawJson() => json.encode(toJson());
}

class SiswaModel {
  final int? nis;
  final String? fullname;
  final ClassModel? datumClass;
  final GroupModel? group;
  final String? imageProfile;
  final int? contributes;
  final DateTime? latestDaily;
  final String? assementID;

  SiswaModel({
    this.nis,
    this.fullname,
    this.datumClass,
    this.group,
    this.imageProfile,
    this.contributes,
    this.latestDaily,
    this.assementID,
  });

  factory SiswaModel.fromJson(Map<String, dynamic> json) => SiswaModel(
        nis: json['nis'],
        fullname: json['fullname'],
        datumClass: json['class'] == null ? null : ClassModel.fromJson(json['class']),
        group: json['group'] == null ? null : GroupModel.fromJson(json['group']),
        imageProfile: json['image_profile'],
        contributes: json['contributes'],
        latestDaily: json['latest_daily'] == null ? null : DateTime.parse(json['latest_daily']).toLocal(),
        assementID: json['assement_id'],
      );

  factory SiswaModel.fromRawJson(String str) => SiswaModel.fromJson(json.decode(str));

  SiswaModel copyWith({
    int? nis,
    String? fullname,
    ClassModel? datumClass,
    GroupModel? group,
    String? imageProfile,
    int? contributes,
    DateTime? latestDaily,
    String? assementID,
  }) =>
      SiswaModel(
        nis: nis ?? this.nis,
        fullname: fullname ?? this.fullname,
        datumClass: datumClass ?? this.datumClass,
        group: group ?? this.group,
        imageProfile: imageProfile ?? this.imageProfile,
        contributes: contributes ?? this.contributes,
        latestDaily: latestDaily ?? this.latestDaily,
        assementID: assementID ?? this.assementID,
      );

  Map<String, dynamic> toJson() => {
        'nis': nis,
        'fullname': fullname,
        'class': datumClass?.toJson(),
        'group': group?.toJson(),
        'image_profile': imageProfile,
        'contributes': contributes,
        'latest_daily': latestDaily?.toIso8601String(),
        'assement_id': assementID,
      };

  String toRawJson() => json.encode(toJson());
}
