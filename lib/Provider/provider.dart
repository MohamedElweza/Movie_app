import 'package:flutter/material.dart';

class MyProvider with ChangeNotifier{

  ThemeMode tm = ThemeMode.light;
  bool Value = false;
  bool clickIcon = false;
  IconData IconColor =  Icons.bookmark_border;

  void switchChange(bool value){
    Value = value;
    if(Value == false){
      tm = ThemeMode.light;
    }else{
      tm = ThemeMode.dark;
    }
    notifyListeners();
  }

  void SaveIconChange(bool value){
    clickIcon = value;
    if(clickIcon == false){
       IconColor = Icons.bookmark_border;
    }else{
      IconColor = Icons.bookmark;

    }
    notifyListeners();
  }

}