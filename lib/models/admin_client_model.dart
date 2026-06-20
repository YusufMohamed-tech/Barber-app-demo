class AdminClientModel {
  const AdminClientModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.bookingsCount,
    required this.imageUrl,
    required this.lastBooking,
    required this.favoriteService,
  });

  final String id;
  final String name;
  final String phone;
  final int bookingsCount;
  final String imageUrl;
  final String lastBooking;
  final String favoriteService;
}
