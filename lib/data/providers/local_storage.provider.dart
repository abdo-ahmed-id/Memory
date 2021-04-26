import 'package:hive/hive.dart';

class LocalStorageProvider {
  static final boxName = 'memories_app';

  static Future init() async {
    await Hive.openBox(boxName);
  }

  Box get getBox {
    return Hive.box(boxName);
  }

  Future<void> delete(String key) async {
    return getBox.delete(key);
  }

  Future<T> get<T>(String key) async {
    return getBox.get(key);
  }

  Future<void> put<T>(String key, T value) async {
    return getBox.put(key, value);
  }
}
