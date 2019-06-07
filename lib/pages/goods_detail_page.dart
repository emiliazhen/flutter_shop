import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

import '../provide/goods_detail_provide.dart';
import './goods_detail/top_area.dart';
import './goods_detail/explain_area.dart';
import './goods_detail/context_tab_bar.dart';
import './goods_detail/tab_context.dart';
import './goods_detail/bottom_bar.dart';

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
        title: Text(
          '商品详情'
        ),
      ),
      body: FutureBuilder(
        future: _getGoodsInfo(context),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      GoodsDetailTopArea(),
                      GoodsDetailExplainArea(),
                      GoodsDetailContextTabBar(),
                      GoodsDetailTabContext()
                    ],
                  ),
                ),
                GoodsDetailBottomBar()
              ],
            );
          } else {
            return Text('正在加载..');
          }
        },
      )
    );
  }
}