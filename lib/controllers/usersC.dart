import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myget/provider/usersP.dart';

import '../models/user.dart';

class UsersC extends GetxController {
  var users = List<User>.empty().obs;

  void snackBarError(String msg) {
    Get.snackbar(
      "ERROR",
      msg,
      duration: Duration(seconds: 2),
    );
  }

// Fungsi menambahkan data
  void add(String name, String email, String phone) {
    if (name != '' && email != '' && phone != '') {
      if (email.contains("@")) {
        UsersProvider().postData(name, email, phone).then((value) {
          users.add(
            User(
              id: value.body["name"].toString(),
              name: name,
              email: email,
              phone: phone,
            ),
          );
        });
        Get.back();
      } else {
        snackBarError("Masukan email valid");
      }
    } else {
      snackBarError("Semua data harus diisi");
    }
  }

// Fungsi mencari data

  User userById(String id) {
    return users.firstWhere((element) => element.id == id);
  }

// Fungsi mengedit data

  void edit(String id, String name, String email, String phone) {
    if (name != '' && email != '' && phone != '') {
      if (email.contains("@")) {
        UsersProvider().editData(id, name, email, phone).then((_) {
          final user = userById(id);
          user.name = name;
          user.email = email;
          user.phone = phone;
          users.refresh();
        });

        Get.back();
      } else {
        snackBarError("Masukan email valid");
      }
    } else {
      snackBarError("Semua data harus diisi");
    }
  }

// Fungsi hapus data

  Future<bool> delete(String id) async {
    bool _deleted = false;
    await Get.defaultDialog(
      title: "DELETE",
      middleText: "Apakah kamu yakin untuk menghapus data user ini?",
      textConfirm: "Ya",
      confirmTextColor: Colors.white,
      onConfirm: () {
        UsersProvider().deleteData(id).then((_) {
          users.removeWhere((element) => element.id == id);
          _deleted = true;
          Get.back();
        });
      },
      textCancel: "Tidak",
    );
    return _deleted;
  }
}
