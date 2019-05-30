import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:toast/toast.dart';

import '../service/service_method.dart';
import '../model/category.dart';
import '../provide/child_category.dart';
import '../model/category_goods_list.dart';
import '../provide/category_goods_list.dart';
import '../routers/staticize.dart';

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
              Expanded(
                child: CategoryGoodsList(),
              )
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
    _getGoodlist();
  }

  void _getCategory() async {
    await request('getCategory').then((res){
      var data = json.decode(res.toString());
      CategoryModel categoryList = CategoryModel.fromJson(data);
      setState(() {
        list = categoryList.data;
      });
      Provide.value<ChildCategory>(context).getChildCategory(list[0].bxMallSubDto,list[0].mallCategoryId);
    });
  }

  void _getGoodlist({String categoryId}) {
    Map data = {
      'categoryId': categoryId == null ? '4' : categoryId,
      'categorySubId': '',
      'page': 1
    };
    request('getMallGoods', data).then((res) {
      dynamic data = json.decode(res.toString());
      CategoryGoodsListModel goodslist = CategoryGoodsListModel.fromJson(data);
      Provide.value<CategoryGoodsListProvide>(context).getGoodsList(goodslist.data);
    });
  }

  Widget _leftNavInkWell(index){
    return InkWell(
      onTap: (){
        setState(() {
          listIndex = index;
        });
        var childList = list[index].bxMallSubDto;
        var categoryId = list[index].mallCategoryId;
        Provide.value<ChildCategory>(context).getChildCategory(childList,categoryId);
        _getGoodlist(categoryId: categoryId);
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
  void _getGoodlist() {
    Map data = {
      'categoryId': Provide.value<ChildCategory>(context).categoryId,
      'categorySubId': Provide.value<ChildCategory>(context).subId,
      'page': 1
    };
    request('getMallGoods', data).then((res) {
      dynamic data = json.decode(res.toString());
      CategoryGoodsListModel goodslist = CategoryGoodsListModel.fromJson(data);
      Provide.value<CategoryGoodsListProvide>(context).getGoodsList(goodslist.data == null ? [] : goodslist.data);
    });
  }

  Widget _rightNavInkWell(BxMallSubDto item,int index){
    return InkWell(
      onTap: (){
        Provide.value<ChildCategory>(context).changeChildCategoryIndex(index,item.mallSubId);
        _getGoodlist();
      },
      child: Container(
        alignment: Alignment.center,
        height: ScreenUtil().setWidth(50),
        child: Text(
          item.mallSubName,
          style: TextStyle(
            color: Provide.value<ChildCategory>(context).childCategoryIndex == index ? Colors.pink : Colors.black54
          ),
        ),
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
              return _rightNavInkWell(childCategory.childCategoryList[index],index);
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
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();
  var scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
  }

  void _getMoreGoodlist() {
    Provide.value<ChildCategory>(context).addPage();
    Map data = {
      'categoryId': Provide.value<ChildCategory>(context).categoryId,
      'categorySubId': Provide.value<ChildCategory>(context).subId,
      'page': Provide.value<ChildCategory>(context).page
    };
    request('getMallGoods', data).then((res) {
      dynamic data = json.decode(res.toString());
      CategoryGoodsListModel goodslist = CategoryGoodsListModel.fromJson(data);
      if(goodslist.data == null){
        Toast.show('已经到最底部了',context,duration:Toast.LENGTH_SHORT,gravity:Toast.CENTER);
        Provide.value<ChildCategory>(context).morePageEnd();
      }else{
        Provide.value<CategoryGoodsListProvide>(context).getMoreGoodsList(goodslist.data);
      }
    });
  }

  // 商品
  Widget _categoryGoodsItem(List newList,index){
    return Container(
      width: ScreenUtil().setWidth(570),
      height: ScreenUtil().setHeight(200),
      child: InkWell(
        onTap: (){
          Staticize.router.navigateTo(context, '/goodDetail?id=${newList[index].goodsId}');
        },
        child: Container(
          decoration: BoxDecoration(
            color:Colors.white,
            border: Border(
              bottom: BorderSide(
                width: ScreenUtil().setWidth(1),
                color: Colors.black12
              )
            )
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(200),
                height: ScreenUtil().setHeight(200),
                child: Image.network(
                  newList[index].image
                ),
              ),
              _categoryGoodsItemTextInfo(newList,index)
            ],
          ),
        ),
      )
    );
  }

  // 商品文字
  Widget _categoryGoodsItemTextInfo(List newList,index){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
          margin: EdgeInsets.only(
            top: ScreenUtil().setHeight(10)
          ),
          width: ScreenUtil().setWidth(370),
          child: Text(
            newList[index].goodsName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(28)
            ),
          ),
        ),
        Container(
          width: ScreenUtil().setWidth(370),
          padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
          margin: EdgeInsets.only(
            bottom: ScreenUtil().setHeight(10)
          ),
          child: Row(
            children: <Widget>[
              Text(
                '价格：￥${newList[index].presentPrice}',
                style:TextStyle(
                  color:Colors.pink,
                  fontSize: ScreenUtil().setSp(28)
                )
              ),
              Text(
                '￥${newList[index].oriPrice}',
                style:TextStyle(
                  color: Colors.black26,
                  decoration: TextDecoration.lineThrough,
                  fontSize: ScreenUtil().setSp(24)
                )
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context,child,data){
        try{
          if(Provide.value<ChildCategory>(context).page == 1){
            scrollController.animateTo(
              0.0,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 300),
            );
          }
        }catch(e){
          print('>>>>>$e');
        }
        if(data.goodsList.length > 0){
          return  Container(
            width: ScreenUtil().setWidth(570),
            child: EasyRefresh(
              loadMore: () {
                _getMoreGoodlist();
              },
              refreshFooter: ClassicsFooter(
                key: _footerKey,
                bgColor: Colors.pink,
                textColor: Colors.white,
                moreInfoColor: Colors.white,
                showMore: true,
                noMoreText: '',
                moreInfo: '加载中...',
                loadReadyText: '上拉加载',
              ),
              child: ListView.builder(
                controller: scrollController,
                itemCount: data.goodsList.length,
                itemBuilder: (context,index){
                  return _categoryGoodsItem(data.goodsList,index);
                },
              ),
            )
          );
        } else {
          return Text('暂无数据');
        }
      },
    );
  }
}