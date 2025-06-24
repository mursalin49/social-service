class Cleaner {
  final String name;
  final String phone;
  final String location;
  final String availability;
  final String image;

  Cleaner({
    required this.name,
    required this.phone,
    required this.location,
    required this.availability,
    required this.image,
  });

  factory Cleaner.fromJson(Map<dynamic, dynamic> json) {
    return Cleaner(
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      location: json['location'] ?? '',
      availability: json['availability'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
