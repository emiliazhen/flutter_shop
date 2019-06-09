import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import '../provide/cart_info_provide.dart';
import './cart_page/cart_item.dart';

class PageCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: FutureBuilder(
        future: _getCartInfo(context),
        builder: (context,snapshot){
          if(snapshot.hasData){
            List cartList = Provide.value<CartInfoProvide>(context).cartList;
            return ListView.builder(
              itemCount: cartList.length,
              itemBuilder: (context,index){
                return CartItem(cartList[index]);
              },
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