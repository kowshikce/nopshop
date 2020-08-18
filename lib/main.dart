import 'package:flutter/material.dart';
import 'package:nopshop/provider/cart.dart';
import 'package:nopshop/provider/products_provider.dart';
import 'package:nopshop/screens/CartsScreen.dart';
import 'package:nopshop/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import './screens/products_overview_screen.dart';
import './provider/orders.dart';
import './screens/Orders_Screen.dart';
import './screens/UsersProductScreen.dart';
import './screens/edit_product_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ProductProvider(),
        ),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProvider.value(value: OrderProvider()),
      ],
      child: MaterialApp(
        title: "MyShop",
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartsScreen.routeName: (ctx) => CartsScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          UserProductScreen.routeName: (ctx) => UserProductScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
