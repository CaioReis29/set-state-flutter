import 'dart:async';
import 'dart:math';

import 'package:set_state/bloc_pattern/imc_state.dart';

class imcBlocPatternController {

  final _imcStreamController = StreamController<imcState>.broadcast()
  ..add(imcState(imc: 0));

  Stream<imcState> get imcOut => _imcStreamController.stream;

  Future<void> calcularImc({required double peso, required double altura,}) async{

    _imcStreamController.add(imcStateLoading());

    await Future.delayed(Duration(seconds: 2));

    final imc = peso/pow(altura, 2);

    _imcStreamController.add(imcState(imc: imc));

  }

  void dispose() {
    _imcStreamController.close();
  }

}