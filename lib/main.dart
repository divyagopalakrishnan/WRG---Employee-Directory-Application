
import 'package:flutter/material.dart';

import 'src/view/employee_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Employee Data',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  EmployeeScreen(),
    );
  }
}


