// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_curuser.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurUserAdapter extends TypeAdapter<ProviderCurUser> {
  @override
  final int typeId = 0;

  @override
  ProviderCurUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProviderCurUser(
      token: fields[0] as String,
      userId: fields[1] as String,
      name: fields[2] as String,
      email: fields[3] as String,
      photo: fields[4] as String,
      phoneNumber: fields[5] as String,
      role: fields[6] as String,
      region: fields[7] as String,
      age: fields[8] as int?,
      gender: fields[9] as String?,
      lastPhotoAt: fields[10] as DateTime?,
      idFrontSide: fields[11] as String?,
      idBackSide: fields[12] as String?,
      isActive: fields[13] as bool?,
      isOnline: fields[14] as bool?,
      type: fields[15] as String?,
      providerId: fields[16] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProviderCurUser obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.token)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.photo)
      ..writeByte(5)
      ..write(obj.phoneNumber)
      ..writeByte(6)
      ..write(obj.role)
      ..writeByte(7)
      ..write(obj.region)
      ..writeByte(8)
      ..write(obj.age)
      ..writeByte(9)
      ..write(obj.gender)
      ..writeByte(10)
      ..write(obj.lastPhotoAt)
      ..writeByte(11)
      ..write(obj.idFrontSide)
      ..writeByte(12)
      ..write(obj.idBackSide)
      ..writeByte(13)
      ..write(obj.isActive)
      ..writeByte(14)
      ..write(obj.isOnline)
      ..writeByte(15)
      ..write(obj.type)
      ..writeByte(16)
      ..write(obj.providerId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
