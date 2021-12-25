import 'dart:convert';

class Mahasiswa {
  int id = 0;
  String nbi;
  String nama;
  String telp;
  String alamat;
  String tgl_lahir;
  String email;
  String prodi;
  String fakultas;
  int ipk;
  int dosen_wali;
  String? foto;

  Mahasiswa({
    required this.id,
    required this.nbi,
    required this.nama,
    required this.telp,
    required this.alamat,
    required this.tgl_lahir,
    required this.email,
    required this.prodi,
    required this.fakultas,
    required this.ipk,
    required this.dosen_wali,
    this.foto,
  });

  factory Mahasiswa.fromJson(Map<dynamic, dynamic> map) => Mahasiswa(
        id: map["id"],
        nbi: map["nbi"],
        nama: map["nama"],
        telp: map["telp"],
        alamat: map["alamat"],
        email: map["email"],
        tgl_lahir: map["tgl_lahir"],
        prodi: map["prodi"],
        fakultas: map["fakultas"],
        ipk: map["ipk"],
        foto: map["foto"],
        dosen_wali: map["dosen_wali"],
      );

  Map<String, String> toJson() {
    var data = {
      "id": id.toString(),
      "nbi": nbi,
      "nama": nama,
      "telp": telp,
      "alamat": alamat,
      "email": email,
      "tgl_lahir": tgl_lahir,
      "prodi": prodi,
      "fakultas": fakultas,
      "ipk": ipk.toString(),
      "dosen_wali": dosen_wali.toString(),
    };

    if (foto != null) data['foto'] = foto!;

    return data;
  }

  @override
  String toString() {
    return 'Mahasiswa{id: $id, nbi: $nbi, nama: $nama, telp: $telp, alamat: $alamat, email: $email, tgl_lahir: $tgl_lahir, prodi: $prodi, fakultas: $fakultas, foto: $foto, dosen_wali: $dosen_wali,}';
  }
}

List<Mahasiswa> MahasiswaFromJson(String jsonData) {
  final data = json.decode(jsonData)["data"]["data"];
  return List<Mahasiswa>.from(data.map((item) => Mahasiswa.fromJson(item)));
}

String MahasiswaToJson(Mahasiswa data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
