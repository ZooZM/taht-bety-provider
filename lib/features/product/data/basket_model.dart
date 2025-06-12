import 'package:hive/hive.dart';

part 'basket_model.g.dart';

@HiveType(typeId: 2)
class BasketModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String image;

  @HiveField(2)
  int count;

  @HiveField(3)
  final String providerId;

  @HiveField(4)
  final int price;

  @HiveField(5)
  final String title;

  @HiveField(6)
  final String description;

  BasketModel({
    required this.id,
    required this.image,
    required this.count,
    required this.providerId,
    required this.price,
    required this.title,
    required this.description,
  });
}
