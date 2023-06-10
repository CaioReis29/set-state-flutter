import 'package:flutter/material.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:intl/intl.dart';
import 'package:set_state/bloc_pattern/bloc_pattern_controller.dart';
import 'package:set_state/bloc_pattern/imc_state.dart';

import '../widgets/imc_gauge.dart';

class BlocPatternPage extends StatefulWidget {
  const BlocPatternPage({Key? key}) : super(key: key);

  @override
  State<BlocPatternPage> createState() => _BlocPatternPageState();
}

class _BlocPatternPageState extends State<BlocPatternPage> {
  final controller = imcBlocPatternController();
  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void dispose() {
    pesoEC.dispose();
    alturaEC.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IMC SetState'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                StreamBuilder<imcState>(
                  stream: controller.imcOut,
                  builder: (context, snapshot) {

                  var imc = snapshot.data?.imc ?? 0;

                  return ImcGauge(imc: imc);
                }),
                StreamBuilder<imcState>(
                  stream: controller.imcOut,
                  builder: (context, snapshot) {
                    return Visibility(
                      visible: snapshot.data is imcStateLoading,
                      replacement: Text('Pronto'),
                      child: Center(
                        child: CircularProgressIndicator(),
                      )
                      );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                    controller: pesoEC,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Peso: '),
                    inputFormatters: [
                      CurrencyTextInputFormatter(
                        locale: 'pt_BR',
                        symbol: '',
                        decimalDigits: 2,
                        turnOffGrouping: true,
                      ),
                    ],
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Esse campo é obrigatório';
                      }
                    }),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: alturaEC,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Altura: '),
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                      locale: 'pt_BR',
                      symbol: '',
                      decimalDigits: 2,
                      turnOffGrouping: true,
                    ),
                  ],
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Esse campo é obrigatório';
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    var formValid = formKey.currentState?.validate() ?? false;

                    if (formValid) {
                      var formatter = NumberFormat.simpleCurrency(
                        locale: 'pt_BR',
                        decimalDigits: 2,
                      );

                      double peso = formatter.parse(pesoEC.text) as double;
                      double altura = formatter.parse(alturaEC.text) as double;

                      controller.calcularImc(peso: peso, altura: altura);
                    }
                  },
                  child: Text('Calcular IMC'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
