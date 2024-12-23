import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

final String base_url = 'http://127.0.0.1:8000/api/';
late String endpoint;
late SharedPreferences prefs;

Future<void> initializePreferences() async {
  prefs = await SharedPreferences.getInstance();
}

Future<String?> getAccessToken() async {
  await initializePreferences();
  return prefs.getString('access_token');
}

Future<Map<String, String>> _getHeaders() async {
  final accessToken = await getAccessToken();

  if (base_url.contains('ngrok')) {
    return {
      'Authorization' : 'Bearer $accessToken',
      'ngrok-skip-browser-warning': '69420',
    };
  }
  return {
    'Authorization' : 'Bearer $accessToken',
  };
}

Future<Map<String, dynamic>> login(String email, String password) async {
  endpoint = 'login';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'email': email,
    'password': password,
    'role': 'admin,admin_fakultas,admin_kelas',
  });
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to login');
  }
}

Future<List<Map<String, dynamic>>> getAllPeminjaman() async {
  endpoint = 'peminjaman';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, 
    headers: await _getHeaders()
    );
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List<Map<String, dynamic>>> getPeminjamanLab() async {
  endpoint = 'peminjaman/lab';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, 
    headers: await _getHeaders()
    );
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List<Map<String, dynamic>>> getPeminjamanKelas() async {
  endpoint = 'peminjaman/kelas';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, 
    headers: await _getHeaders()
    );
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List<Map<String, dynamic>>> getPeminjamanCount() async {
  endpoint = 'peminjaman/count';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, 
    headers: await _getHeaders()
    );
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load data');
  }
}

Future<int> verifikasiPeminjaman(String id, String status) async {
  endpoint = 'peminjaman/verifikasi';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'id': id,
    'status': status == 'Terima' ? 'approved' : 'rejected',
  }, headers: await _getHeaders());
  print(response.body);
  return response.statusCode;
}

Future<List<Map<String, dynamic>>> getAllKendala() async {
  endpoint = 'kendala';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List<Map<String, dynamic>>> getKendalaLab() async {
  endpoint = 'kendala/lab';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List<Map<String, dynamic>>> getKendalaKelas() async {
  endpoint = 'kendala/kelas';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load data');
  }
}

Future<int> verifikasiKendala(String id, String status, String keterangan) async {
  endpoint = 'kendala/verifikasi';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'id': id,
    'status': status,
    'keterangan_penyelesaian': keterangan,
  }, headers: await _getHeaders());
  print(response.body);
  return response.statusCode;
}

Future<List<Map<String, dynamic>>> getAllJadwal() async {
  endpoint = 'jadwal';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load data');
  }
}

Future<int> verifikasiJadwal(String id, String status) async {
  endpoint = 'verifikasi_jadwal';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'id': id,
    'status': status,
  }, headers: await _getHeaders());
  print(response.body);
  return response.statusCode;
}

Future<List<Map<String, dynamic>>> getAllKode() async {
  endpoint = 'kode';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load data');
  }
}

Future<int> verifikasiKode(String id, String status) async {
  endpoint = 'verifikasi_kode';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'id': id,
    'status': status,
  }, headers: await _getHeaders());
  print(response.body);
  return response.statusCode;
}

Future<List> getRuang(String tipe) async {
  endpoint = 'ruangan?tipe=$tipe';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  var responseBody = json.decode(response.body);
  return responseBody;
}

Future<List> getPeminjamanStatistik(String room) async {
  endpoint = 'peminjaman/statistik?tipe=$room';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  // print(response.body);
  var responseBody = json.decode(response.body);
  return responseBody['data'];
}

Future<List> getKendalaStatistik(String room) async {
  endpoint = 'kendala/statistik?tipe=$room';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  var responseBody = json.decode(response.body);
  // print(responseBody['data']);
  return responseBody['data'];
}