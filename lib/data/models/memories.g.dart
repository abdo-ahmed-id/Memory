// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memories.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MemoriesAdapter extends TypeAdapter<Memories> {
  @override
  final int typeId = 1;

  @override
  Memories read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Memories(
      image: fields[2] as String,
      day: fields[1] as DateTime,
      description: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Memories obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.description)
      ..writeByte(1)
      ..write(obj.day)
      ..writeByte(2)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemoriesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
