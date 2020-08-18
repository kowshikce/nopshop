import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

class Product extends ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavourite = false});

  Future<void> toggleIsFavourite() async {
    var oldFavourite = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final url = "demourl";
    try {
      final response = await http.patch(url,
          body: json.encode({"isFavourite": isFavourite}));
      if (response.statusCode >= 400) {
        isFavourite = oldFavourite;
        notifyListeners();
      }
    } catch (e) {
      isFavourite = oldFavourite;
      notifyListeners();
      print(e.toString());
    }
  }
}
