// FILE: example/lib/examples/ecommerce/product_model.dart
class Product {
  final String name;
  final String price;
  final String oldPrice;
  final String discount;
  final String description;
  final String imageUrl;
  final double rating;
  final int reviewCount;

  const Product({
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
  });
}

const sampleProduct = Product(
  name: 'Modern Geometric Lamp - Premium Edition',
  price: '\$299.99',
  oldPrice: '\$399.99',
  discount: '25% OFF',
  description:
      'A stunning piece of modern art and functionality. This geometric lamp provides warm, ambient lighting, perfect for any contemporary living space. Crafted with precision from high-quality materials, it features an energy-efficient LED system with adjustable brightness settings.',
  imageUrl: 'https://picsum.photos/id/1060/800/600',
  rating: 4.8,
  reviewCount: 142,
);
