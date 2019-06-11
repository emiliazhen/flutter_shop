import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../model/cart_info.dart';

class CartInfoProvide with ChangeNotifier {
  String cartListString = '[]';
  List<CartInfoModel> cartList = [];

  getCartInfo() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartListString = prefs.get('cartInfo') ?? '[]';
    cartList = [];
    (json.decode(cartListString.toString()) as List).cast().forEach((item){
      cartList.add(CartInfoModel.fromJson(item));
    });
    notifyListeners();
  }

  addCart(id,name,price,img) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartListString = prefs.get('cartInfo') ?? '[]';
    dynamic temp = cartListString==null ? [] : json.decode(cartListString.toString());
    List<Map> tempList = (temp as List).cast();
    bool isHave = false;
    int arrIndex = 0;
    tempList.forEach((item){
      if(item['goodsId'] == id){
        item['count']++;
        cartList[arrIndex].count++;
        isHave = true;
      }
      arrIndex++;
    });
    if(!isHave){
      dynamic newGoods = {
        'goodsId': id,
        'goodsName': name,
        'count': 1,
        'price': price,
        'images': img,
        'checked': true
      };
      tempList.add(newGoods);
      cartList.add(CartInfoModel.fromJson(newGoods));
    }
    cartListString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartListString);
    notifyListeners();
  }

  deleteCartItem(String id) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < cartList.length; i++) {
      if(cartList[i].goodsId == id){
        cartList.removeAt(i);
        break;
      }
    }
    cartListString = json.encode(cartList).toString();
    prefs.setString('cartInfo', cartListString);
    notifyListeners();
  }

  clearCart()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo');
    notifyListeners();
  }
}
