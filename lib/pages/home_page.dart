import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../config/httpHeaders.dart';

class PageHome extends StatefulWidget {
  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  String showText = '还没有请求数据';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text('请求远程数据'),),
        body:SingleChildScrollView(
          child: Column(
            children: <Widget>[
              RaisedButton(
                onPressed: _jike,
                child: Text('请求数据'),
              ),
              Text(showText)
            ],
          ),
        )
      ),
    );
  }

  void _jike(){
    print('开始向极客时间请求数据...');
    getHttp().then((val){
      setState(() {
       showText = val['data'].toString();
      });
    });
  }

  Future getHttp() async {
    try{
      Response res;
      Dio dio = new Dio();
      dio.options.headers = httpHeaders;
      res = await dio.get('https://time.geekbang.org/serv/v1/column/newAll');
      print(res);
      return res.data;
    }catch(e){
      return print(e);
    }
  }
}