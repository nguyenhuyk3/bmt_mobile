class CinemaShowtime {
  final int id;
  final String name;
  final String city;
  final String location;

  CinemaShowtime({
    required this.id,
    required this.name,
    required this.city,
    required this.location,
  });

  factory CinemaShowtime.fromJson(Map<String, dynamic> json) {
    return CinemaShowtime(
      id: json['id'],
      name: json['name'],
      city: json['city'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'city': city,
      'location': location,
    };
  }
}
