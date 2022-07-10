// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Result.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResultAdapter extends TypeAdapter<Result> {
  @override
  final int typeId = 0;

  @override
  Result read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Result(
      genre_ids: (fields[0] as List).cast<int>(),
      original_title: fields[1] as String,
      overview: fields[2] as String,
      poster_path: fields[3] as String,
      release_date: fields[4] as String,
      vote_average: fields[5] as double,
      vote_count: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Result obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.genre_ids)
      ..writeByte(1)
      ..write(obj.original_title)
      ..writeByte(2)
      ..write(obj.overview)
      ..writeByte(3)
      ..write(obj.poster_path)
      ..writeByte(4)
      ..write(obj.release_date)
      ..writeByte(5)
      ..write(obj.vote_average)
      ..writeByte(6)
      ..write(obj.vote_count);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
