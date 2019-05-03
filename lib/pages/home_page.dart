import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class PageHome extends StatefulWidget {
  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text('LifeShop+'),),
        body: FutureBuilder(
          future: getHomePageContent(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              var data = json.decode(snapshot.data.toString());
              List<Map> swiperDataList = (data['data']['slides'] as List).cast();
              List<Map> navigatorList = (data['data']['category'] as List).cast();
              String adPictureUrl = data['data']['advertesPicture']['PICTURE_ADDRESS'];
              String leaderImage = data['data']['shopInfo']['leaderImage'];
              String leaderPhone = data['data']['shopInfo']['leaderPhone'];
              List<Map> recommendList = (data['data']['recommend'] as List).cast();
              String floor1Title = data['data']['floor1Pic']['PICTURE_ADDRESS'];
              String floor2Title = data['data']['floor2Pic']['PICTURE_ADDRESS'];
              String floor3Title = data['data']['floor3Pic']['PICTURE_ADDRESS'];
              List<Map> floorData1 = (data['data']['floor1'] as List).cast();
              List<Map> floorData2 = (data['data']['floor2'] as List).cast();
              List<Map> floorData3 = (data['data']['floor3'] as List).cast();

              if(navigatorList.length > 10){
                navigatorList.removeRange(10, navigatorList.length);
              }
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SwiperDiy(swiperDataList: swiperDataList),
                    TopNavigator(navigatorList: navigatorList),
                    AdBanner(adPictureUrl: adPictureUrl),
                    LeaderPhone(leaderImage: leaderImage,leaderPhone: leaderPhone),
                    Recommend(recommendList:recommendList),
                    FloorTitle(picAdress: floor1Title),
                    FloorGoods(floorGoodsList:floorData1),
                    FloorTitle(picAdress: floor2Title),
                    FloorGoods(floorGoodsList:floorData2),
                    FloorTitle(picAdress: floor3Title),
                    FloorGoods(floorGoodsList:floorData3),
                  ],
                ),
              );
            } else {
              return Center(child: Text('加载中...'));
            }
          },
        )
      ),
    );
  }
}

// 轮播图
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;
  SwiperDiy({Key key,this.swiperDataList}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context,int index){
          return Image.network('${swiperDataList[index]['image']}',fit: BoxFit.fill);
        },
        itemCount: swiperDataList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

// 导航
class TopNavigator extends StatelessWidget {
  final List navigatorList;
  TopNavigator({Key key,this.navigatorList}):super(key:key);

  Widget _gridViewItemUI(BuildContext context,item){
    return InkWell(
      onTap: (){
        print('---Tap---');
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            width:ScreenUtil().setWidth(95)
          ),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(4.0),
        children: navigatorList.map((item){
          return _gridViewItemUI(context,item);
        }).toList()
      ),
    );
  }
}

// Bannner
class AdBanner extends StatelessWidget {
  final String adPictureUrl;
  AdBanner({Key key,this.adPictureUrl}):super(key:key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPictureUrl),
    );
  }
}

// 店长电话
class LeaderPhone extends StatelessWidget {
  final String leaderImage;
  final String leaderPhone;
  LeaderPhone({Key key,this.leaderImage,this.leaderPhone}):super(key:key);

  @override
  Widget build(BuildContext context) {
    void _launcherUrl() async{
      // String url = 'tel:' + leaderPhone;
      String url = 'http://www.baidu.com';
      if(await canLaunch(url)){
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
    return Container(
      child: InkWell(
        onTap:_launcherUrl,
        child: Image.network(leaderImage),
      ),
    );
  }
}

// 商品推荐
class Recommend extends StatelessWidget {
  final List<Map> recommendList;
  Recommend({Key key, this.recommendList}):super(key:key);

  // 标题
  Widget _titleWidget(){
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: ScreenUtil().setHeight(0.5),
            color: Colors.black12
          )
        )
      ),
      child: Text(
        '商品推荐',
        style:TextStyle(
          color: Colors.pink
        )
      ),
    );
  }

  // 推荐项
  Widget _item(index){
    return InkWell(
      onTap: (){},
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(
              width: ScreenUtil().setWidth(0.5),
              color:Colors.black12
            )
          )
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text(
              '￥${recommendList[index]['mallPrice']}',
              style:TextStyle(
                color: Colors.pink
              )
            ),
            Text(
              '￥${recommendList[index]['price']}',
              style:TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey
              )
            ),
          ],
        ),
      ),
    );
  }

  Widget _recommandListView(){
    return Container(
      height: ScreenUtil().setHeight(330),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context,index){
          return _item(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(385),
      margin: EdgeInsets.only(top:ScreenUtil().setHeight(10)),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommandListView()
        ],
      ),
    );
  }
}

// 分类区标题
class FloorTitle extends StatelessWidget {
  final String picAdress;
  FloorTitle({Key key,this.picAdress}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
      child: Image.network(picAdress),
    );
  }
}

// 分类区商品
class FloorGoods extends StatelessWidget {
  final List<Map> floorGoodsList;
  FloorGoods({Key key, this.floorGoodsList}):super(key:key);

  Widget _firstRow(){
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[0]),
        Column(
          children: <Widget>[
          _goodsItem(floorGoodsList[1]),
          _goodsItem(floorGoodsList[2]),
          ],
        )
      ],
    );
  }

  Widget _otherRow(){
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[3]),
        _goodsItem(floorGoodsList[4])
      ],
    );
  }

  Widget _goodsItem(Map goods){
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: (){

        },
        child: Image.network(goods['image']),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(),
          _otherRow()
        ],
      ),
    );
  }
}