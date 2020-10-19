import 'package:flutter/material.dart';
import 'package:xlo/common/custom_drawer/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'XLO',
        ),
      ),
      drawer: CustomDrawer(),
      body: Container(),
    );
  }
}
