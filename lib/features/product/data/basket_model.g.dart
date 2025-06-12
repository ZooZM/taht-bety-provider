// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BasketModelAdapter extends TypeAdapter<BasketModel> {
  @override
  final int typeId = 2;

  @override
  BasketModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BasketModel(
      id: fields[0] as String,
      image: fields[1] as String,
      count: fields[2] as int,
      providerId: fields[3] as String,
      price: fields[4] as int,
      title: fields[5] as String,
      description: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BasketModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.count)
      ..writeByte(3)
      ..write(obj.providerId)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.title)
      ..writeByte(6)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BasketModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
