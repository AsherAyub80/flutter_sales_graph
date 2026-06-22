import 'package:flutter/material.dart';
import 'package:flutter_sales_graph/flutter_sales_graph.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Sales Graph Example')),
        body: Center(
          child: FlutterSalesGraph(
            salesData: const [100, 200, 150, 300, 250, 350],
            labels: const ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
            maxBarHeight: 250.0,
            barWidth: 30.0,
            colors: const [Colors.blue, Colors.green, Colors.red],
            dateLineHeight: 20.0,
          ),
        ),
      ),
    );
  }
}
