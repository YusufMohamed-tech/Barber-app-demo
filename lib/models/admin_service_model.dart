class AdminServiceModel {
  const AdminServiceModel({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.duration,
    required this.price,
    required this.imageUrl,
  });

  final String id;
  final String name;
  final String category;
  final String description;
  final String duration;
  final int price;
  final String imageUrl;

  String get formattedPrice => '$price جنيه';

  AdminServiceModel copyWith({
    String? id,
    String? name,
    String? category,
    String? description,
    String? duration,
    int? price,
    String? imageUrl,
  }) {
    return AdminServiceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
