// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveModelsAdapter extends TypeAdapter<HiveModels> {
  @override
  final int typeId = 0;

  @override
  HiveModels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveModels(
      requestId: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveModels obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.requestId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveModelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
