import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class PageHome extends StatelessWidget {
  void getHttp() async{
    try {
      Response res;
      res = await Dio().get('https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian?name=002');
      print(res);
    } catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) {
    getHttp();
    return Scaffold(
      body: Center(
        child: Text('首页'),
      ),
    );
  }
}