import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier {
  static final HomeProvider _instance = HomeProvider._();

  HomeProvider._();

  factory HomeProvider() => _instance;

  PageController homePageController = PageController();
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  onHomePageSelected(int index) {
    _selectedIndex = index;
    homePageController.jumpToPage(index);
    notifyListeners();
  }
}
