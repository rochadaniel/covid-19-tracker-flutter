import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetController {
  static SearchController get to => Get.find();

  TextEditingController controller;
  String filter;

  void updateFilter(String newFilter) {
    filter = newFilter;

    update(this);
  }
}