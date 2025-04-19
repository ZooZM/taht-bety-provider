import 'location.dart';
import 'post.dart';
import 'review.dart';

class ProviderModel {
  String? providerId;
  String? providerType;
  List<String>? id;
  String? criminalRecord;
  String? subscriptionType;
  DateTime? subscriptionStartDate;
  DateTime? subscriptionEndDate;
  int? subscriptionPercentage;
  int? subscriptionMonthly;
  bool? isActive;
  bool? isOnline;
  List<String>? reports;
  List<Location>? locations;
  List<Post>? posts;
  List<Review>? reviews;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? lastPhotoAt;
  String? name;
  String? email;
  String? photo;
  double? distance; // إضافة distance

  ProviderModel({
    this.providerId,
    this.providerType,
    this.id,
    this.criminalRecord,
    this.subscriptionType,
    this.subscriptionStartDate,
    this.subscriptionEndDate,
    this.subscriptionPercentage,
    this.subscriptionMonthly,
    this.isActive,
    this.isOnline,
    this.reports,
    this.locations,
    this.posts,
    this.reviews,
    this.createdAt,
    this.updatedAt,
    this.lastPhotoAt,
    this.name,
    this.email,
    this.photo,
    this.distance, // إضافة distance إلى الـ Constructor
  });

  ProviderModel copyWith({
    String? providerId,
    String? providerType,
    List<String>? id,
    String? criminalRecord,
    String? subscriptionType,
    DateTime? subscriptionStartDate,
    DateTime? subscriptionEndDate,
    int? subscriptionPercentage,
    int? subscriptionMonthly,
    bool? isActive,
    bool? isOnline,
    List<String>? reports,
    List<Location>? locations,
    List<Post>? posts,
    List<Review>? reviews,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastPhotoAt,
    String? name,
    String? email,
    String? photo,
    double? distance, // إضافة distance هنا أيضًا
  }) {
    return ProviderModel(
      providerId: providerId ?? this.providerId,
      providerType: providerType ?? this.providerType,
      id: id ?? this.id,
      criminalRecord: criminalRecord ?? this.criminalRecord,
      subscriptionType: subscriptionType ?? this.subscriptionType,
      subscriptionStartDate:
          subscriptionStartDate ?? this.subscriptionStartDate,
      subscriptionEndDate: subscriptionEndDate ?? this.subscriptionEndDate,
      subscriptionPercentage:
          subscriptionPercentage ?? this.subscriptionPercentage,
      subscriptionMonthly: subscriptionMonthly ?? this.subscriptionMonthly,
      isActive: isActive ?? this.isActive,
      isOnline: isOnline ?? this.isOnline,
      reports: reports ?? this.reports,
      locations: locations ?? this.locations,
      posts: posts ?? this.posts,
      reviews: reviews ?? this.reviews,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastPhotoAt: lastPhotoAt ?? this.lastPhotoAt,
      name: name ?? this.name,
      email: email ?? this.email,
      photo: photo ?? this.photo,
      distance: distance ?? this.distance, // تعيين distance
    );
  }

  factory ProviderModel.fromJson(Map<String, dynamic> json) => ProviderModel(
        providerId: json['providerID'] is Map<String, dynamic>
            ? json['providerID']['_id'] as String?
            : json['providerID'] as String?,
        name: json['providerID'] is Map<String, dynamic>
            ? json['providerID']['name'] as String?
            : null,
        email: json['providerID'] is Map<String, dynamic>
            ? json['providerID']['email'] as String?
            : null,
        providerType: json['providerType'] as String?,
        id: (json['id'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
        criminalRecord: json['criminalRecord'] as String?,
        subscriptionType: json['subscriptionType'] as String?,
        subscriptionStartDate: json['subscriptionStartDate'] == null
            ? null
            : DateTime.parse(json['subscriptionStartDate'] as String),
        subscriptionEndDate: json['subscriptionEndDate'] == null
            ? null
            : DateTime.parse(json['subscriptionEndDate'] as String),
        subscriptionPercentage: json['subscriptionPercentage'] as int?,
        subscriptionMonthly: json['subscriptionMonthly'] as int?,
        isActive: json['isActive'] as bool?,
        isOnline: json['isOnline'] as bool?,
        reports: (json['reports'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList(),
        locations: (json['locations'] as List<dynamic>?)
            ?.map((e) => Location.fromJson(e as Map<String, dynamic>))
            .toList(),
        posts: (json['posts'] as List<dynamic>?)
            ?.map((e) => Post.fromJson(e as Map<String, dynamic>))
            .toList(),
        reviews: (json['reviews'] as List<dynamic>?)
            ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
            .toList(),
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        lastPhotoAt: json['lastPhotoAt'] == null
            ? null
            : DateTime.parse(json['lastPhotoAt'] as String),
        photo: json['providerID'] is Map<String, dynamic>
            ? json['providerID']['photo'] as String?
            : null,
        distance: (json['distance'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'providerID': providerId,
        'providerType': providerType,
        'id': id,
        'criminalRecord': criminalRecord,
        'subscriptionType': subscriptionType,
        'subscriptionStartDate': subscriptionStartDate?.toIso8601String(),
        'subscriptionEndDate': subscriptionEndDate?.toIso8601String(),
        'subscriptionPercentage': subscriptionPercentage,
        'subscriptionMonthly': subscriptionMonthly,
        'isActive': isActive,
        'isOnline': isOnline,
        'reports': reports,
        'locations': locations?.map((e) => e.toJson()).toList(),
        'posts': posts?.map((e) => e.toJson()).toList(),
        'reviews': reviews?.map((e) => e.toJson()).toList(),
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'lastPhotoAt': lastPhotoAt?.toIso8601String(),
        'name': name,
        'email': email,
        'photo': photo,
        'distance': distance, // إضافة distance
      };
}
