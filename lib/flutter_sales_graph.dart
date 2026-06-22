import 'package:flutter/material.dart';

/// A customizable sales bar chart widget for visualizing numeric sales data.
class FlutterSalesGraph extends StatefulWidget {
  /// The sales values represented by each bar in the chart.
  final List<double> salesData;

  /// The text labels shown below each corresponding bar.
  final List<String> labels;

  /// A selected range label (for example, "Last 7 Days") for external usage.
  final String? selectedRange;

  /// The maximum height used to scale bars relative to the largest sales value.
  final double maxBarHeight;

  /// The fixed width of each individual bar.
  final double barWidth;

  /// The palette used to color bars in order, cycling when needed.
  final List<Color> colors;

  /// The height allocated for the label line below each bar.
  final double dateLineHeight;

  /// Creates a [FlutterSalesGraph] with required sales values and labels.
  const FlutterSalesGraph({
    super.key,
    required this.salesData,
    required this.labels,
    this.selectedRange,
    this.maxBarHeight = 200.0,
    this.barWidth = 24.0,
    this.colors = const [
      Colors.blue,
      Colors.green,
      Colors.red,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.cyan,
      Colors.amber,
      Colors.indigo,
      Colors.lime,
      Colors.deepOrange,
      Colors.pink,
    ],
    this.dateLineHeight = 20.0,
  });

  @override
  _FlutterSalesGraphState createState() => _FlutterSalesGraphState();
}

class _FlutterSalesGraphState extends State<FlutterSalesGraph> {
  int? _pressedIndex;

  @override
  Widget build(BuildContext context) {
    if (widget.salesData.isEmpty ||
        widget.labels.isEmpty ||
        widget.salesData.length != widget.labels.length) {
      return Center(child: Text('No data available or labels mismatch.'));
    }

    final double maxSales = widget.salesData.reduce((a, b) => a > b ? a : b);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: double.infinity,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(widget.salesData.length, (index) {
                      final sales = widget.salesData[index];
                      final label = widget.labels[index];
                      final barHeight = maxSales > 0
                          ? (sales / maxSales) * widget.maxBarHeight
                          : 2.0;
                      final color = widget.colors[index % widget.colors.length];

                      return GestureDetector(
                        onLongPress: () {
                          setState(() {
                            _pressedIndex = index;
                          });
                        },
                        onLongPressEnd: (_) {
                          setState(() {
                            _pressedIndex = null;
                          });
                        },
                        child: Container(
                          width: widget.barWidth,
                          margin: EdgeInsets.symmetric(horizontal: 4.0),
                          child: Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.bottomCenter,
                            children: [
                              Container(
                                width: widget.barWidth,
                                height: barHeight.toDouble(),
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(4.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                              if (_pressedIndex == index)
                                Positioned(
                                  bottom: barHeight + 10, // Adjust as needed
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 4.0),
                                    color: Colors.black87,
                                    child: Text(
                                      '\$${sales.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              Positioned(
                                bottom: -20,
                                child: Container(
                                  width: widget.barWidth,
                                  height: widget.dateLineHeight,
                                  alignment: Alignment.center,
                                  child: Text(
                                    label,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
