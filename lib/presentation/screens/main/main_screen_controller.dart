import 'package:get/get.dart';

class MainScreenController extends GetController {
  int selectedIndex = 0;
  
  void updateSelectedIndex(int index) {
    selectedIndex = index;
    
    update(this);
  }
}