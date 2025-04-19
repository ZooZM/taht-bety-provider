class Review {
  String? id;
  String? review;
  int? rating;
  ReviewUser? user; // Updated to use a new class
  String? provider;
  DateTime? createdAt;
  DateTime? updatedAt;

  Review({
    this.id,
    this.review,
    this.rating,
    this.user,
    this.provider,
    this.createdAt,
    this.updatedAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json['_id'] as String?,
        review: json['review'] as String?,
        rating: json['rating'] as int?,
        user: json['user'] != null && json['user'] is Map<String, dynamic>
            ? ReviewUser.fromJson(json['user'])
            : null, // Handle nested user object
        provider: json['provider'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.tryParse(json['createdAt'].toString()),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.tryParse(json['updatedAt'].toString()),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'review': review,
        'rating': rating,
        'user': user?.toJson(), // Convert user object to JSON
        'provider': provider,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}

// New model for handling `user` data
class ReviewUser {
  String? id;
  String? name;
  String? email;
  String? photo;

  ReviewUser({this.id, this.name, this.email, this.photo});

  factory ReviewUser.fromJson(Map<String, dynamic> json) => ReviewUser(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        photo: json['photo'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'email': email,
        'photo': photo,
      };
}
