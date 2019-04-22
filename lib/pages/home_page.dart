import 'package:flutter/material.dart';

import '../service/service_method.dart';

class PageHome extends StatefulWidget {
  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  String homePageContent = '正在获取数据';
  @override
  void initState() {
    super.initState();
    getHomePageContent().then((v){
      setState(() {
       homePageContent = v.toString(); 
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('百姓生活+'),),
      body:SingleChildScrollView(
        child: Text(homePageContent)
      )
    );
  }
}