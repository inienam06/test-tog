import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tambah_controller.dart';

class TambahView extends GetView<TambahController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Biodata'),
        centerTitle: true,
        leading: GestureDetector(
            onTap: () => Get.back(), child: Icon(Icons.arrow_back)),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Obx(() => Container(
                          child: Text(controller.waktu.value,
                              style: TextStyle(fontSize: 30)),
                        )),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: TextFormField(
                        controller: controller.tecNama,
                        decoration: InputDecoration(
                          labelText: 'Nama',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: TextFormField(
                        controller: controller.tecAlamat,
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          labelText: 'Alamat',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: GestureDetector(
                        onTap: () => controller.selectDate(),
                        child: TextFormField(
                          controller: controller.tecTglLahir,
                          decoration: InputDecoration(
                            enabled: false,
                            labelText: 'Tanggal Lahir',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: TextFormField(
                        controller: controller.tecTinggi,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Tinggi (cm)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: TextFormField(
                        controller: controller.tecBerat,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Berat (kg)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: GestureDetector(
                        onTap: () => controller.selectFile(),
                        child: TextFormField(
                          controller: controller.tecFoto,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            enabled: false,
                            labelText: 'Foto',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Obx(() => controller.path.value.isEmpty
                          ? Container()
                          : Image.file(File(controller.path.value))),
                    )
                  ],
                )
              ],
            ),
          )),
          Container(
            child: Obx(() => MaterialButton(
                  color: controller.disableButton.value
                      ? Colors.grey
                      : Colors.blue,
                  onPressed: () {
                    if (controller.disableButton.value) {
                      return;
                    }

                    controller.onSave();
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(16),
                    child: Text(
                      controller.disableButton.value
                          ? 'Waktu Habis!'
                          : 'Simpan',
                      style: TextStyle(
                          color: controller.disableButton.value
                              ? Colors.black
                              : Colors.white),
                    ),
                  ),
                )),
          )
        ]),
      ),
    );
  }
}
