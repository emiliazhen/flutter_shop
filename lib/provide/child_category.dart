import 'package:flutter/material.dart';

import '../model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  int childCategoryIndex = 0; // 子类索引
  String categoryId = '4'; // 大类ID
  String subId = ''; // 小类ID

  getChildCategory(List<BxMallSubDto> list,String id){
    categoryId = id;
    childCategoryIndex = 0;
    subId = '';
    BxMallSubDto all = BxMallSubDto();
    all.mallCategoryId = '00';
    all.mallSubId = '';
    all.mallSubName = '全部';
    childCategoryList = [all]..addAll(list);
    notifyListeners();
  }

  changeChildCategoryIndex(int index,String id){
    childCategoryIndex = index;
    subId = id;
    notifyListeners();
  }
}