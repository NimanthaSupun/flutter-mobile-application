import 'package:datashare2/data/product_data.dart';
import 'package:datashare2/models/product_model.dart';
import 'package:datashare2/pages/card_page.dart';
import 'package:datashare2/pages/favourite_page.dart';
import 'package:datashare2/provider/card_provider.dart';
import 'package:datashare2/provider/fav_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> products = ProductData().products;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Flutter shop",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange,
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "fav_button",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavouritePage(),
                ),
              );
            },
            backgroundColor: Colors.deepOrange,
            child: const Icon(
              Icons.favorite,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            heroTag: "shopping_button",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CardPage(),
                ),
              );
            },
            backgroundColor: Colors.deepOrange,
            child: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final Product product = products[index];
          return Card(
            child: Consumer2<CardProvider, FavProvider>(
              builder: (
                BuildContext context,
                CardProvider cardProvider,
                FavProvider favProvider,
                Widget? child,
              ) {
                return ListTile(
                  title: Row(
                    children: [
                      Text(
                        product.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        cardProvider.items.containsKey(product.id)
                            ? cardProvider.items[product.id]!.quantity
                                .toString()
                            : "0",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    "\$${product.price.toString()}",
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          favProvider.toggleFav(product.id);
                        },
                        icon: Icon(
                          favProvider.isFav(product.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: favProvider.isFav(product.id)
                              ? Colors.pinkAccent
                              : Colors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          cardProvider.addItem(
                            product.id,
                            product.price,
                            product.title,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Card is added",
                              ),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.shopping_cart,
                          color: cardProvider.items.containsKey(product.id)
                              ? Colors.orange
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
