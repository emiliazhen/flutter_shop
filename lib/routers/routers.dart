import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import './router_handler.dart';

class Routers {
  static String root = '/';
  static String goodsDetailPage = '/goodDetail';
  static void configureRoutes(Router router){
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context,Map<String,List<String>> params){
        print('>>>>>>>> Router not Found');
      }
    );
    router.define(goodsDetailPage,handler:goodsDetailHandler);
  }
}