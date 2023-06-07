import 'package:flutter/material.dart';
import 'package:set_state/setState/imc_setstate_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _goToPage(BuildContext context, Widget Page) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Page,
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _goToPage(context, ImcSetstatePage()), 
              child: Text('SetState')
              ),
            ElevatedButton(
              onPressed: () {}, 
              child: Text('ValueNotifier')
              ),
            ElevatedButton(
              onPressed: () {}, 
              child: Text('ChangeNotifier')
              ),
            ElevatedButton(
              onPressed: () {}, 
              child: Text('Block Pattern (Streams)')
              ),
          ],
        ),
      ),
    );
  }
}
