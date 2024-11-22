import 'package:datashare2/data/product_data.dart';
import 'package:datashare2/models/product_model.dart';
import 'package:datashare2/provider/fav_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favourite page",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange,
          ),
        ),
      ),
      body: Consumer<FavProvider>(
        builder: (
          BuildContext context,
          FavProvider favProvider,
          Widget? child,
        ) {
          final favItems = favProvider.fav.entries
              .where((entry) => entry.value)
              .map((entry) => entry.key)
              .toList();

          if (favItems.isEmpty) {
            return const Center(
              child: Text("No favourite added yet"),
            );
          }
          return ListView.builder(
            itemCount: favItems.length,
            itemBuilder: (context, index) {
              final productId = favItems[index];

              final Product product = ProductData()
                  .products
                  .firstWhere((product) => product.id == productId);
              return Card(
                child: ListTile(
                  title: Text(
                    product.title,
                  ),
                  subtitle: Text(
                    "\$${product.price}",
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      favProvider.toggleFav(product.id);
                    },
                    icon: const Icon(
                      Icons.delete,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
