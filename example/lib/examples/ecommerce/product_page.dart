// FILE: example/lib/examples/ecommerce/product_page.dart
import 'package:flutter/material.dart';
import 'package:fit_ui/fit_ui.dart';
import 'product_model.dart';

class ProductPage extends StatelessWidget {
  final Product product;

  const ProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _MobileTabletLayout(product: product),
      tablet: _MobileTabletLayout(product: product),
      desktop: _DesktopLayout(product: product),
    );
  }
}

class _MobileTabletLayout extends StatelessWidget {
  final Product product;

  const _MobileTabletLayout({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            pinned: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: _MobileImageGrid(),
          ),
          SliverToBoxAdapter(
            child: _ProductContent(
              product: product,
              isDesktopLayout: false,
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.chat_outlined),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
          Expanded(
            child: FilledButton(
              onPressed: () {},
              child: const Text('Add to Cart'),
            ),
          ),
        ],
      ),
    );
  }
}

class _MobileImageGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: constraints.value(
            const ResponsiveValue(
              EdgeInsets.symmetric(horizontal: 16.0),
              tablet: EdgeInsets.symmetric(horizontal: 24.0),
              desktop: EdgeInsets.zero,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              SizedBox(
                height: constraints.value(
                  const ResponsiveValue(100.0, tablet: 120.0, desktop: 150.0),
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    final spacing = constraints.value(
                      const ResponsiveValue(12.0, tablet: 16.0, desktop: 20.0),
                    );

                    return Padding(
                      padding: EdgeInsets.only(right: spacing),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          constraints.value(
                            const ResponsiveValue(8.0,
                                tablet: 10.0, desktop: 12.0),
                          ),
                        ),
                        child: Image.network(
                          'https://picsum.photos/id/${1060 + index}/200/200',
                          width: constraints.value(
                            const ResponsiveValue(100.0,
                                tablet: 120.0, desktop: 150.0),
                          ),
                          height: constraints.value(
                            const ResponsiveValue(100.0,
                                tablet: 120.0, desktop: 150.0),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  final Product product;

  const _DesktopLayout({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(product.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _DesktopImageGrid(),
                ],
              ),
            ),
            const SizedBox(width: 40),
            Expanded(
              flex: 4,
              child: SingleChildScrollView(
                child: _ProductContent(
                  product: product,
                  isDesktopLayout: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DesktopImageGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(
                  'https://picsum.photos/id/${1060 + index}/200/200'),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}

class _ProductContent extends StatelessWidget {
  final Product product;
  final bool isDesktopLayout;

  const _ProductContent({
    required this.product,
    this.isDesktopLayout = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: constraints.value(
            const ResponsiveValue(
              EdgeInsets.all(16.0),
              tablet: EdgeInsets.all(24.0),
              desktop: EdgeInsets.zero,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductTitle(constraints),
              const SizedBox(height: 16),
              _buildRatingSection(),
              const SizedBox(height: 16),
              _buildPriceSection(),
              const SizedBox(height: 24),
              _buildColorSelector(),
              const SizedBox(height: 24),
              _buildProductDescription(constraints),
              const SizedBox(height: 24),
              _buildSpecifications(),
              const SizedBox(height: 24),
              _buildActionButtons(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProductTitle(BoxConstraints constraints) {
    final titleSize = constraints.value(
      const ResponsiveValue(24.0, tablet: 28.0, desktop: 32.0),
    );

    return Text(
      product.name,
      style: TextStyle(
        fontSize: titleSize,
        fontWeight: FontWeight.bold,
        height: 1.2,
      ),
    );
  }

  Widget _buildRatingSection() {
    return Row(
      children: [
        Wrap(
          children: List.generate(
              5,
              (index) => Icon(
                    Icons.star,
                    color: index < product.rating.floor()
                        ? Colors.amber
                        : Colors.grey,
                    size: 16,
                  )),
        ),
        const SizedBox(width: 8),
        Text(
          '${product.rating} (${product.reviewCount} reviews)',
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildPriceSection() {
    return Row(
      children: [
        Text(
          product.price,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 16),
        Text(
          product.oldPrice,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.grey,
            decoration: TextDecoration.lineThrough,
          ),
        ),
        const SizedBox(width: 16),
        Text(
          product.discount,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildColorSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Color',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          children: [
            _ColorOption(Colors.black, 'Black', true),
            _ColorOption(Colors.grey[700]!, 'Gray', false),
            _ColorOption(Colors.brown, 'Brown', false),
            _ColorOption(Colors.blueGrey, 'Slate', false),
          ],
        ),
      ],
    );
  }

  Widget _buildProductDescription(BoxConstraints constraints) {
    final bodySize = constraints.value(
      const ResponsiveValue(15.0, tablet: 16.0, desktop: 16.0),
    );

    return Text(
      product.description,
      style: TextStyle(fontSize: bodySize, height: 1.5),
    );
  }

  Widget _buildSpecifications() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Specifications',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _SpecItem('Material', 'Aluminum, Glass'),
        _SpecItem('Dimensions', 'H 45cm × W 25cm × D 25cm'),
        _SpecItem('Weight', '2.5 kg'),
        _SpecItem('Light Source', 'LED (included)'),
        _SpecItem('Wattage', '15W'),
        _SpecItem('Color Temperature', '3000K (Warm White)'),
      ],
    );
  }

  Widget _buildActionButtons() {
    if (isDesktopLayout) {
      return Row(
        children: [
          Expanded(
            child: FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Add to Cart'),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Add to Wishlist'),
            ),
          ),
        ],
      );
    } else {
      return const SizedBox.shrink(); // Mobile has bottom bar
    }
  }
}

class _ColorOption extends StatelessWidget {
  final Color color;
  final String label;
  final bool selected;

  const _ColorOption(this.color, this.label, this.selected);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
              color: selected ? Colors.blue : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: selected ? Colors.blue : Colors.grey,
          ),
        ),
      ],
    );
  }
}

class _SpecItem extends StatelessWidget {
  final String title;
  final String value;

  const _SpecItem(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
