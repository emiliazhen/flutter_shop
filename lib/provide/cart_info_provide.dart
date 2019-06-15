import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:toast/toast.dart';

import '../model/cart_info.dart';

class CartInfoProvide with ChangeNotifier {
  String cartListString = '[]';
  List<CartInfoModel> cartList = [];
  double priceTotal = 0;
  int countTotal = 0;
  bool allChecked = true;

  getCartInfo() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartListString = prefs.get('cartInfo') ?? '[]';
    cartList = [];
    priceTotal = 0;
    countTotal = 0;
    allChecked = true;
    (json.decode(cartListString.toString()) as List).cast().forEach((item){
      cartList.add(CartInfoModel.fromJson(item));
      if(item['checked']){
        priceTotal += item['price'] * item['count'];
        countTotal += item['count'];
      }else{
        allChecked = false;
      }
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
    priceTotal = 0;
    countTotal = 0;
    tempList.forEach((item){
      if(item['goodsId'] == id){
        tempList[arrIndex]['count'] = item['count']+1;
        cartList[arrIndex].count++;
        isHave = true;
      }
      if(item['checked']){
        priceTotal += cartList[arrIndex].price * cartList[arrIndex].count;
        countTotal += cartList[arrIndex].count;
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
      priceTotal += price;
      countTotal += 1;
    }
    cartListString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartListString);
    notifyListeners();
  }

  deleteCartItem(String id) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartList.removeWhere((item) => item.goodsId == id);
    cartListString = json.encode(cartList).toString();
    prefs.setString('cartInfo', cartListString);
    await getCartInfo();
  }

  clearCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo');
    priceTotal = 0;
    countTotal = 0;
    cartList = [];
    notifyListeners();
  }

  changeCartItemCheck(String id,bool checked) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int tmpIndex = cartList.indexWhere((item) => item.goodsId == id);
    cartList[tmpIndex].checked = checked;
    cartListString = json.encode(cartList).toString();
    prefs.setString('cartInfo', cartListString);
    await getCartInfo();
  }

  changeCartAllCheck(bool checked) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartListString=prefs.getString('cartInfo'); 
    List<Map> tempList= (json.decode(cartListString.toString()) as List).cast(); 
    List<Map> newList=[]; //新建一个List，用于组成新的持久化数据。
    for(var item in tempList ){
      var newItem = item; //复制新的变量，因为Dart不让循环时修改原值
      newItem['checked']=checked; //改变选中状态
      newList.add(newItem);
    }
    cartListString = json.encode(newList).toString();
    prefs.setString('cartInfo', cartListString);
    await getCartInfo();
  }

  cartItemCountAdd(String id,BuildContext context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int tmpIndex = cartList.indexWhere((item) => item.goodsId == id);
    if(cartList[tmpIndex].count >= 99){
        Toast.show('该商品不能购买更多了',context,duration:Toast.LENGTH_SHORT,gravity:Toast.CENTER);
    }else{
      cartList[tmpIndex].count++;
    }
    cartListString = json.encode(cartList).toString();
    prefs.setString('cartInfo', cartListString);
    await getCartInfo();
  }

  cartItemCountReduce(String id,BuildContext context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int tmpIndex = cartList.indexWhere((item) => item.goodsId == id);
    if(cartList[tmpIndex].count == 1){
        Toast.show('该商品不能再减少了',context,duration:Toast.LENGTH_SHORT,gravity:Toast.CENTER);
    }else{
      cartList[tmpIndex].count--;
    }
    cartListString = json.encode(cartList).toString();
    prefs.setString('cartInfo', cartListString);
    await getCartInfo();
  }
}
