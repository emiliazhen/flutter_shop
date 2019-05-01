import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';

class PageHome extends StatefulWidget {
  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text('请求远程数据'),),
        body: FutureBuilder(
          future: getHomePageContent(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              var data = json.decode(snapshot.data.toString());
              List<Map> swiperDataList = (data['data']['slides'] as List).cast();
              return Column(
                children: <Widget>[
                  SwiperDiy(swiperDataList: swiperDataList)
                ],
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

class SwiperDiy extends StatelessWidget {
  final List swiperDataList;
  SwiperDiy({Key key,this.swiperDataList}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 333,
      child: Swiper(
        itemBuilder: (BuildContext context,int index){
          return Image.network('${swiperDataList[index]['image']}',fit: BoxFit.fill);
        },
        itemCount: 3,
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}