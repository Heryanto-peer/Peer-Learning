import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fuzzy_mobile_user/common/model/siswa_model.dart';

class AppStore {
  static final AppStore _singleton = AppStore._internal(const FlutterSecureStorage());
  static AppStore get instance => _singleton;

  final FlutterSecureStorage storage;

  AppStore._internal(this.storage);

  Future<SiswaModel?> get siswa async => await storage.read(key: 'siswa') != null ? SiswaModel.fromRawJson(await storage.read(key: 'siswa') ?? '') : null;

  Future<void> setSiswa(SiswaModel? siswa) async => await storage.write(key: 'siswa', value: siswa?.toRawJson() ?? '');
}
