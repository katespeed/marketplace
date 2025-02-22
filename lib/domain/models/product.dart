class Product {
  final String id;
  final String name;
  final double price;
  final List<String> imageUrls;
  final String? description;
  final List<String>? categories;
  final String? size;
  final String? color;
  final double? rating;
  final int? reviewCount;
  final bool? isAvailable;
  final DateTime? saleEndDate;
  final String? brand;
  final double? rentalPrice;
  final String? sellerImageUrl;
  final String? sellerName;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrls,
    this.sellerImageUrl,
    this.sellerName,
    this.rentalPrice,
    this.description,
    this.categories,
    this.size,
    this.color,
    this.rating,
    this.reviewCount,
    this.isAvailable,
    this.saleEndDate,
    this.brand,
    // Add any other properties you need
  });
} 