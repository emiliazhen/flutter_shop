import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import '../provide/cart_info_provide.dart';
import './cart_page/cart_item.dart';
import './cart_page/cart_bottom.dart';

class PageCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
        actions: <Widget>[
          InkWell(
            onTap: (){
              Provide.value<CartInfoProvide>(context).clearCart();
            },
            child: Container(
              padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.remove_shopping_cart,
                    size: ScreenUtil().setSp(45),
                  ),
                  Text(
                    '删除所有',
                    style: TextStyle(
                      fontSize: ScreenUtil().setWidth(22)
                    ),
                  )
                ],
              ),
            )
          ),
        ],
      ),
      body: FutureBuilder(
        future: _getCartInfo(context),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return Column(
              children: <Widget>[
                Expanded(
                  child: Provide<CartInfoProvide>(
                    builder: (context,child,val){
                      List cartList = val.cartList;
                      if(cartList.length > 0){
                        return ListView(
                          children: cartList.map((item){
                            return CartItem(item);
                          }).toList(),
                        );
                      }else{
                        return Container(
                          padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                          child: Text(
                            '购物车还是空的，赶紧去选购商品吧',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(24),
                              color:Colors.black26
                            ),
                          ),
                        );
                      }
                    },
                  )
                ),
                CartBottom()
              ],
            );
          }else{
            return Text('加载中...');
          }
        },
      )
    );
  }

  Future<String> _getCartInfo(BuildContext context) async{
    await Provide.value<CartInfoProvide>(context).getCartInfo();
    return 'done';
  }
}