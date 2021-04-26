import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memories/data/models/memories.dart';
import 'package:memories/modules/app/bloc/app.state.dart';
import 'package:memories/modules/app/service/auth.service.dart';
import 'package:memories/modules/app/service/memory_service.dart';

class AppBloc extends Cubit<AppState> {
  final MemoryService _memoryService;
  final AuthService _authService;

  AppBloc(this._memoryService, this._authService)
      : super(AppState(memories: [], isLogin: _authService.isLogin));

  initState() async {
    if (state.isLogin) {
      print('data is reload');
      reloadData();
    }
  }

  void createOrUpdateMemory(Memories memories) async {
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
    List<Memories> memories = [];
    memories = await _memoryService.getMemories();
    emit(state.copyWith(
        memories: memories,
        memoriesGroup: memoriesGroup(memories),
        isLogin: _authService.isLogin));
  }

  Map<String, List<Memories>> memoriesGroup(List<Memories> memories) {
    Map<String, List<Memories>> map = Map<String, List<Memories>>();
    memories.forEach((memory) {
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

  void toggleNewAccount() {
    emit(state.copyWith(newAccount: !state.newAccount));
  }

  void logout() async {
    await _authService.logout();
    emit(state.copyWith(isLogin: false));
  }

  void loginOrCreateAccount(
      BuildContext context, String userName, String password) {
    _authService.loginOrCreateAccount(
        state.newAccount, userName, password, context);
  }
}
