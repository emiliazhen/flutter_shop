import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../provide/goods_detail_provide.dart';

class GoodsDetailTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<GoodsDetailProvide>(
      builder: (context, child, val) {
        dynamic goodsInfo = Provide.value<GoodsDetailProvide>(context)
            .goodsDetailInfo
            .data
            .goodInfo;
        if (goodsInfo != null) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white
            ),
            child: Column(
              children: <Widget>[
                _imageTop(goodsInfo.image1),
                _goodsTitle(goodsInfo.goodsName),
                _goodsNumId(goodsInfo.goodsSerialNumber),
                _goodsPrice(goodsInfo.presentPrice,goodsInfo.oriPrice)
              ],
            ),
          );
        } else {
          return Text('加载中...');
        }
      },
    );
  }

  Widget _imageTop(String src) {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(750),
      child: Image.network(src),
    );
  }

  Widget _goodsTitle(String title) {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(10),
        right: ScreenUtil().setWidth(10),
      ),
      child: Text(
        title,
        maxLines: 1,
        style:TextStyle(
          fontSize: ScreenUtil().setSp(30),
          color: Colors.black
        )
      ),
    );
  }

  Widget _goodsNumId(String goodsNumId) {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(10),
        right: ScreenUtil().setWidth(10),
      ),
      margin: EdgeInsets.only(
        top: ScreenUtil().setHeight(8)
      ),
      child: Text(
        '编号：$goodsNumId',
        style:TextStyle(
          fontSize: ScreenUtil().setSp(24),
          color: Colors.black12
        ),
      ),
    );
  }

  Widget _goodsPrice(double presentPrice,double oriPrice) {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(10),
        right: ScreenUtil().setWidth(10)
      ),
      margin: EdgeInsets.only(
        top: ScreenUtil().setHeight(8)
      ),
      child: Row(
        children: <Widget>[
          Text(
            '￥$presentPrice',
            style: TextStyle(
              color: Colors.pinkAccent,
              fontSize: ScreenUtil().setSp(40),
            ),
          ),
          Text(
            '市场价：￥$oriPrice',
            style: TextStyle(
              color: Colors.black26, decoration: TextDecoration.lineThrough
            ),
          )
        ],
      ),
    );
  }
}
