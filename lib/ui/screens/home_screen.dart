import 'package:flutter/material.dart';
import 'package:medcrm_mobile/ui/screens/menu_sections/employess/employee_list.dart';

void main() => runApp(MedCRMApp());

class MedCRMApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedCRM',
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [Expanded(child: EmployeeListPage())]),
    );
  }
}
