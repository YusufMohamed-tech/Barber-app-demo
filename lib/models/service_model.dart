class ServiceModel {
  const ServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.duration,
    required this.price,
    required this.imageUrl,
    required this.category,
  });

  final String id;
  final String name;
  final String description;
  final String duration;
  final int price;
  final String imageUrl;
  final String category;

  String get formattedPrice => '$price جنيه';
}
