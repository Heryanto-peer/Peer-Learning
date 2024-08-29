import 'dart:convert';

class Assesment {
  final int? nis;
  final String? fullname;
  int? significant;
  int? helpful;

  Assesment({
    this.nis,
    this.fullname,
    this.significant,
    this.helpful,
  });

  factory Assesment.fromJson(Map<String, dynamic> json) => Assesment(
        nis: json['nis'],
        fullname: json['fullname'],
        significant: json['significant'],
        helpful: json['helpful'],
      );

  factory Assesment.fromRawJson(String str) => Assesment.fromJson(json.decode(str));

  Assesment copyWith({
    int? nis,
    String? fullname,
    int? significant,
    int? helpful,
  }) =>
      Assesment(
        nis: nis ?? this.nis,
        fullname: fullname ?? this.fullname,
        significant: significant ?? this.significant,
        helpful: helpful ?? this.helpful,
      );

  Map<String, dynamic> toJson() => {
        'nis': nis,
        'fullname': fullname,
        'significant': significant,
        'helpful': helpful,
      };

  String toRawJson() => json.encode(toJson());
}

class AssesmentModel {
  final String? assesmentId;
  final String? groupName;
  final String? subjectName;
  final int? nis;
  final List<Assesment>? assesments;
  final DateTime? dateCreated;

  AssesmentModel({
    this.assesmentId,
    this.groupName,
    this.subjectName,
    this.nis,
    this.assesments,
    this.dateCreated,
  });

  factory AssesmentModel.fromJson(Map<String, dynamic> json) => AssesmentModel(
        assesmentId: json['assesment_id'],
        groupName: json['group_name'],
        subjectName: json['subject_name'],
        nis: json['nis'],
        assesments: json['assesments'] == null ? [] : List<Assesment>.from(json['assesments']!.map((x) => Assesment.fromJson(x))),
        dateCreated: json['date_created'] == null ? null : DateTime.parse(json['date_created']),
      );

  factory AssesmentModel.fromRawJson(String str) => AssesmentModel.fromJson(json.decode(str));

  AssesmentModel copyWith({
    String? assesmentId,
    String? groupName,
    String? subjectName,
    int? nis,
    List<Assesment>? assesments,
    DateTime? dateCreated,
  }) =>
      AssesmentModel(
        assesmentId: assesmentId ?? this.assesmentId,
        groupName: groupName ?? this.groupName,
        subjectName: subjectName ?? this.subjectName,
        nis: nis ?? this.nis,
        assesments: assesments ?? this.assesments,
        dateCreated: dateCreated ?? this.dateCreated,
      );

  Map<String, dynamic> toJson() => {
        'assesment_id': assesmentId,
        'group_name': groupName,
        'subject_name': subjectName,
        'nis': nis,
        'assesments': assesments == null ? [] : List<dynamic>.from(assesments!.map((x) => x.toJson())),
        'date_created': "${dateCreated!.year.toString().padLeft(4, '0')}-${dateCreated!.month.toString().padLeft(2, '0')}-${dateCreated!.day.toString().padLeft(2, '0')}",
      };

  String toRawJson() => json.encode(toJson());
}
