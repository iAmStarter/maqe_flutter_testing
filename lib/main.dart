import 'package:flutter/material.dart';
import 'package:mage_flutter_testing/pages/home_page.dart';

void main() {
  runApp(const MageTesting());
}

class MageTesting extends StatelessWidget {
  const MageTesting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Theerasak Mage Testing',
      home: HomePage(),
    );
  }
}
