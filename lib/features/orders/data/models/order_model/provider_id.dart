class ProviderId {
  String? id;
  String? name;
  String? email;
  String? photo;

  ProviderId({this.id, this.name, this.email, this.photo});

  factory ProviderId.fromJson(Map<String, dynamic> json) => ProviderId(
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
