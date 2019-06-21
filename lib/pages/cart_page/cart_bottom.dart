import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import '../../provide/cart_info_provide.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(85),
      color: Colors.white,
      child: Provide<CartInfoProvide>(
        builder: (context,child,val){
          return Row(
            children: <Widget>[
              _selectAllBtn(context),
              Expanded(
                child: _priceTotal(val.priceTotal),
              ),
              _buyChoosed(val.countTotal)
            ],
          );
        },
      )
    );
  }

  Widget _selectAllBtn(BuildContext context){
    return Row(
      children: <Widget>[
        Checkbox(
          value: Provide.value<CartInfoProvide>(context).allChecked,
          activeColor: Colors.pink,
          onChanged: (v){
            Provide.value<CartInfoProvide>(context).changeCartAllCheck(v);
          },
        ),
        InkWell(
          onTap: (){
            Provide.value<CartInfoProvide>(context).changeCartAllCheck(!Provide.value<CartInfoProvide>(context).allChecked);
          },
          child: Text(
          '全选',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(30)
          ),
        ),
        )
      ],
    );
  }

  Widget _priceTotal(double priceTotal){
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
                    text: priceTotal.toStringAsFixed(2),
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
              priceTotal < 10 ? '满10元免配送费，预购免配送费' : '已免配送费',
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

  Widget _buyChoosed(int countTotal){
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
          '结算($countTotal)',
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
    );
  }
}