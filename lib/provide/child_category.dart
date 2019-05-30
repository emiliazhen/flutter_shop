import 'package:flutter/material.dart';

import '../model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  int childCategoryIndex = 0; // 子类索引
  String categoryId = '4'; // 大类ID
  String subId = ''; // 小类ID
  int page = 1; // 页码
  String noMoreText = '';

  getChildCategory(List<BxMallSubDto> list,String id){
    page = 1;
    noMoreText = '';
    categoryId = id;
    childCategoryIndex = 0;
    subId = '';
    BxMallSubDto all = BxMallSubDto();
    all.mallCategoryId = '00';
    all.mallSubId = '';
    all.mallSubName = '全部';
    all.comments = 'null';
    childCategoryList = [all]..addAll(list);
    notifyListeners();
  }

  changeChildCategoryIndex(int index,String id){
    childCategoryIndex = index;
    noMoreText = '';
    subId = id;
    notifyListeners();
  }

  addPage(){
    page++;
  }

  morePageEnd(){
    noMoreText = '没有更多了';
    notifyListeners();
  }
}