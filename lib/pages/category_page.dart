import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import '../service/service_method.dart';
import '../model/category.dart';
import '../provide/child_category.dart';
import '../model/category_goods_list.dart';

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
          Column(
            children: <Widget>[
              RightCategoryNav(),
              CategoryGoodsList()
            ],
          )
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
  int listIndex = 0;

  @override
  void initState() {
    super.initState();
    _getCategory();
  }

  void _getCategory() async {
    await request('getCategory').then((res){
      var data = json.decode(res.toString());
      CategoryModel categoryList = CategoryModel.fromJson(data);
      setState(() {
       list = categoryList.data;
      });
      Provide.value<ChildCategory>(context).getChildCategory(list[0].bxMallSubDto);
    });
  }

  Widget _leftNavInkWell(index){
    return InkWell(
      onTap: (){
        var childList = list[index].bxMallSubDto;
        Provide.value<ChildCategory>(context).getChildCategory(childList);
        setState(() {
          listIndex = index;
        });
      },
      child: Container(
        alignment: Alignment.centerLeft,
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(20),
        ),
        decoration: BoxDecoration(
          color: listIndex == index ? Color.fromRGBO(230, 230, 230, 1.0) : Colors.white,
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
  Widget _rightNavInkWell(BxMallSubDto item){
    return InkWell(
      onTap: (){

      },
      child: Container(
        alignment: Alignment.center,
        height: ScreenUtil().setWidth(50),
        child: Text(item.mallSubName),
        padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(20),
          right: ScreenUtil().setWidth(20),
        ),
        decoration: BoxDecoration(
          color:Colors.white
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(
      builder: (context,child,childCategory){
        return Container(
          width: ScreenUtil().setWidth(570),
          height: ScreenUtil().setHeight(80),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                width: ScreenUtil().setHeight(1),
                color: Colors.black12
              )
            )
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context,index){
              return _rightNavInkWell(childCategory.childCategoryList[index]);
            },
            itemCount: childCategory.childCategoryList.length,
          ),
        );
      },
    );
  }
}

class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  List list = [];

  @override
  void initState() {
    super.initState();
    _getGoodlist();
  }

  void _getGoodlist() async {
    Map data = {
      'categoryId': '4',
      'categorySubId': '',
      'page': 1
    };
    await request('getMallGoods', data).then((res) {
      dynamic data = json.decode(res.toString());
      CategoryGoodsListModel goodslist = CategoryGoodsListModel.fromJson(data);
      setState(() {
        list = goodslist.data;
      });
      print(list[0].goodsName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('商品列表'),
    );
  }
}