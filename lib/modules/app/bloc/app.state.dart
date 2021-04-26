import 'package:equatable/equatable.dart';
import 'package:memories/data/models/memories.dart';

class AppState extends Equatable {
  final List<Memories> memories;
  final Map<String, List<Memories>> memoriesGroup;
  final bool newAccount;
  final bool isLogin;

  AppState(
      {this.memories,
      this.memoriesGroup,
      this.newAccount = true,
      this.isLogin});

  AppState copyWith({
    List<Memories> memories,
    Map<String, List<Memories>> memoriesGroup,
    bool newAccount,
    bool isLogin,
  }) =>
      AppState(
        memories: memories ?? this.memories,
        memoriesGroup: memoriesGroup ?? this.memoriesGroup,
        newAccount: newAccount ?? this.newAccount,
        isLogin: isLogin ?? this.isLogin,
      );

  @override
  List<Object> get props => [
        memories,
        memoriesGroup,
        newAccount,
        isLogin,
      ];
}
