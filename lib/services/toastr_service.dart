import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

abstract class IToastrService {
  void success(String message);
  void error(String message);
}

class ToastrService extends GetxService implements IToastrService {
  @override
  void error(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.red,
    );
  }

  @override
  void success(String message) {
    // TODO: implement success
  }
}
