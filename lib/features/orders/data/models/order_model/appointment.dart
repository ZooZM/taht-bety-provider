class Appointment {
  bool? isBooked;
  bool? isApproved;
  String? date;
  String? time;

  Appointment({
    this.isBooked,
    this.isApproved,
    this.date,
    this.time,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        isBooked: json['isBooked'] as bool?,
        isApproved: json['isApproved'] as bool?,
        date: json['date'] as String?,
        time: json['time'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'isBooked': isBooked,
        'isApproved': isApproved,
        'date': date,
        'time': time,
      };
}
