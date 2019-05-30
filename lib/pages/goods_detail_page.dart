import 'package:flutter/material.dart';

class GoodsDetailPage extends StatelessWidget {
  final String goodsId;
  GoodsDetailPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:Center(
          child: Text('商品ID: $goodsId'),
        )
      ),
    );
  }
}