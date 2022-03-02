class Biodata {
  String? nama;
  String? alamat;
  String? tglLahir;
  int? tinggi;
  int? berat;
  String? foto;
  double? createdAt;

  Biodata(
      {this.nama,
      this.alamat,
      this.tglLahir,
      this.tinggi,
      this.berat,
      this.foto,
      this.createdAt});

  Biodata.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    alamat = json['alamat'];
    tglLahir = json['tgl_lahir'];
    tinggi = json['tinggi'];
    berat = json['berat'];
    foto = json['foto'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nama'] = nama;
    data['alamat'] = alamat;
    data['tgl_lahir'] = tglLahir;
    data['tinggi'] = tinggi;
    data['berat'] = berat;
    data['foto'] = foto;
    data['created_at'] = createdAt;
    return data;
  }
}
