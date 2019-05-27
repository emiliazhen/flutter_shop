import 'package:flutter/material.dart';

import '../model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  int childCategoryIndex = 0;
  String categoryId = '4';

  getChildCategory(List<BxMallSubDto> list,String id){
    categoryId = id;
    childCategoryIndex = 0;
    BxMallSubDto all = BxMallSubDto();
    all.mallCategoryId = '00';
    all.mallSubId = '00';
    all.mallSubName = '全部';
    childCategoryList = [all]..addAll(list);
    notifyListeners();
  }

  changeChildCategoryIndex(int index){
    childCategoryIndex = index;
    notifyListeners();
  }
}