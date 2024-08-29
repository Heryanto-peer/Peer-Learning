import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy_web_admin/common/model/response_default_model.dart';
import 'package:fuzzy_web_admin/common/widget/snackbar/app_snackbar.dart';
import 'package:fuzzy_web_admin/core/route/route_constant.dart';
import 'package:fuzzy_web_admin/core/store/app_store.dart';
import 'package:fuzzy_web_admin/module/homes/quiz/data/model/quiz_model.dart';
import 'package:fuzzy_web_admin/module/homes/quiz/data/repo/quiz_repo.dart';
import 'package:fuzzy_web_admin/module/homes/quiz/data/utils/quiz_type_enum.dart';
import 'package:fuzzy_web_admin/module/login/data/model/teacher_model.dart';
import 'package:get/get.dart';

class QuizController extends GetxController with QuizRepo {
  ScrollController scrollController = ScrollController();

  List<QuizModel> quizList = [];
  PaginationModel pagination = PaginationModel(page: 1);
  String? subjectId;
  QuizTypeEnum? typeQuiz;
  String? mapel;
  TeacherModel? teacher;

  bool loading = false;

  Future<bool> addNewQuiz(Map<String, dynamic> data) async {
    try {
      await repoAddQuiz(data: data);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  convertExcelToObject() async {
    final FilePickerResult? file = await FilePicker.platform.pickFiles(allowCompression: true, withData: true, type: FileType.custom, allowedExtensions: ['xlsx']);

    if (file == null) {
      return;
    }

    final Uint8List? data = file.files.first.bytes;

    if (data == null) {
      return;
    }

    loading = true;
    update();

    final Excel excel = Excel.decodeBytes(data);
    for (var table in excel.tables.keys) {
      for (var i = 0; i < excel.tables[table]!.rows.length; i++) {
        if (i != 0) {
          final row = excel.tables[table]!.rows[i];
          final Map<String, dynamic> data = {
            'subject_id': subjectId,
            'question': row[1]?.value?.toString(),
            'answer': row[2]?.value?.toString(),
            'option1': row[4]?.value?.toString(),
            'option2': row[5]?.value?.toString(),
            'option3': row[6]?.value?.toString(),
            'option4': row[7]?.value?.toString(),
            'poin': int.tryParse(row[3]?.value?.toString() ?? '0'),
            'type': row[0]?.value?.toString(),
            'tips': row[8]?.value?.toString(),
          };

          final added = await addNewQuiz(data);
          if (!added) {
            AppSnackbar.error(title: 'Error', error: 'Gagal menambahkan quiz');
          }
        }
      }
    }

    await getQuizBySubject();

    loading = false;
    update();
  }

  getQuizBySubject() async {
    try {
      final res = await repoQuizBySubject(subjectID: subjectId!, page: pagination.page ?? 1, limit: 10, typeQuiz: ConvertQuizTypeEnum.reverse(typeQuiz));

      if (res.data != null) {
        pagination = res.pagination!;
        quizList = List<QuizModel>.from(res.data.map((e) => QuizModel.fromJson(e)));
        update();
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  onChangeOfPage(int page) {
    pagination.page = page;
    update();
    getQuizBySubject();
  }

  onDeleteQuiz({required String questionID}) async {
    try {
      final res = await repoDeleteQuiz(questionID: questionID);
      if (res.status == 200) {
        getQuizBySubject();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void onInit() async {
    teacher = await AppStore.instance.guru;
    if (teacher?.nip == null) {
      Get.offAllNamed(RouteConstant.login);
      return;
    }
    Get.parameters.forEach((key, value) {
      if (key == 'subject_id') {
        subjectId = value;
      }

      if (key == 'mapel') {
        mapel = value;
      }
    });

    if (subjectId != null) {
      getQuizBySubject();
    }

    super.onInit();
  }

  setTypeQuiz(QuizTypeEnum? type) {
    typeQuiz = type;
    update();

    getQuizBySubject();
  }
}
