import 'package:flutter/material.dart';

class PageProvide with ChangeNotifier {
  int currentIndex = 0;
  changeIndex(int index){
    currentIndex = index;
    notifyListeners();
  }
}