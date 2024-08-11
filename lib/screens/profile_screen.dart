import 'package:e_commerce/providers/auth_provider.dart';
import 'package:e_commerce/screens/auth/login.dart';
import 'package:e_commerce/screens/inner_screens/orders_screen.dart';
import 'package:e_commerce/screens/inner_screens/viewed_recently.dart';
import 'package:e_commerce/screens/inner_screens/wishlist.dart';
import 'package:e_commerce/widgets/app_name_text.dart';
import 'package:e_commerce/widgets/subtitle_text.dart';
import 'package:e_commerce/widgets/title_text.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../services/assets_manager.dart';
import '../widgets/custom_list_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginNotifier>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isLoggedInd = loginProvider.isLoggedIn;
    return isLoggedInd
        ? Scaffold(
            appBar: AppBar(
              title: const AppNameTextWidget(fontSize: 20),
              actions: [
                IconButton(
                    onPressed: () {
                      themeProvider.setDarkTheme(
                          themeValue: !themeProvider.getIsDarkTheme);
                    },
                    icon: themeProvider.buttonIcon)
              ],
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AssetsManager.shoppingCart),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Visibility(
                    visible: false,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: TitlesTextWidget(
                          label: "Please login to have ultimate access"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).cardColor,
                            border: Border.all(
                                color: Theme.of(context).colorScheme.background,
                                width: 3),
                            image: const DecorationImage(
                              image: NetworkImage(
                                "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png",
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitlesTextWidget(label: "Mustafa Khaled"),
                            SubtitleTextWidget(label: "mustafa2213@gmail.com"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TitlesTextWidget(label: "General"),
                        CustomListTile(
                          imagePath: AssetsManager.orderSvg,
                          text: "All orders",
                          function: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return OrdersScreen();
                              },
                            ));
                          },
                        ),
                        CustomListTile(
                          imagePath: AssetsManager.wishlistSvg,
                          text: "Wishlist",
                          function: () {
                            Navigator.pushNamed(
                                context, WishlistScreen.routName);
                          },
                        ),
                        CustomListTile(
                          imagePath: AssetsManager.recent,
                          text: "Viewed recently",
                          function: () {
                            Navigator.pushNamed(
                                context, ViewedRecentlyScreen.routName);
                          },
                        ),
                        CustomListTile(
                          imagePath: AssetsManager.address,
                          text: "Address",
                          function: () {},
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        const TitlesTextWidget(label: "Settings"),
                        const SizedBox(
                          height: 7,
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            30,
                          ),
                        ),
                      ),
                      onPressed: () {
                        loginProvider.logout();
                      },
                      icon: const Icon(Icons.logout, color: Colors.white),
                      label: const Text(
                        "Logout",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ))
        : const NotLoggedInScreen();
  }
}

class NotLoggedInScreen extends StatelessWidget {
  const NotLoggedInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const AppNameTextWidget(
          fontSize: 20,
        ),
        actions: [
          IconButton(
              onPressed: () {
                themeProvider.setDarkTheme(
                    themeValue: !themeProvider.getIsDarkTheme);
              },
              icon: themeProvider.buttonIcon)
        ],
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.shoppingCart),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 60,
            ),
            Image.asset(
              AssetsManager.shoppingCart,
              width: 200,
            ),
            const SizedBox(
              height: 10,
            ),
            const AppNameTextWidget(),
            const SizedBox(
              height: 80,
            ),
            const TitlesTextWidget(
                label: 'You Must Login To Visit The Profile Screen',
                color: Colors.blue),
            const SizedBox(
              height: 60,
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      30,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return const LoginScreen();
                  }));
                },
                icon: const Icon(
                  Icons.login,
                  color: Colors.white,
                ),
                label: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
