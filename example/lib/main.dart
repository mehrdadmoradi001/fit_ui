// FILE: example/lib/examples/main.dart

import 'package:flutter/material.dart';

import 'examples/ecommerce/product_model.dart';
import 'examples/ecommerce/product_page.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fit UI Examples',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fit UI Examples'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('E-commerce Product Page'),
            subtitle: const Text('Responsive product page example'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductPage(product: sampleProduct),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard Example'),
            subtitle: const Text('Coming soon...'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('Chat App Example'),
            subtitle: const Text('Coming soon...'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
