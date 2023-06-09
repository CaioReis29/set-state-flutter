import 'package:intl/intl.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:set_state/change_notifier/change_notifier_controller.dart';
import 'package:set_state/widgets/imc_gauge.dart';

class ChangeNotifierPage extends StatefulWidget {
  const ChangeNotifierPage({Key? key}) : super(key: key);

  @override
  State<ChangeNotifierPage> createState() => _ChangeNotifierPageState();
}

final pesoEC = TextEditingController();
final alturaEC = TextEditingController();
final formKey = GlobalKey<FormState>();


class _ChangeNotifierPageState extends State<ChangeNotifierPage> {
  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();
  final controller = imcChangeNotifierController();

  @override
  void dispose() {
    pesoEC.dispose();
    alturaEC.dispose();

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
                AnimatedBuilder(
                  animation: controller, 
                  builder: (context, child) {
                    return ImcGauge(imc: controller.imc);
                  },
                  ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    controller: pesoEC,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Peso: '),
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
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: alturaEC,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Altura: '),
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
