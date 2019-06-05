import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

import '../provide/goods_detail_provide.dart';
import './goods_detail/top_area.dart';
import './goods_detail/explain_area.dart';

class GoodsDetailPage extends StatelessWidget {
  final String goodsId;
  GoodsDetailPage(this.goodsId);

  Future _getGoodsInfo(BuildContext context) async{
    await Provide.value<GoodsDetailProvide>(context).getGoodsDetailInfo(goodsId);
    return '完成加载';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text('商品详情'),
      ),
      body: FutureBuilder(
        future: _getGoodsInfo(context),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return Container(
              child: Column(
                children: <Widget>[
                  GoodsDetailTopArea(),
                  GoodsDetailExplainArea()
                ],
              ),
            );
          } else {
            return Text('正在加载..');
          }
        },
      )
    );
  }
}