import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fuzzy_web_admin/module/login/data/model/teacher_model.dart';

class AppStore {
  static final AppStore _singleton = AppStore._internal(const FlutterSecureStorage());
  static AppStore get instance => _singleton;

  final FlutterSecureStorage storage;

  AppStore._internal(this.storage);

  Future<TeacherModel?> get guru async => await storage.read(key: 'guru') != null ? TeacherModel.fromJson(await storage.read(key: 'guru') ?? '') : null;

  Future<void> removeGuru() async => await storage.delete(key: 'guru');

  Future<void> setGuru(TeacherModel? guru) async => await storage.write(key: 'guru', value: guru?.toJson() ?? '');
}
