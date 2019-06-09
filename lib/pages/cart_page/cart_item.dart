import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/cart_info.dart';

class CartItem extends StatelessWidget {
  final CartInfoModel item;
  CartItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(5), ScreenUtil().setHeight(10), ScreenUtil().setWidth(5), ScreenUtil().setHeight(10)),
      height: ScreenUtil().setHeight(140),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: ScreenUtil().setWidth(1),color: Colors.black12)
        )
      ),
      child: Row(
        children: <Widget>[
          _cartItemCheckBox(item),
          _cartItemImg(item),
          Expanded(
            child:  _cartItemName(item),
          ),
          _cartItemPrice(item),
        ],
      ),
    );
  }

  Widget _cartItemCheckBox(CartInfoModel item){
    return Checkbox(
      value: true,
      activeColor: Colors.pink,
      onChanged: (bool v){

      },
    );
  }

  Widget _cartItemImg(CartInfoModel item){
    return Container(
      width: ScreenUtil().setWidth(120),
      height: ScreenUtil().setWidth(120),
      decoration: BoxDecoration(
        border: Border.all(
          width: ScreenUtil().setWidth(2),
          color: Colors.black12
        )
      ),
      child: Image.network(item.images),
    );
  }

  Widget _cartItemName(CartInfoModel item){
    return Container(
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(10),
        right: ScreenUtil().setWidth(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            item.goodsName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(28)
            ),
          ),
          Text(item.count.toString())
        ],
      ),
    );
  }
  
  Widget _cartItemPrice(CartInfoModel item){
    return Container(
      width: ScreenUtil().setWidth(150),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            '￥${item.price}',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(30),
              color: Colors.pink
            ),
          ),
          Text(
            '￥211',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Colors.black26,
              decoration: TextDecoration.lineThrough
            ),
          ),
          Icon(
            Icons.delete_forever,
            size: ScreenUtil().setWidth(35),
            color: Colors.black26,
          )
        ],
      ),
    );
  }

}