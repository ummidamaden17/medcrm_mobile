import 'package:flutter/material.dart';

import '../widgets/custom_drawer.dart';
import '../widgets/custom_top_bar.dart';

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
      drawer: CustomDrawer(),
      body: Column(
        children: [Builder(builder: (context) => customTopBar(context))],
      ),
    );
  }
}
