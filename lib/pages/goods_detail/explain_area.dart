import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoodsDetailExplainArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: ScreenUtil().setWidth(750),
      margin: EdgeInsets.only(
        top:ScreenUtil().setHeight(10)
      ),
      padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
      child: Text(
        '说明： > 急速配送 > 正品保证',
        style: TextStyle(
          color: Colors.pinkAccent,
          fontSize: ScreenUtil().setSp(24)
        ),
      ),
    );
  }
}