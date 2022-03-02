import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:togo/app/modules/home/controllers/home_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:togo/utils/database_helper.dart';

class TambahController extends GetxController {
  TextEditingController tecNama = TextEditingController(),
      tecAlamat = TextEditingController(),
      tecTglLahir = TextEditingController(),
      tecTinggi = TextEditingController(),
      tecBerat = TextEditingController(),
      tecFoto = TextEditingController();
  DatabaseHelper dbHelper = DatabaseHelper();
  var timein = DateTime.now().millisecondsSinceEpoch;
  var waktu = "00:00".obs;
  var disableButton = false.obs;

  final count = 0.obs;
  var path = "".obs;
  @override
  void onInit() {
    super.onInit();

    Timer.periodic(Duration(seconds: 1), (timer) {
      waktu.value = getScreenTime();
      update();
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    Get.log('close');
    final HomeController homeController = Get.find();
    homeController.onInit();
  }

  void increment() => count.value++;

  void selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1945, 8),
      lastDate: DateTime(2023),
    );

    if (picked != null) {
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formatted = formatter.format(picked);
      tecTglLahir.text = formatted;
    }
  }

  void selectFile() async {
    try {
      var picker = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['jpg', 'png'],
      );

      if (picker != null) {
        for (var files in picker.files) {
          /* pathBukti = files.path;
            bukti = files.name; */
          path.value = files.path!;
          tecFoto.text = files.name;
          Get.log("$files");
          break;
        }
      } else {
        // User canceled the picker
        print('user canceled');
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
  }

  void onSave() {
    var nama = tecNama.text;
    var alamat = tecAlamat.text;
    var tglLahir = tecTglLahir.text;
    var tinggi = tecTinggi.text;
    var berat = tecBerat.text;
    var foto = path.value;

    if (nama.isEmpty ||
        alamat.isEmpty ||
        tglLahir.isEmpty ||
        tinggi.isEmpty ||
        berat.isEmpty ||
        foto.isEmpty) {
      Fluttertoast.showToast(
          msg: "Data belum lengkap",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    dbHelper.create(DBTableBiodata.TABLE, {
      DBTableBiodata.COLUMN_NAMA: nama,
      DBTableBiodata.COLUMN_ALAMAT: alamat,
      DBTableBiodata.COLUMN_TGL_LAHIR: tglLahir,
      DBTableBiodata.COLUMN_TINGGI: tinggi,
      DBTableBiodata.COLUMN_BERAT: berat,
      DBTableBiodata.COLUMN_FOTO: base64.encode(utf8.encode(foto)),
      DBTableBiodata.COLUMN_CREATED_AT: DateTime.now().millisecond
    });
    Fluttertoast.showToast(
        msg: "Data berhasil disimpan",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
    Get.back();
  }

  String getScreenTime() {
    var timeOut = DateTime.now().millisecondsSinceEpoch;
    var duration = Duration(milliseconds: timeOut - timein);

    var menit =
        dateFormatFromMilli(value: duration.inMilliseconds, pattern: 'mm');
    var detik =
        dateFormatFromMilli(value: duration.inMilliseconds, pattern: 'ss');

    if (int.parse(menit) > 0) {
      disableButton.value = true;
      update();
    }

    return '$menit:$detik';
  }

  String dateFormatFromMilli(
      {required int value, String pattern = 'dd-MM-yyyy HH:mm:ss'}) {
    final df = DateFormat(pattern);

    return df.format(DateTime.fromMillisecondsSinceEpoch(value));
  }
}
