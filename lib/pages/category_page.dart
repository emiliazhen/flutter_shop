import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../service/service_method.dart';
import '../model/category.dart';

class PageCategory extends StatefulWidget {
  @override
  _PageCategoryState createState() => _PageCategoryState();
}

class _PageCategoryState extends State<PageCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Row(
        children: <Widget>[
          LeftCategoryNav(),
          // Column(
          //   children: <Widget>[
          //     RightCategoryNav(),
          //   ],
          // )
        ],
      ),
    );
  }
}

// 左侧导航菜单
class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List list = [];

  void _getCategory() async {
    await request('getCategory').then((res){
      var data = json.decode(res.toString());
       print(data);
      CategoryModel categoryList = CategoryModel.fromJson(data);
      setState(() {
       list = categoryList.data;
      });
    });
  }

  Widget _leftNavInkWell(index){
    return InkWell(
      child: Container(
        alignment: Alignment.centerLeft,
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(20),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: ScreenUtil().setHeight(1),color: Colors.black12)
          ),
        ),
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28)
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(width: ScreenUtil().setWidth(1),color: Colors.black12)
        )
      ),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context,index){
          return _leftNavInkWell(index);
        },
      ),
    );
  }
}

class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  List list = ['白酒','红酒','黄酒','清酒','葡萄酒','朗姆酒','保健酒'];

  Widget _rightNavInkWell(index){
    return InkWell(
      onTap: (){

      },
      child: Container(
        alignment: Alignment.center,
        height: ScreenUtil().setWidth(50),
        child: Text(list[index]),
        padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(20),
          right: ScreenUtil().setWidth(20),
        ),
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              width: ScreenUtil().setWidth(1),
              color: Colors.black12
            )
          )
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(570),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: ScreenUtil().setWidth(1),
            color: Colors.black12
          )
        )
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index){
          return _rightNavInkWell(index);
        },
        itemCount: list.length,
      ),
    );
  }
}