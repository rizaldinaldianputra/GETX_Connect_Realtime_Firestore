import 'dart:convert';
import 'package:get/get.dart';

class UsersProvider extends GetConnect {
  final url =
      "https://getconnect-project-16aeb-default-rtdb.asia-southeast1.firebasedatabase.app/";

// Simpan database
  Future<Response> postData(String name, String email, String phone) {
    final body = json.encode({
      "name": name,
      "email": email,
      "phone": phone,
    });
    return post(url + "users.json", body);
  }

  // Hapus database
  Future<Response> deleteData(String id) {
    return delete(url + "users/$id.json");
  }

  // Update database
  Future<Response> editData(
      String id, String name, String email, String phone) {
    final body = json.encode({
      "name": name,
      "email": email,
      "phone": phone,
    });
    return patch(url + "users/$id.json", body);
  }
}
