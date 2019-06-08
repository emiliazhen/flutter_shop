import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class GoodsDetailBottomBarProvide with ChangeNotifier {
  String cartListString = '[]';

  add(id,name,price,img) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartListString = prefs.get('cartInfo') ?? '[]';
    dynamic temp = cartListString==null ? [] : json.decode(cartListString.toString());
    List<Map> tempList = (temp as List).cast();
    bool isHave = false;
    for(Map item in tempList){
      if(item['goodsId'] == id){
        item['count']++;
        isHave = true;
      }
    }
    if(!isHave){
      tempList.add({
        'goodsId': id,
        'goodsName': name,
        'count': 1,
        'price': price,
        'images': img,
      });
    }
    cartListString = json.encode(tempList).toString();
    print(cartListString);
    prefs.setString('cartInfo', cartListString);
    notifyListeners();
  }

  clear()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo');
    notifyListeners();
  }
}
