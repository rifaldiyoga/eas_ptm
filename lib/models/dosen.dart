import 'dart:convert';

class Dosen {
  int id = 0;
  String kode_dosen;
  String nama;
  String telp;
  String alamat;
  String tgl_lahir;
  String email;
  String prodi;
  String fakultas;
  String foto;

  Dosen({
    required this.id,
    required this.kode_dosen,
    required this.nama,
    required this.telp,
    required this.alamat,
    required this.tgl_lahir,
    required this.email,
    required this.prodi,
    required this.fakultas,
    required this.foto,
  });

  factory Dosen.fromJson(Map<dynamic, dynamic> map) => Dosen(
        id: map["id"],
        kode_dosen: map["kode_dosen"],
        nama: map["nama"],
        telp: map["telp"],
        alamat: map["alamat"],
        email: map["email"],
        tgl_lahir: map["tgl_lahir"],
        prodi: map["prodi"],
        fakultas: map["fakultas"],
        foto: map["foto"],
      );

  Map<String, String> toJson() {
    return {
      "id": id.toString(),
      "kode_dosen": kode_dosen,
      "nama": nama,
      "telp": telp,
      "alamat": alamat,
      "email": email,
      "tgl_lahir": tgl_lahir,
      "prodi": prodi,
      "fakultas": fakultas,
      "foto": foto,
    };
  }

  @override
  String toString() {
    return 'Dosen{id: $id, kode_dosen: $kode_dosen, nama: $nama, telp: $telp, alamat: $alamat, email: $email, tgl_lahir: $tgl_lahir, prodi: $prodi, fakultas: $fakultas, foto: $foto, }';
  }
}

List<Dosen> DosenFromJson(String jsonData) {
  final data = json.decode(jsonData)["data"]["data"];
  return List<Dosen>.from(data.map((item) => Dosen.fromJson(item)));
}

String DosenToJson(Dosen data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
