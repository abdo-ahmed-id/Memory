import 'package:memories/data/models/memories.dart';
import 'package:memories/data/providers/memories_data_provider.dart';

class MemoryService {
  final MemoriesDataProvider _dataProvider;

  MemoryService(this._dataProvider);
  Future createOrUpdateMemory(Memories memories) async {
    if (memories.isInBox) {
      return await memories.save();
    }
    return await _dataProvider.add(memories);
  }

  Future<List<Memories>> getMemories() async {
    return await _dataProvider.getAll();
  }

  Future clearData() async {
    return await _dataProvider.deleteAll();
  }

  Future deleteMemory(Memories memories) async {
    return await memories.delete();
  }

  Future updateMemory(Memories memories) async {
    return await memories.save();
  }
}
