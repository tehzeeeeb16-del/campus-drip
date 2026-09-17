import 'package:flutter/material.dart';

void main() => runApp(const CampusDripApp());

class Product {
  final String name, category, image;
  final int price;
  const Product(this.name, this.category, this.image, this.price);
}

const products = <Product>[
  Product('Classic White Shirt', 'Shirts', 'shirt.jpg', 999),
  Product('Black T-Shirt', 'T-Shirts', 'tshirt_black.jpg', 599),
  Product('White T-Shirt', 'T-Shirts', 'tshirt_white.jpg', 599),
  Product('Grey Hoodie', 'Hoodies', 'hoodie_grey.jpg', 1299),
  Product('Black Hoodie', 'Hoodies', 'hoodie_black.jpg', 1299),
  Product('Light Blue Jeans', 'Pants', 'jeans_light_blue.jpg', 1199),
  Product('Black Jeans', 'Pants', 'jeans_black.jpg', 1199),
  Product('Cargo Pants', 'Pants', 'cargo_pants.jpg', 1099),
  Product('Jogger Pants', 'Pants', 'jogger_pants.jpg', 899),
  Product('Beige Trousers', 'Pants', 'trousers_beige.jpg', 999),
  Product('Black Trousers', 'Pants', 'trousers_black.jpg', 999),
  Product('White Sneakers', 'Shoes', 'sneakers_white.jpg', 1499),
  Product('Black Sneakers', 'Shoes', 'sneakers_black.jpg', 1499),
  Product('High Top Sneakers', 'Shoes', 'high_top_sneakers.jpg', 1799),
  Product('Running Shoes', 'Shoes', 'running_shoes.jpg', 1599),
  Product('Slip-On Shoes', 'Shoes', 'slip_on_shoes.jpg', 999),
  Product('Black Boots', 'Shoes', 'boots_black.jpg', 1999),
];

class CampusDripApp extends StatelessWidget {
  const CampusDripApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'CAMPUS DRIP',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xfff7f7f7),
    ),
    home: const HomePage(),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selected = 'All';
  final cart = <Product>[];

  @override
  Widget build(BuildContext context) {
    final filtered = selected == 'All'
        ? products
        : products.where((p) => p.category == selected).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('CAMPUS DRIP', style: TextStyle(fontWeight: FontWeight.w900)),
        actions: [
          IconButton(
            tooltip: 'Cart',
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (_) => Padding(
                padding: const EdgeInsets.all(20),
                child: Text('Cart items: ${cart.length}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ),
            icon: Badge(label: Text('${cart.length}'), child: const Icon(Icons.shopping_bag_outlined)),
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
              Text('Fresh fits. Everyday drip.', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
              SizedBox(height: 5),
              Text('Shirts • T-Shirts • Hoodies • Pants • Shoes'),
            ]),
          )),
          SliverToBoxAdapter(child: SizedBox(
            height: 54,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              scrollDirection: Axis.horizontal,
              children: ['All','Shirts','T-Shirts','Hoodies','Pants','Shoes'].map((c) =>
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  child: ChoiceChip(
                    label: Text(c),
                    selected: selected == c,
                    onSelected: (_) => setState(() => selected = c),
                  ),
                )).toList(),
            ),
          )),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate((context, i) {
                final p = filtered[i];
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () => setState(() => cart.add(p)),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Expanded(child: Image.asset('assets/products/${p.image}', fit: BoxFit.cover, width: double.infinity)),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                        child: Text(p.name, maxLines: 2, overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 3, 10, 10),
                        child: Row(children: [
                          Text('₹${p.price}', style: const TextStyle(fontWeight: FontWeight.w900)),
                          const Spacer(),
                          const Icon(Icons.add_shopping_cart, size: 20),
                        ]),
                      )
                    ]),
                  ),
                );
              }, childCount: filtered.length),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: .72,
              ),
            ),
          )
        ],
      ),
    );
  }
}
