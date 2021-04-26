import 'package:equatable/equatable.dart';
import 'package:memories/data/models/memories.dart';

class AppState extends Equatable {
  final List<Memories> memories;
  final Map<String, List<Memories>> memoriesGroup;

  AppState({this.memories, this.memoriesGroup});
  AppState copyWith({
    List<Memories> memories,
    Map<String, List<Memories>> memoriesGroup,
  }) =>
      AppState(
          memories: memories ?? this.memories,
          memoriesGroup: memoriesGroup ?? this.memoriesGroup);
  @override
  List<Object> get props => [memories, memoriesGroup];
}
