import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import '../../provide/goods_detail_provide.dart';

class GoodsDetailContextTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<GoodsDetailProvide>(
      builder: (context,child,val){
        return Container(
          margin: EdgeInsets.only(
            top: ScreenUtil().setHeight(10)
          ),
          width: ScreenUtil().setWidth(750),
          decoration: BoxDecoration(
            color: Colors.white
          ),
          child: Row(
            children: <Widget>[
              _leftTab(context,val.isLeft),
              _rightTab(context,val.isLeft),
            ],
          ),
        );
      },
    );
  }

  Widget _leftTab(BuildContext context,bool isLeft){
    return Container(
      width: ScreenUtil().setWidth(375),
      padding: EdgeInsets.all(
        ScreenUtil().setWidth(10)
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: ScreenUtil().setWidth(2),
            color: isLeft? Colors.pinkAccent : Colors.transparent
          )
        )
      ),
      child: InkWell(
        onTap: (){
          Provide.value<GoodsDetailProvide>(context).changeTabBar(true);
        },
        child: Text(
          '详情',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isLeft? Colors.pinkAccent : Colors.black12,
            fontSize: ScreenUtil().setSp(24)
          ),
        ),
      ),
    );
  }

  Widget _rightTab(BuildContext context,bool isLeft){
    return Container(
      width: ScreenUtil().setWidth(375),
      padding: EdgeInsets.all(
        ScreenUtil().setWidth(10)
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: ScreenUtil().setWidth(2),
            color: isLeft? Colors.transparent : Colors.pinkAccent
          )
        )
      ),
      child: InkWell(
        onTap: (){
          Provide.value<GoodsDetailProvide>(context).changeTabBar(false);
        },
        child: Text(
          '评论',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isLeft? Colors.black12 : Colors.pinkAccent,
            fontSize: ScreenUtil().setSp(24)
          ),
        ),
      ),
    );
  }

}