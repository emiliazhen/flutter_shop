import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/goods_detail_page.dart';

Handler goodsDetailHandler = Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> params){
    String goodsId = params['id'].first;
    print('detailId is $goodsId');
    return GoodsDetailPage(goodsId);
  }
);