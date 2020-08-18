import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart' show Cart;
import '../widgets/CartItem.dart' show CartItem;
import '../provider/orders.dart' show OrderProvider;

class CartsScreen extends StatelessWidget {
  static const String routeName = "/cart";

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 24),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      "\$${cartData.totalAmount.toStringAsFixed(2)}",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.amber,
                  ),
                  NewFlatWidget(cartData: cartData)
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, index) => CartItem(
                id: cartData.items.values.toList()[index].id,
                price: cartData.items.values.toList()[index].price,
                quantity: cartData.items.values.toList()[index].quantity,
                title: cartData.items.values.toList()[index].title,
                productId: cartData.items.keys.toList()[index],
              ),
              itemCount: cartData.items.length,
            ),
          )
        ],
      ),
    );
  }
}

class NewFlatWidget extends StatefulWidget {
  const NewFlatWidget({
    Key key,
    @required this.cartData,
  }) : super(key: key);

  final Cart cartData;

  @override
  _NewFlatWidgetState createState() => _NewFlatWidgetState();
}

class _NewFlatWidgetState extends State<NewFlatWidget> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return (_isLoading)
        ? Padding(
            padding: EdgeInsets.all(5),
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
            ),
          )
        : FlatButton(
            child: Text(
              "ORDER NOW",
              style: TextStyle(color: Colors.amber),
            ),
            onPressed: (widget.cartData.totalAmount <= 0 || _isLoading)
                ? null
                : () async {
                    setState(() {
                      _isLoading = true;
                    });
                    await Provider.of<OrderProvider>(context, listen: false)
                        .addOrder(widget.cartData.items.values.toList(),
                            widget.cartData.totalAmount);
                    widget.cartData.clearOrder();
                    setState(() {
                      _isLoading = false;
                    });
                  },
          );
  }
}
