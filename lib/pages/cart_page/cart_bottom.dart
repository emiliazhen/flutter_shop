import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(85),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          _selectAllBtn(),
          Expanded(
            child: _priceTotal(),
          ),
          _buyChoosed()
        ],
      )
    );
  }

  Widget _selectAllBtn(){
    return Row(
      children: <Widget>[
        Checkbox(
          value: true,
          activeColor: Colors.pink,
          onChanged: (v){},
        ),
        Text(
          '全选',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(30)
          ),
        )
      ],
    );
  }

  Widget _priceTotal(){
    return Container(
      padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            child: Text.rich(
              TextSpan(
                text:'总计：',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: Colors.black26
                ),
                children: [
                  TextSpan(
                    text:'￥',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(28),
                      color: Colors.red
                    ),
                  ),
                  TextSpan(
                    text:'2453.00',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(34),
                      color: Colors.red
                    ),
                  ),
                ]
              )
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              '满10元免配送费，预购免配送费',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(22),
                color: Colors.black38
              ),
            ),
          )
        ],
      )
    );
  }

  Widget _buyChoosed(){
    return InkWell(
      onTap:(){},
      child: Container(
        width: ScreenUtil().setWidth(160),
        height: ScreenUtil().setHeight(65),
        margin: EdgeInsets.only(
          right: ScreenUtil().setWidth(10)
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10))
        ),
        child: Text(
          '结算(5)',
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
    );
  }
}