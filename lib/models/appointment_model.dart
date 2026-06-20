class AppointmentModel {
  const AppointmentModel({
    required this.id,
    required this.serviceName,
    required this.barberName,
    required this.date,
    required this.time,
    required this.status,
    required this.price,
  });

  final String id;
  final String serviceName;
  final String barberName;
  final String date;
  final String time;
  final String status;
  final int price;

  String get formattedPrice => '$price جنيه';
}
