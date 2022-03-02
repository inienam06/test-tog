import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    Widget _body() {
      return GetX<HomeController>(
          init: controller,
          builder: (builder) => builder.listBiodata.isEmpty
              ? Center(
                  child: Text(
                    'Tidak ada data',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              : ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: builder.listBiodata.length,
                  itemBuilder: (context, index) {
                    var model = builder.listBiodata[index];

                    return Container(
                      margin: EdgeInsets.all(8),
                      child: Card(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.file(
                              File(utf8.decode(base64.decode(model.foto!))),
                              width: 100,
                            ),
                            Expanded(
                                child: Container(
                              margin: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    model.nama!,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Container(
                                      child: Text(model.alamat!,
                                          style:
                                              TextStyle(color: Colors.grey))),
                                  Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Text(
                                          'Tanggal Lahir : ${model.tglLahir!}',
                                          style:
                                              TextStyle(color: Colors.grey))),
                                  Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Text('Tinggi : ${model.tinggi!}cm',
                                          style:
                                              TextStyle(color: Colors.grey))),
                                  Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Text('Berat : ${model.berat!}cm',
                                          style: TextStyle(color: Colors.grey)))
                                ],
                              ),
                            ))
                          ],
                        ),
                      ),
                    );
                  },
                ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Biodata'),
        centerTitle: true,
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/tambah'),
        child: Icon(Icons.add),
      ),
    );
  }
}
