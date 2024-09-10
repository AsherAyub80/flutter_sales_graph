import 'package:flutter_sales_graph/flutter_sales_graph.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('MonthlySalesGraph displays sales data correctly',
      (WidgetTester tester) async {
    // Define test data
    final salesData = [100.0, 200.0, 300.0];
    final labels = ['Jan', 'Feb', 'Mar'];
    final selectedRange = 'Last 3 Months';

    // Build the widget tree
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FlutterSalesGraph(
            salesData: salesData,
            labels: labels,
            selectedRange: selectedRange,
          ),
        ),
      ),
    );

    // Check if the title text is displayed correctly
    expect(find.text('Sales Data (Last 3 Months)'), findsOneWidget);

    // Check if there are the correct number of bars (Containers)
    expect(find.byType(Container), findsWidgets);
    expect(find.byType(Container).evaluate().length,
        salesData.length * 2); // Bars and labels

    // Optionally, check specific text or bar heights
    for (var label in labels) {
      expect(find.text(label), findsOneWidget);
    }

    // Check if bars are displayed
    for (var sales in salesData) {
      expect(
          find.byWidgetPredicate(
            (widget) => widget is Container && widget.color == Colors.blue,
          ),
          findsOneWidget); // Adjust color based on the actual widget colors
    }
  });

  testWidgets('MonthlySalesGraph handles empty data gracefully',
      (WidgetTester tester) async {
    // Build the widget tree with empty data
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FlutterSalesGraph(
            salesData: [],
            labels: [],
            selectedRange: 'No Data',
          ),
        ),
      ),
    );

    // Check if the no data message is displayed
    expect(find.text('No data available or labels mismatch.'), findsOneWidget);
  });
}
