import 'package:flutter/material.dart';
import 'package:nopshop/screens/edit_product_screen.dart';
import 'package:nopshop/widgets/MainDrawer.dart';
import 'package:provider/provider.dart';
import '../provider/products_provider.dart';
import '../widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  static const String routeName = "/user-products";

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("User Products"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            Provider.of<ProductProvider>(context).fetchAndAddToProducts(),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            itemBuilder: (ctx, index) => Column(
              children: <Widget>[
                UserProductItem(
                  id: productData.items[index].id,
                  title: productData.items[index].title,
                  imageUrl: productData.items[index].imageUrl,
                ),
                Divider(),
              ],
            ),
            itemCount: productData.items.length,
          ),
        ),
      ),
      drawer: MainDrawer(),
    );
  }
}
