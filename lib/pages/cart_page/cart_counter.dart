import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(200),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: ScreenUtil().setWidth(1),
          color: Colors.black12
        ),
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(8))
      ),
      child: Row(
        children: <Widget>[
          _minusBtn(),
          Expanded(
            child: _countShow(),
          ),
          _addBtn()
        ],
      ),
    );
  }

  Widget _minusBtn(){
    return InkWell(
      onTap:(){},
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        child: Text('-')
      ),
    );
  }

  Widget _countShow(){
    return Container(
      height: ScreenUtil().setHeight(45),
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(5),
        right: ScreenUtil().setWidth(5),
      ),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            width: ScreenUtil().setWidth(1),
            color: Colors.black12
          ),
          right: BorderSide(
            width: ScreenUtil().setWidth(1),
            color: Colors.black12
          )
        )
      ),
      alignment: Alignment.center,
      child: Text('1'),
    );
  }

  Widget _addBtn(){
    return InkWell(
      onTap: (){},
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        child: Text('+')
      ),
    );
  }
}