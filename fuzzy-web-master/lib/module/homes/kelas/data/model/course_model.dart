import 'dart:convert';

import 'package:fuzzy_web_admin/common/utils/app_date_format.dart';

class CourseModel {
  final String? subjectId;
  final DateTime? startDate;
  final DateTime? endDate;

  CourseModel({
    this.subjectId,
    this.startDate,
    this.endDate,
  });

  factory CourseModel.fromJson(String source) => CourseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      subjectId: map['subject_id'] != null ? map['subject_id'] as String : null,
      startDate: map['start_course'] != null ? AppDateFormat.stringTimeToDateTime(time: map['start_course'] as String) : null,
      endDate: map['end_course'] != null ? AppDateFormat.stringTimeToDateTime(time: map['end_course'] as String) : null,
    );
  }

  @override
  int get hashCode => subjectId.hashCode ^ startDate.hashCode ^ endDate.hashCode;

  @override
  bool operator ==(covariant CourseModel other) {
    if (identical(this, other)) return true;

    return other.subjectId == subjectId && other.startDate == startDate && other.endDate == endDate;
  }

  CourseModel copyWith({
    String? subjectId,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return CourseModel(
      subjectId: subjectId ?? this.subjectId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'subject_id': subjectId,
      'start_course': '${startDate?.hour}:${startDate?.minute}:${startDate?.second}',
      'end_course': '${endDate?.hour}:${endDate?.minute}:${endDate?.second}',
    };
  }

  @override
  String toString() => 'CourseModel(subject_id: $subjectId, start_course: $startDate, end_course: $endDate)';
}
