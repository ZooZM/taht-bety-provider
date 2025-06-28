class LastPaymobTopup {
  String? status;

  LastPaymobTopup({this.status});

  factory LastPaymobTopup.fromJson(Map<String, dynamic> json) {
    return LastPaymobTopup(
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
      };
}
