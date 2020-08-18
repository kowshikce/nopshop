import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/products_provider.dart';
import 'package:nopshop/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem({this.id, this.title, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                try {
                  await Provider.of<ProductProvider>(context, listen: false)
                      .removeSingleItem(id);
                  scaffold.showSnackBar(SnackBar(
                    content: Text(
                      "Product Deleted Successfully",
                      style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontStyle: FontStyle.italic,
                          fontFamily: "Lato",
                          fontWeight: FontWeight.w600),
                    ),
                    backgroundColor: Colors.black87,
                    duration: Duration(seconds: 1),
                  ));
                } catch (e) {
                  scaffold.showSnackBar(SnackBar(
                    content: Text(
                      "Error Deleting Product.",
                      style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontStyle: FontStyle.italic,
                          fontFamily: "Lato"),
                    ),
                    backgroundColor: Colors.black87,
                    action: SnackBarAction(
                      label: "okay",
                      onPressed: () {},
                    ),
                    duration: Duration(seconds: 1),
                  ));
                }
              },
              color: Theme.of(context).errorColor,
            )
          ],
        ),
      ),
    );
  }
}
