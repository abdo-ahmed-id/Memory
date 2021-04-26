import 'dart:io';

import 'package:hive/hive.dart';

part 'memories.g.dart';

@HiveType(typeId: 1)
class Memories extends HiveObject {
  @HiveField(0)
  String description;

  @HiveField(1)
  DateTime day;

  @HiveField(2)
  String image;

  Memories({this.image, this.day, this.description});
}
