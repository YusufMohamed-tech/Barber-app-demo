class AdminBarberModel {
  const AdminBarberModel({
    required this.id,
    required this.name,
    required this.specialty,
    required this.phone,
    required this.imageUrl,
    required this.rating,
    required this.status,
    required this.bio,
  });

  final String id;
  final String name;
  final String specialty;
  final String phone;
  final String imageUrl;
  final double rating;
  final String status;
  final String bio;

  bool get isActive => status == 'نشط';

  AdminBarberModel copyWith({
    String? id,
    String? name,
    String? specialty,
    String? phone,
    String? imageUrl,
    double? rating,
    String? status,
    String? bio,
  }) {
    return AdminBarberModel(
      id: id ?? this.id,
      name: name ?? this.name,
      specialty: specialty ?? this.specialty,
      phone: phone ?? this.phone,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      status: status ?? this.status,
      bio: bio ?? this.bio,
    );
  }
}
