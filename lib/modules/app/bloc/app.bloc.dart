import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memories/data/models/memories.dart';
import 'package:memories/modules/app/bloc/app.state.dart';
import 'package:memories/modules/app/service/memory_service.dart';

class AppBloc extends Cubit<AppState> {
  final MemoryService _memoryService;
  AppBloc(this._memoryService) : super(AppState(memories: []));
  initState() async {
    print('initState is called');
    reloadData();
  }

  void createOrUpdateMemory(Memories memories) async {
    print(' createOrUpdateMemory is called');
    await _memoryService.createOrUpdateMemory(memories);

    reloadData();
  }

  void clearData() async {
    await _memoryService.clearData();
    reloadData();
  }

  void deleteMemory(Memories memories) async {
    await _memoryService.deleteMemory(memories);
    reloadData();
  }

  void reloadData() async {
    print('reload is called');
    List<Memories> memories = [];
    memories = await _memoryService.getMemories();
    emit(state.copyWith(memories: memories));
    emit(state.copyWith(
        memories: memories, memoriesGroup: memoriesGroup(memories)));
  }
}

Map<String, List<Memories>> memoriesGroup(List<Memories> memories) {
  Map<String, List<Memories>> map = Map<String, List<Memories>>();
  memories.forEach((memory) {
    print("mem Day ${memory.day}");
    String key = memory.day.toString().split(' ').first;
    if (key != null) {
      if (map.containsKey(key)) {
        map[key].add(memory);
      } else {
        map[key] = <Memories>[];
        map[key].add(memory);
      }
    }
  });
  return map;
}
