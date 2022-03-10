import 'package:flutter/material.dart';

abstract class BaseProvider extends ChangeNotifier {
  bool loading = false;

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }
}
