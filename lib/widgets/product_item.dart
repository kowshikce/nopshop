import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../provider/cart.dart';
import 'package:nopshop/provider/product.dart';
import 'package:provider/provider.dart';
import '../screens/product_detail_screen.dart';
import '../screens/products_overview_screen.dart';

class ProductItem extends StatelessWidget {
//  final String id;
//  final String title;
//  final String imageUrl;
//
//  ProductItem(
//      {@required this.id, @required this.title, @required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black45,
          title: Text(product.title),
          leading: Consumer<Product>(
            builder: (ctx, product, _) {
              return IconButton(
                  icon: Icon(
                    (product.isFavourite)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    size: 22,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () {
                    product.toggleIsFavourite();
                  });
            },
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              size: 22,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              cart.addCardItem(product.id, product.title, product.price);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Added Item to The Cart",
                  ),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: "UNDO",
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
