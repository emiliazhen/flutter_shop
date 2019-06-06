import 'package:flutter/material.dart';
import '../model/goods_detail.dart';
import '../service/service_method.dart';
import 'dart:convert';

class GoodsDetailProvide with ChangeNotifier{
  GoodsDetailModol goodsDetailInfo;
  bool isLeft = true;

  getGoodsDetailInfo(String id) async{
    await request('getGoodDetailById',{'goodId':id}).then((res){
      dynamic responseData = json.decode(res.toString());
      goodsDetailInfo = GoodsDetailModol.fromJson(responseData);
      notifyListeners();
    });
  }

  changeTabBar(bool isLeftClick){
    isLeft = isLeftClick;
    notifyListeners();
  }
}