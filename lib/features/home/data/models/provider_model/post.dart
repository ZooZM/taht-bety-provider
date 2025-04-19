import 'package:taht_bety_provider/features/home/data/models/provider_model/review_post.dart';

class Post {
  String? providerId;
  List<String>? images;
  String? title;
  String? content;
  int? price;
  bool? isMainService;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? id;
  List<ReviewPost>? reviews;

  Post({
    this.providerId,
    this.images,
    this.title,
    this.content,
    this.price,
    this.isMainService,
    this.createdAt,
    this.updatedAt,
    this.id,
    this.reviews,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        providerId: json['providerID'] as String?,
        images: (json['images'] as List<dynamic>?)?.cast<String>(),
        title: json['title'] as String?,
        content: json['content'] as String?,
        price: json['price'] as int?,
        isMainService: json['isMainService'] as bool?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        id: json['_id'] as String?,
        reviews: (json['reviews'] as List<dynamic>?)
            ?.map((e) => ReviewPost.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'providerID': providerId,
        'images': images,
        'title': title,
        'content': content,
        'price': price,
        'isMainService': isMainService,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '_id': id,
      };
}
