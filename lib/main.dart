import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

import './pages/index_page.dart';
import './provide/child_category.dart';

void main(){
  var providers = Providers();
  var childCategory = ChildCategory();
  providers
    ..provide(Provider<ChildCategory>.value(childCategory));
  runApp(ProviderNode(
    providers: providers,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: 'LifeShop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink
        ),
        home: IndexPage(),
      ),
    );
  }
}