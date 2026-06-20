class AdminBookingModel {
  const AdminBookingModel({
    required this.id,
    required this.clientName,
    required this.clientPhone,
    required this.serviceName,
    required this.barberName,
    required this.date,
    required this.time,
    required this.duration,
    required this.price,
    required this.paymentMethod,
    required this.notes,
    required this.status,
  });

  final String id;
  final String clientName;
  final String clientPhone;
  final String serviceName;
  final String barberName;
  final String date;
  final String time;
  final String duration;
  final int price;
  final String paymentMethod;
  final String notes;
  final String status;

  String get formattedPrice => '$price جنيه';

  AdminBookingModel copyWith({
    String? id,
    String? clientName,
    String? clientPhone,
    String? serviceName,
    String? barberName,
    String? date,
    String? time,
    String? duration,
    int? price,
    String? paymentMethod,
    String? notes,
    String? status,
  }) {
    return AdminBookingModel(
      id: id ?? this.id,
      clientName: clientName ?? this.clientName,
      clientPhone: clientPhone ?? this.clientPhone,
      serviceName: serviceName ?? this.serviceName,
      barberName: barberName ?? this.barberName,
      date: date ?? this.date,
      time: time ?? this.time,
      duration: duration ?? this.duration,
      price: price ?? this.price,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      notes: notes ?? this.notes,
      status: status ?? this.status,
    );
  }
}
