import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shamo/constants.dart';
import 'package:shamo/models/dosen.dart';
import 'package:shamo/models/mahasiswa.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  var baseUrl = Constant.baseUrl;
  Client client = Client();

  Future<List<Mahasiswa>> getMahasiswas(String query) async {
    final response = await client.get(Uri.parse("$baseUrl/mahasiswa")
        .replace(queryParameters: {'query': query}));
    if (response.statusCode == 200) {
      print(response.body);
      List<Mahasiswa> data = MahasiswaFromJson(response.body);
      print(data);
      return data;
    } else {
      return [];
    }
  }

  Future login(String email, String password) async {
    final response = await client.post(Uri.parse("$baseUrl/login"), body: {
      'email': email,
      'password': password,
    });
    print(response.body);
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(
          "name", json.decode(response.body)["data"]["user"]["name"]);
      return response.body;
    } else {
      return [];
    }
  }

  Future register(String name, String email, String password) async {
    print(name);
    var b = {
      'name': name,
      'email': email,
      'password': password,
    };

    final response = await client.post(Uri.parse("$baseUrl/register"), body: b);
    print(response.body);
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("name", name);
      return response.body;
    } else {
      return [];
    }
  }

  Future<List<Dosen>> getDosens(String query) async {
    final response = await client.get(
        Uri.parse("$baseUrl/dosen").replace(queryParameters: {'query': query}));
    print(response.body);
    if (response.statusCode == 200) {
      return DosenFromJson(response.body);
    } else {
      return [];
    }
  }

  Future deleteMahasiswa(int id) async {
    final response = await client.delete(Uri.parse("$baseUrl/mahasiswa/${id}"));
    if (response.statusCode == 200) {
      return [];
    } else {
      return [];
    }
  }

  Future createMahasiwa(Mahasiswa mahasiswa, XFile imageFile) async {
    Uri uri = Uri.parse("$baseUrl/mahasiswa");

    var fileStream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var request = new http.MultipartRequest("POST", uri);
    request.fields['nbi'] = mahasiswa.nbi;
    request.fields['nama'] = mahasiswa.nama;
    request.fields['alamat'] = mahasiswa.alamat;
    request.fields['telp'] = mahasiswa.telp;
    request.fields['email'] = mahasiswa.email;
    request.fields['tgl_lahir'] = mahasiswa.tgl_lahir;
    request.fields['ipk'] = mahasiswa.ipk.toString();
    request.fields['fakultas'] = mahasiswa.fakultas;
    request.fields['prodi'] = mahasiswa.prodi;
    request.fields['dosen_wali'] = mahasiswa.dosen_wali.toString();

    request.files.add(new http.MultipartFile('foto', fileStream, length,
        filename: imageFile.name));

    var response = await request.send();
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to create Mahasiswa');
    }
  }

  Future updateMahasiwa(Mahasiswa mahasiswa, var id, XFile? imageFile) async {
    Uri uri = Uri.parse("$baseUrl/mahasiswa/${id}");

    var request = new http.MultipartRequest("POST", uri);
    request.fields['nbi'] = mahasiswa.nbi;
    request.fields['nama'] = mahasiswa.nama;
    request.fields['alamat'] = mahasiswa.alamat;
    request.fields['telp'] = mahasiswa.telp;
    request.fields['email'] = mahasiswa.email;
    request.fields['tgl_lahir'] = mahasiswa.tgl_lahir;
    request.fields['ipk'] = mahasiswa.ipk.toString();
    request.fields['fakultas'] = mahasiswa.fakultas;
    request.fields['prodi'] = mahasiswa.prodi;
    request.fields['dosen_wali'] = mahasiswa.dosen_wali.toString();

    if (imageFile != null) {
      print("image");
      var fileStream =
          new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();
      request.files.add(new http.MultipartFile('foto', fileStream, length,
          filename: imageFile.name));
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      return HttpClientResponse;
    } else {
      throw Exception('Failed to create Mahasiswa');
    }
  }

  Future deleteDosen(int id) async {
    final response = await client.delete(Uri.parse("$baseUrl/dosen/${id}"));
    print(response.body);
    if (response.statusCode == 200) {
      return [];
    } else {
      return [];
    }
  }

  Future createDosen(Dosen dosen, XFile imageFile) async {
    Uri uri = Uri.parse("$baseUrl/dosen");

    var fileStream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var request = new http.MultipartRequest("POST", uri);
    request.fields['kode_dosen'] = dosen.kode_dosen;
    request.fields['nama'] = dosen.nama;
    request.fields['alamat'] = dosen.alamat;
    request.fields['telp'] = dosen.telp;
    request.fields['email'] = dosen.email;
    request.fields['tgl_lahir'] = dosen.tgl_lahir;
    request.fields['fakultas'] = dosen.fakultas;
    request.fields['prodi'] = dosen.prodi;

    request.files.add(new http.MultipartFile('foto', fileStream, length,
        filename: imageFile.name));

    var response = await request.send();
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to create Dosen');
    }
  }

  Future updateDosen(Dosen dosen, var id, XFile? imageFile) async {
    Uri uri = Uri.parse("$baseUrl/dosen/${id}");

    var request = new http.MultipartRequest("POST", uri);
    request.fields['kode_dosen'] = dosen.kode_dosen;
    request.fields['nama'] = dosen.nama;
    request.fields['alamat'] = dosen.alamat;
    request.fields['telp'] = dosen.telp;
    request.fields['email'] = dosen.email;
    request.fields['tgl_lahir'] = dosen.tgl_lahir;
    request.fields['fakultas'] = dosen.fakultas;
    request.fields['prodi'] = dosen.prodi;

    if (imageFile != null) {
      var fileStream =
          new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();
      request.files.add(new http.MultipartFile('foto', fileStream, length,
          filename: imageFile.name));
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to create Dosen');
    }
  }
}
