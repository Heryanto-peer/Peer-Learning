import 'dart:convert';

class PaginationModel {
  int? page;
  int? totalPage;
  int? totalData;

  PaginationModel({
    this.page,
    this.totalPage,
    this.totalData,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) => PaginationModel(
        page: json['page'],
        totalPage: json['total_page'],
        totalData: json['total_data'],
      );

  factory PaginationModel.fromRawJson(String str) => PaginationModel.fromJson(json.decode(str));

  PaginationModel copyWith({
    int? page,
    int? totalPage,
    int? totalData,
  }) =>
      PaginationModel(
        page: page ?? this.page,
        totalPage: totalPage ?? this.totalPage,
        totalData: totalData ?? this.totalData,
      );

  Map<String, dynamic> toJson() => {
        'page': page,
        'total_page': totalPage,
        'total_data': totalData,
      };

  String toRawJson() => json.encode(toJson());
}

class ResponseDefaultModel {
  final int? status;
  final String? message;
  final PaginationModel? pagination;
  final dynamic data;

  ResponseDefaultModel({
    this.status,
    this.message,
    this.pagination,
    this.data,
  });

  factory ResponseDefaultModel.fromJson(Map<String, dynamic> json) => ResponseDefaultModel(
        status: json['status'],
        message: json['message'],
        pagination: json['pagination'] == null ? null : PaginationModel.fromJson(json['pagination']),
        data: json['data'],
      );

  factory ResponseDefaultModel.fromRawJson(String str) => ResponseDefaultModel.fromJson(json.decode(str));

  ResponseDefaultModel copyWith({
    int? status,
    String? message,
    PaginationModel? pagination,
    dynamic data,
  }) =>
      ResponseDefaultModel(
        status: status ?? this.status,
        message: message ?? this.message,
        pagination: pagination ?? this.pagination,
        data: data ?? this.data,
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'pagination': pagination?.toJson(),
        'data': data,
      };

  String toRawJson() => json.encode(toJson());
}
