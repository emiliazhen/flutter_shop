import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:fluro/fluro.dart';

import './pages/index_page.dart';
import './provide/child_category.dart';
import './provide/category_goods_list.dart';
import './provide/goods_detail_provide.dart';
import './provide/goods_detail_bottom_bar_provide.dart';
import './routers/staticize.dart';
import './routers/routers.dart';

void main(){
  Providers providers = Providers();
  ChildCategory childCategory = ChildCategory();
  CategoryGoodsListProvide categoryGoodsListProvide = CategoryGoodsListProvide();
  GoodsDetailProvide goodsDetailProvide = GoodsDetailProvide();
  GoodsDetailBottomBarProvide goodsDetailBottomBarProvide = GoodsDetailBottomBarProvide();
  providers
    ..provide(Provider<ChildCategory>.value(childCategory))
    ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide))
    ..provide(Provider<GoodsDetailProvide>.value(goodsDetailProvide))
    ..provide(Provider<GoodsDetailBottomBarProvide>.value(goodsDetailBottomBarProvide));
  runApp(ProviderNode(
    providers: providers,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = Router();
    Routers.configureRoutes(router);
    Staticize.router = router;

    return Container(
      child: MaterialApp(
        title: 'LifeShop',
        onGenerateRoute: Staticize.router.generator,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink
        ),
        home: IndexPage(),
      ),
    );
  }
}