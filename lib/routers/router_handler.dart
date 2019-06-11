import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import '../pages/goods_detail_page.dart';
import '../pages/cart_page.dart';

Handler goodsDetailHandler = Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> params){
    String goodsId = params['id'].first;
    return GoodsDetailPage(goodsId);
  }
);

Handler cartPageHandler = Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> params){
    return PageCart();
  }
);