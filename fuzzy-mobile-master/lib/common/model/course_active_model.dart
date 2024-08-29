// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fuzzy_mobile_user/common/utils/app_date_format.dart';

class CourseModel {
  final String? subjectId;
  final String? classId;
  final DateTime? startDate;
  final DateTime? endDate;

  CourseModel({
    this.subjectId,
    this.startDate,
    this.endDate,
    this.classId,
  });

  factory CourseModel.fromJson(String source) => CourseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      subjectId: map['subject_id'] != null ? map['subject_id'] as String : null,
      classId: map['class_id'] != null ? map['class_id'] as String : null,
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
    String? classId,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return CourseModel(
      subjectId: subjectId ?? this.subjectId,
      classId: classId ?? this.classId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'subject_id': subjectId,
      'class_id': classId,
      'start_course': '${startDate?.hour}:${startDate?.minute}:${startDate?.second}',
      'end_course': '${endDate?.hour}:${endDate?.minute}:${endDate?.second}',
    };
  }

  @override
  String toString() => 'CourseModel(subject_id: $subjectId, class_id: $classId, start_course: $startDate, end_course: $endDate)';
}
