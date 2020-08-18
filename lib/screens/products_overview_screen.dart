import 'package:flutter/material.dart';
import 'package:nopshop/provider/cart.dart';
import 'package:nopshop/screens/CartsScreen.dart';
import 'package:nopshop/widgets/MainDrawer.dart';
import '../widgets/badge.dart';
import '../provider/products_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/product_item.dart';
import '../provider/product.dart';

enum FilterOptions { Favorites, ALl }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var isFavourite = false;
  var _isInit = true;
  var _isLoading = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_isInit) {
      Provider.of<ProductProvider>(context).fetchAndAddToProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      }).catchError((e) {
        setState(() {
          _isLoading = false;
        });
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("error: $e"),
          duration: Duration(seconds: 2),
        ));
      });
    }
    _isInit = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyShop"),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.ALl) {
                  isFavourite = false;
                }
                if (selectedValue == FilterOptions.Favorites) {
                  isFavourite = true;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text("Only Favorites"),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text("Show All"),
                value: FilterOptions.ALl,
              )
            ],
          ),
          Consumer<Cart>(
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartsScreen.routeName);
                },
              ),
              builder: (ctx, cartData, chi) => Badge(
                    child: chi,
                    value: cartData.itemCount.toString(),
                  )),
        ],
      ),
      body: (_isLoading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductGrid(isFavourite),
      drawer: MainDrawer(),
    );
  }
}

class ProductGrid extends StatelessWidget {
  final bool filterFavourite;

  ProductGrid(this.filterFavourite);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);
    final products =
        filterFavourite ? productData.favouritesItem : productData.items;
    print(products.length);
    return RefreshIndicator(
      onRefresh: () =>
          Provider.of<ProductProvider>(context).fetchAndAddToProducts(),
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 3 / 2),
        itemBuilder: (ctx, i) {
          return ChangeNotifierProvider.value(
            value: products[i],
            child: ProductItem(
//            id: products[i].id,
//            title: products[i].title,
//            imageUrl: products[i].imageUrl);

                ),
          );
        },
      ),
    );
  }
}
