import 'package:datashare2/pages/product_page.dart';
import 'package:datashare2/provider/card_provider.dart';
import 'package:datashare2/provider/fav_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CardProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductPage(),
    );
  }
}
