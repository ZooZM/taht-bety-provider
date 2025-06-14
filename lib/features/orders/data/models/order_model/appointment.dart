class Appointment {
  bool? isBooked;
  bool? isApproved;

  Appointment({this.isBooked, this.isApproved});

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        isBooked: json['isBooked'] as bool?,
        isApproved: json['isApproved'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'isBooked': isBooked,
        'isApproved': isApproved,
      };
}
