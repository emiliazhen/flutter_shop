import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../provide/goods_detail_provide.dart';

class GoodsDetailTabContext extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<GoodsDetailProvide>(
      builder: (context,child,val){
        if(val.isLeft){
          return Container(
            child: Html(
              data: val.goodsDetailInfo.data.goodInfo.goodsDetail,
            ),
          );
        } else {
          return Container(
            width: ScreenUtil().setWidth(750),
            height: ScreenUtil().setHeight(100),
            alignment: Alignment.center,
            child: Text(
              '暂无评论',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(24),
                color: Colors.black38
              ),
            ),
          );
        }
      }      
    );
  }
}