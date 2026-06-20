class BarberModel {
  const BarberModel({
    required this.id,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.reviews,
    required this.imageUrl,
    required this.status,
  });

  final String id;
  final String name;
  final String specialty;
  final double rating;
  final String reviews;
  final String imageUrl;
  final String status;
}
