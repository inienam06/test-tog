import 'package:get/get.dart';

import '../biodata_model.dart';

class BiodataProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Biodata.fromJson(map);
      if (map is List)
        return map.map((item) => Biodata.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Biodata?> getBiodata(int id) async {
    final response = await get('biodata/$id');
    return response.body;
  }

  Future<Response<Biodata>> postBiodata(Biodata biodata) async =>
      await post('biodata', biodata);
  Future<Response> deleteBiodata(int id) async => await delete('biodata/$id');
}
