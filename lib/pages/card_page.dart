import 'package:datashare2/models/cart_model.dart';
import 'package:datashare2/provider/card_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardPage extends StatelessWidget {
  const CardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Card page",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange,
          ),
        ),
      ),
      body: Consumer<CardProvider>(
        builder: (
          BuildContext context,
          CardProvider cardProvider,
          Widget? child,
        ) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cardProvider.items.length,
                  itemBuilder: (context, index) {
                    final CartItem cartItem =
                        cardProvider.items.values.toList()[index];
                    return Container(
                      margin: const EdgeInsets.only(
                        bottom: 10,
                        left: 5,
                        right: 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(136, 235, 150, 23),
                      ),
                      child: ListTile(
                        title: Text(
                          cartItem.title,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cartItem.id,
                            ),
                            Text(
                              "\$${cartItem.price} x ${cartItem.quantity}",
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                cardProvider.removeSingleItem(cartItem.id);
                              },
                              icon: const Icon(
                                Icons.remove,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                cardProvider.removeItem(cartItem.id);
                              },
                              icon: const Icon(
                                Icons.remove_shopping_cart,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Total \$${cardProvider.totalAmount.toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () {
                        cardProvider.clearAll();
                      },
                      child: const Text(
                        "Clear Card",
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
