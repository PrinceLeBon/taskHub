// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../tasks_and_user_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAndUsersAdapter extends TypeAdapter<TaskAndUsers> {
  @override
  final int typeId = 4;

  @override
  TaskAndUsers read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskAndUsers(
      taskModel: fields[0] as TaskModel,
      listOfUsersPhoto: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, TaskAndUsers obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.taskModel)
      ..writeByte(1)
      ..write(obj.listOfUsersPhoto);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAndUsersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
