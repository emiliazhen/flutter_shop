import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageMember extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('会员中心'),
      ),
      body: Column(
        children: <Widget>[
          _topHeader(),
          _orderTitle(),
          _orderType(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(10),
                bottom: ScreenUtil().setHeight(10),
              ),
              children: <Widget>[
                _listTile('领取优惠券'),
                _listTile('已领取优惠券'),
                _listTile('地址管理'),
                _listTile('客服电话'),
                _listTile('关于我们'),
              ],
            ),
          )
        ],
      )
    );
  }

  Widget _topHeader(){
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
      color: Colors.pink,
      child: Column(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(180),
            height: ScreenUtil().setHeight(180),
            child: ClipOval(
              child: Image.network('https://gss1.bdstatic.com/9vo3dSag_xI4khGkpoWK1HF6hhy/baike/awhcrop%3D200%2C200/sign=8b73b168b3096b63975303037e5cf779/d788d43f8794a4c2fc2b916c03f41bd5ad6e3968.jpg'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(10)
            ),
            child: Text(
              'Kris Wu',
              style: TextStyle(
                fontSize:ScreenUtil().setSp(36),
                color: Colors.white
              )
            ),
          )
        ],
      ),
    );
  }

  Widget _orderTitle(){
    return Container(
      margin: EdgeInsets.only(
        top: ScreenUtil().setHeight(10)
      ),
      decoration: BoxDecoration(
        color:Colors.white,
        border: Border(
          bottom: BorderSide(
            width: ScreenUtil().setHeight(1),
            color:Colors.black12
          )
        ),
      ),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text('我的订单'),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

  Widget _orderType(){
    return Container(
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(10), ScreenUtil().setHeight(30), ScreenUtil().setWidth(10), ScreenUtil().setHeight(30)),
      width: ScreenUtil().setWidth(750),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: ScreenUtil().setHeight(1),
            color: Colors.black12
          )
        )
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.party_mode,
                  size:ScreenUtil().setSp(30)
                ),
                Text('待付款')
              ],
            )
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.query_builder,
                  size:ScreenUtil().setSp(30)
                ),
                Text('待发货')
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.directions_car,
                  size:ScreenUtil().setSp(30)
                ),
                Text('待收货')
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.content_paste,
                  size:ScreenUtil().setSp(30)
                ),
                Text('待评价')
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _listTile(String title){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom:BorderSide(width: 1,color:Colors.black12)
        )
      ),
      child: ListTile(
        leading: Icon(Icons.blur_circular),
        title: Text(title),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }
}