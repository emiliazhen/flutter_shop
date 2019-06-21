import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import '../../provide/cart_info_provide.dart';
import '../../provide/goods_detail_provide.dart';
import '../../provide/page_provide.dart';

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
            onTap: (){
              Provide.value<PageProvide>(context).changeIndex(2);
              Navigator.pop(context);
            },
            child:  Stack(
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(110),
                  child: Icon(
                    Icons.shopping_cart,
                    size: ScreenUtil().setSp(50),
                    color: Colors.black45,
                  ),
                ),
                Provide<CartInfoProvide>(
                  builder: (context,child,val){
                    int countTotal = val.countTotal;
                    return Positioned(
                      top: 0,
                      right:10,
                      child: Offstage(
                        offstage: countTotal == 0,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(5), ScreenUtil().setHeight(2), ScreenUtil().setWidth(5), ScreenUtil().setHeight(2)),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            border: Border.all(
                              width: ScreenUtil().setWidth(2),
                              color: Colors.white
                            ),
                            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(20))
                          ),
                          child: Text(
                            '${countTotal > 99 ? '99+' : countTotal}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(20)
                            ),
                          ),
                        ),
                      )
                    );
                  },
                )
              ],
            ),
          ),
          InkWell(
            onTap: (){
              Provide.value<CartInfoProvide>(context).addCart(goodsInfo.goodsId, goodsInfo.goodsName,goodsInfo.presentPrice, goodsInfo.image1);
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