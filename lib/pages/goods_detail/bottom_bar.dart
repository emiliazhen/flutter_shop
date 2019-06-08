import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import '../../provide/goods_detail_bottom_bar_provide.dart';
import '../../provide/goods_detail_provide.dart';

class GoodsDetailBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    dynamic goodsInfo = Provide.value<GoodsDetailProvide>(context).goodsDetailInfo.data.goodInfo;
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(80),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          InkWell(
            child:  Container(
              width: ScreenUtil().setWidth(110),
              child: Icon(
                Icons.shopping_cart,
                size: ScreenUtil().setSp(45),
                color: Colors.black12,
              ),
            ),
          ),
          InkWell(
            onTap: (){
              Provide.value<GoodsDetailBottomBarProvide>(context).add(goodsInfo.goodsId, goodsInfo.goodsName,goodsInfo.presentPrice, goodsInfo.image1);
            },
            child: Container(
              width: ScreenUtil().setWidth(320),
              alignment: Alignment.center,
              color: Colors.green,
              child: Text(
                '加入购物车',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(30)
                ),
              ),
            ),
          ),
          InkWell(
            onTap: (){
              Provide.value<GoodsDetailBottomBarProvide>(context).clear();
            },
            child: Container(
              width: ScreenUtil().setWidth(320),
              alignment: Alignment.center,
              color: Colors.red,
              child: Text(
                '立即购买',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(30)
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}