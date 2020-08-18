import 'dart:io';

import 'package:flutter/material.dart';
import './product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductProvider with ChangeNotifier {
  List<Product> _items = [
//    Product(
//      id: 'p1',
//      title: 'Red Shirt',
//      description: 'A red shirt - it is pretty red!',
//      price: 29.99,
//      imageUrl:
//          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
//    ),
//    Product(
//      id: 'p2',
//      title: 'Trousers',
//      description: 'A nice pair of trousers.',
//      price: 59.99,
//      imageUrl:
//          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
//    ),
//    Product(
//      id: 'p3',
//      title: 'Yellow Scarf',
//      description: 'Warm and cozy - exactly what you need for the winter.',
//      price: 19.99,
//      imageUrl:
//          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
//    ),
//    Product(
//      id: 'p4',
//      title: 'A Pan',
//      description: 'Prepare any meal you want.',
//      price: 49.99,
//      imageUrl:
//          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
//    ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favouritesItem {
    return _items.where((element) => element.isFavourite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAndAddToProducts() async {
    const url = "demourl";
    try {
      print("start");
      final response = await http.get(url);
      var productMap = json.decode(response.body) as Map<String, dynamic>;
      List<Product> plist = [];
      productMap.forEach((key, value) {
        plist.add(Product(
            id: key,
            title: value['title'],
            description: value['description'],
            isFavourite: value['isFavourite'],
            price: value['price'],
            imageUrl: value['imageUrl']));
      });
      _items = plist;
      notifyListeners();
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> addProduct(Product value) async {
    const url = "demourl";
//    const url = "https:demo";
    try {
      final response = await http.post(url,
          body: json.encode({
            "title": value.title,
            "description": value.description,
            "imageUrl": value.imageUrl,
            "price": value.price,
            "isFavourite": value.isFavourite
          }));

      var product = json.decode(response.body);

      //https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Gutenberg_Bible%2C_Lenox_Copy%2C_New_York_Public_Library%2C_2009._Pic_01.jpg/447px-Gutenberg_Bible%2C_Lenox_Copy%2C_New_York_Public_Library%2C_2009._Pic_01.jpg

      final newProduct = Product(
          id: product["name"],
          title: value.title,
          description: value.description,
          price: value.price,
          imageUrl: value.imageUrl);
      _items.add(newProduct);
      notifyListeners();
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> updateSingleProduct(String id, Product pdt) async {
    final productId = _items.indexWhere((element) => element.id == id);
    var existingProduct = items[productId];
    try {
      if (productId >= 0) {
        final url = "demourl";
//        final url = "http:firebase";
        final response = await http.patch(url,
            body: json.encode({
              "title": pdt.title,
              "description": pdt.description,
              "price": pdt.price,
              "imageUrl": pdt.imageUrl,
            }));

        if (response.statusCode >= 400) {
          throw HttpException('Could not update product.');
        }
        _items[productId] = pdt;
        notifyListeners();
      } else {
        print("....");
      }
    } catch (e) {
      print(e.toString());
      _items.removeAt(productId);
      _items.insert(productId, existingProduct);
      notifyListeners();
      throw e;
    }
  }

  Future<void> removeSingleItem(String productId) async {
    final url = "demourl";
    final existingProductIndex =
        _items.indexWhere((element) => element.id == productId);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}
