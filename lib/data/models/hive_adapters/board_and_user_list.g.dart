// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../board_and_user_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BoardAndUsersAdapter extends TypeAdapter<BoardAndUsers> {
  @override
  final int typeId = 3;

  @override
  BoardAndUsers read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BoardAndUsers(
      boardModel: fields[0] as BoardModel,
      listOfUsersPhoto: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, BoardAndUsers obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.boardModel)
      ..writeByte(1)
      ..write(obj.listOfUsersPhoto);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BoardAndUsersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
