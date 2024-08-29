// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TeacherModel {
  final int nip;
  final String fullname;
  final String? iamgeProfile;
  final String? className;
  final String? subject;
  TeacherModel({
    required this.nip,
    required this.fullname,
    required this.iamgeProfile,
    required this.className,
    required this.subject,
  });

  factory TeacherModel.fromJson(String source) => TeacherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory TeacherModel.fromMap(Map<String, dynamic> map) {
    return TeacherModel(
      nip: map['nip'] as int,
      fullname: map['fullname'] as String,
      iamgeProfile: map['iamge_profile'] as String?,
      className: map['class_name'] as String?,
      subject: map['subject'] as String?,
    );
  }

  @override
  int get hashCode {
    return nip.hashCode ^ fullname.hashCode ^ iamgeProfile.hashCode ^ className.hashCode ^ subject.hashCode;
  }

  @override
  bool operator ==(covariant TeacherModel other) {
    if (identical(this, other)) return true;

    return other.nip == nip && other.fullname == fullname && other.iamgeProfile == iamgeProfile && other.className == className && other.subject == subject;
  }

  TeacherModel copyWith({
    int? nip,
    String? fullname,
    String? iamgeProfile,
    String? className,
    String? subject,
  }) {
    return TeacherModel(
      nip: nip ?? this.nip,
      fullname: fullname ?? this.fullname,
      iamgeProfile: iamgeProfile ?? this.iamgeProfile,
      className: className ?? this.className,
      subject: subject ?? this.subject,
    );
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nip': nip,
      'fullname': fullname,
      'iamge_profile': iamgeProfile,
      'class_name': className,
      'subject': subject,
    };
  }

  @override
  String toString() {
    return 'TeacherModel(nip: $nip, fullname: $fullname, iamgeProfile: $iamgeProfile, className: $className, subject: $subject)';
  }
}
