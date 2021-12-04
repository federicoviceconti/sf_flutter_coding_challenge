import 'package:flutter/material.dart';

mixin LoaderMixin on ChangeNotifier {
  bool _showLoader = false;

  bool get showLoader => _showLoader;

  void showProgress() {
    _showLoader = true;
    notifyListeners();
  }

  void hideProgress() {
    _showLoader = false;
    notifyListeners();
  }
}