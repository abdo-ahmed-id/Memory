import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:memories/data/models/memories.dart';

class MemoriesDataProvider {
  static final _boxName = '_memories_app';

  static Future init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MemoriesAdapter());
    await Hive.openBox<Memories>(_boxName);
  }

  Box<Memories> get _getBox {
    return Hive.box<Memories>(_boxName);
  }

  Future<List<Memories>> getAll() async {
    return _getBox.values.toList();
  }

  Future<int> add(Memories memories) async {
    return _getBox.add(memories);
  }

  Future<int> deleteAll() async {
    return await _getBox.clear();
  }
}
