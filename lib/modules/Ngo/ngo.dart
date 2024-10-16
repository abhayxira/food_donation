class Ngo {
  final String name;
  final double rating;
  final int reviewsCount;
  final String imageUrl;
  final String description; // Added description field

  Ngo({
    required this.name,
    required this.rating,
    required this.reviewsCount,
    required this.imageUrl,
    required this.description, // Initialize description field
  });
}
