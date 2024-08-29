import 'dart:convert';

import 'package:fuzzy_web_admin/module/homes/siswa/data/model/siswa_model.dart';

class KelasModel {
  final String? classId;
  final int? nip;
  final String? className;
  final List<SiswaModel>? students;

  KelasModel({
    this.classId,
    this.nip,
    this.className,
    this.students,
  });

  factory KelasModel.fromJson(Map<String, dynamic> json) => KelasModel(
        classId: json['class_id'],
        nip: json['nip'],
        className: json['class_name'],
        students: json['students'] == null ? [] : List<SiswaModel>.from(json['students']!.map((x) => SiswaModel.fromJson(x))),
      );

  factory KelasModel.fromRawJson(String str) => KelasModel.fromJson(json.decode(str));

  KelasModel copyWith({
    String? classId,
    int? nip,
    String? className,
    List<SiswaModel>? students,
  }) =>
      KelasModel(
        classId: classId ?? this.classId,
        nip: nip ?? this.nip,
        className: className ?? this.className,
        students: students ?? this.students,
      );

  Map<String, dynamic> toJson() => {
        'class_id': classId,
        'nip': nip,
        'class_name': className,
        'students': students == null ? [] : List<dynamic>.from(students!.map((x) => x.toJson())),
      };

  String toRawJson() => json.encode(toJson());
}
