import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:togo/app/data/models/biodata_model.dart';
import 'package:togo/utils/database_helper.dart';

class HomeController extends GetxController {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final count = 0.obs;
  RxList<Biodata> listBiodata = <Biodata>[].obs;
  @override
  void onInit() {
    super.onInit();

    _fetchBiodata();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    Get.log('close');
  }

  void increment() => count.value++;

  void _fetchBiodata() async {
    var list = await _dbHelper.get(DBTableBiodata.TABLE,
        option: 'ORDER BY ${DBTableBiodata.COLUMN_CREATED_AT} DESC');

    listBiodata.clear();
    for (var model in list.toList()) {
      listBiodata.add(Biodata.fromJson(model));
    }

    update();
  }
}
