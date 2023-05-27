// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskModelAdapter extends TypeAdapter<TaskModel> {
  @override
  final int typeId = 2;

  @override
  TaskModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskModel(
      id: fields[0] as String,
      boardId: fields[1] as String,
      userId: fields[2] as String,
      title: fields[3] as String,
      description: fields[4] as String,
      state: fields[5] as bool,
      creationDate: fields[6] as DateTime,
      dateForTheTask: fields[7] as DateTime,
      hourForTheTask: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.boardId)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.state)
      ..writeByte(6)
      ..write(obj.creationDate)
      ..writeByte(7)
      ..write(obj.dateForTheTask)
      ..writeByte(8)
      ..write(obj.hourForTheTask);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
