import 'package:flutter/material.dart';
import 'dart:convert';

import '../service/service_method.dart';

class PageCategory extends StatefulWidget {
  @override
  _PageCategoryState createState() => _PageCategoryState();
}

class _PageCategoryState extends State<PageCategory> {
  void _getCategory() async {
    await request('getCategory').then((res){
      var data = json.decode(res.toString());
      print(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    _getCategory();
    return Container(
      child: Text('分类'),
    );
  }
}