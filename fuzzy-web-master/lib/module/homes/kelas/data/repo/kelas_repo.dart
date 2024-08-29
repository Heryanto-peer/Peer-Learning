import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fuzzy_web_admin/common/model/response_default_model.dart';
import 'package:fuzzy_web_admin/module/homes/kelas/data/model/course_model.dart';
import 'package:fuzzy_web_admin/module/homes/kelas/data/model/group_model.dart';
import 'package:fuzzy_web_admin/module/homes/kelas/data/network/kelas_network.dart';
import 'package:fuzzy_web_admin/module/homes/materi/data/model/materi_model.dart';
import 'package:fuzzy_web_admin/module/homes/siswa/data/model/siswa_model.dart';

mixin KelasRepo {
  final _myNetwork = KelasNetwork();

  Future<ResponseDefaultModel> getAllKelas() async {
    try {
      return await _myNetwork.getAllKelas();
    } catch (e) {
      rethrow;
    }
  }

  Future<CourseModel?> repoAddCourse({required Map<String, dynamic> data}) async {
    try {
      final res = await _myNetwork.addCourse(data: data);
      return CourseModel.fromMap(res.data);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<List<GroupModel>> repoAddNewGroup({required List<Map<String, dynamic>> data}) async {
    try {
      final res = await _myNetwork.addNewGroup(data);
      return List<GroupModel>.from(res.data.map((x) => GroupModel.fromJson(x)));
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseDefaultModel> repoAddStudent({required Map<String, dynamic> data}) async {
    return await _myNetwork.addStudent(data: data);
  }

  Future<ResponseDefaultModel> repoAddStudentIntoGroup({required List<String> listSiswa, required String groupID}) async {
    try {
      return await _myNetwork.addStudentIntoGroup(listSiswa: listSiswa, groupID: groupID);
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseDefaultModel> repoCountFuzzy({required String classId, required String time}) async {
    return await _myNetwork.postCountFuzzy(classId: classId, time: time);
  }

  Future<ResponseDefaultModel> repoCountPointGroup({required String classId}) async {
    return await _myNetwork.postCountPoinGroup(classId: classId);
  }

  Future<bool> repoDeleteSiswa({required int nis, required String password}) async {
    try {
      final res = await _myNetwork.deleteStudent(nis: nis, password: password);
      if (res.status == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<List<MateriModel>> repoGetAllMateri() async {
    try {
      final res = await _myNetwork.getAllMateri();
      if (res.status == 200) {
        return List<MateriModel>.from(res.data.map((x) => MateriModel.fromJson(x)));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }

  Future<CourseModel?> repoGetCourse({required String classID}) async {
    try {
      final res = await _myNetwork.getCourse(classID: classID);
      return CourseModel.fromMap(res.data);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<SiswaModel> repoGetDetailStudent({required String nis}) async {
    try {
      final res = await _myNetwork.getDetailStudent(nis: nis);
      return SiswaModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<GroupModel>> repoGetGroupByClassId({required String classId}) async {
    try {
      final res = await _myNetwork.getGroupsByClassId(classId: classId);
      return List<GroupModel>.from(res.data.map((x) => GroupModel.fromJson(x)));
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<ResponseDefaultModel> repoGetSiswaKelas(String classId) async {
    try {
      return await _myNetwork.getSiswaKelas(classId);
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseDefaultModel> repoPostAddKelas({required Map<String, dynamic> data}) async {
    try {
      return await _myNetwork.postAddKelas(data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool?> repoRemoveCourse({required String classID}) async {
    try {
      final res = await _myNetwork.removeCourse(classID: classID);
      return res.status == 200 ? true : false;
    } catch (e) {
      return false;
    }
  }

  Future<ResponseDefaultModel> repoUpdateStudent({required Map<String, dynamic> data}) async {
    try {
      return await _myNetwork.updateStudent(data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> repoUploadImageProfile({required Uint8List images, required int nis}) async {
    try {
      return await _myNetwork.uploadImageProfile(images: images, nis: nis);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
