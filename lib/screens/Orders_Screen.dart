import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/orders.dart' show OrderProvider;
import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const String routeName = "/orders";

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      Provider.of<OrderProvider>(context, listen: false).fetchAndUpdateOrder();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<OrderProvider>(context);
    final mediaQury = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Provider.of<OrderProvider>(context).fetchAndUpdateOrder();
        },
        child: (ordersData.orders.length <= 0)
            ? ListView(
                children: <Widget>[
                  Container(
                    height: mediaQury.size.height -
                        mediaQury.padding.top -
                        mediaQury.padding.bottom,
                    width: mediaQury.size.width,
                    padding: EdgeInsets.all(5),
                    child: Center(
                      child: Text(
                        "No Orders!",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Colors.amber),
                      ),
                    ),
                  )
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) =>
                    OrderItem(ordersData.orders[index]),
                itemCount: ordersData.orders.length,
              ),
      ),
    );
  }
}
