import 'package:flutter/material.dart';

import 'Screen/EmployeeDrawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'EmplokyeeManagement',debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EmployeeDrawer(),
    );
  }
}