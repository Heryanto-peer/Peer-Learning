import 'dart:convert';

class MateriModel {
  final String? subjectId;
  final String? subjectName;
  final int? subjectLevel;
  final String? teacherName;
  final List<MaterisModel>? materisModel;

  MateriModel({
    this.subjectId,
    this.subjectName,
    this.subjectLevel,
    this.teacherName,
    this.materisModel,
  });

  factory MateriModel.fromJson(Map<String, dynamic> json) => MateriModel(
        subjectId: json['subject_id'],
        subjectName: json['subject_name'],
        subjectLevel: json['subject_level'],
        teacherName: json['teacher_name'],
        materisModel: json['materis'] == null ? [] : List<MaterisModel>.from(json['materis']!.map((x) => MaterisModel.fromJson(x))),
      );

  factory MateriModel.fromRawJson(String str) => MateriModel.fromJson(json.decode(str));

  MateriModel copyWith({
    String? subjectId,
    String? subjectName,
    int? subjectLevel,
    String? teacherName,
    List<MaterisModel>? materisModel,
  }) =>
      MateriModel(
        subjectId: subjectId ?? this.subjectId,
        subjectName: subjectName ?? this.subjectName,
        subjectLevel: subjectLevel ?? this.subjectLevel,
        teacherName: teacherName ?? this.teacherName,
        materisModel: materisModel ?? this.materisModel,
      );

  Map<String, dynamic> toJson() => {
        'subject_id': subjectId,
        'subject_name': subjectName,
        'subject_level': subjectLevel,
        'teacher_name': teacherName,
        'materis': materisModel == null ? [] : List<dynamic>.from(materisModel!.map((x) => x.toJson())),
      };

  String toRawJson() => json.encode(toJson());
}

class MaterisModel {
  final String? materiId;
  final String? pathMateri;
  final String? materiName;

  MaterisModel({
    this.materiId,
    this.pathMateri,
    this.materiName,
  });

  factory MaterisModel.fromJson(Map<String, dynamic> json) => MaterisModel(
        materiId: json['materi_id'],
        pathMateri: json['path_materi'],
        materiName: json['materi_name'],
      );

  factory MaterisModel.fromRawJson(String str) => MaterisModel.fromJson(json.decode(str));

  MaterisModel copyWith({
    String? materiId,
    String? pathMateri,
    String? materiName,
  }) =>
      MaterisModel(
        materiId: materiId ?? this.materiId,
        pathMateri: pathMateri ?? this.pathMateri,
        materiName: materiName ?? this.materiName,
      );

  Map<String, dynamic> toJson() => {
        'materi_id': materiId,
        'path_materi': pathMateri,
        'materi_name': materiName,
      };

  String toRawJson() => json.encode(toJson());
}
