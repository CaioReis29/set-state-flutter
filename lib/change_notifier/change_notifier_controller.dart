import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class imcChangeNotifierController extends ChangeNotifier {
  var imc = 0.0;

  Future<void> calcularImc({required double peso, required double altura}) async {
    imc = 0;
    await Future.delayed(Duration(seconds: 2));
    notifyListeners();
    imc = peso / pow(altura, 2);
  }
}