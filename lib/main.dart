import 'package:e_commerce/providers/auth_provider.dart';
import 'package:e_commerce/providers/cart_notifier.dart';
import 'package:e_commerce/providers/order_notifier.dart';
import 'package:e_commerce/providers/theme_provider.dart';
import 'package:e_commerce/screens/inner_screens/viewed_recently.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'consts/theme_data.dart';
import 'root_screen.dart';
import 'screens/inner_screens/product_details.dart';
import 'screens/inner_screens/wishlist.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(create: (_) => CartNotefier()),
        ChangeNotifierProvider(create: (_) => OrderNotifier()),
        ChangeNotifierProvider(create: (_)=>LoginNotifier())
      ],
      child: Consumer<ThemeProvider>(builder: (
        context,
        themeProvider,
        child,
      ) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Shop Smart AR',
          theme: Styles.themeData(
              isDarkTheme: themeProvider.getIsDarkTheme, context: context),
          home: const RootScreen(),
          routes: {
            WishlistScreen.routName: (context) => const WishlistScreen(),
            ViewedRecentlyScreen.routName: (context) =>
                const ViewedRecentlyScreen()
          },
        );
      }),
    );
  }
}
