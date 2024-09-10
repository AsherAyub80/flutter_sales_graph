import 'package:flutter/material.dart';

class FlutterSalesGraph extends StatelessWidget {
  final List<double> salesData;
  final List<String> labels;
  final double maxBarHeight;
  final double barWidth;
  final List<Color> colors;
  final double dateLineHeight;

  const FlutterSalesGraph({
    Key? key,
    required this.salesData,
    required this.labels,
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (salesData.isEmpty ||
        labels.isEmpty ||
        salesData.length != labels.length) {
      return Center(child: Text('No data available or labels mismatch.'));
    }

    final double maxSales = salesData.reduce((a, b) => a > b ? a : b);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: double.infinity,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(salesData.length, (index) {
                        final sales = salesData[index];
                        final label = labels[index];
                        final barHeight = maxSales > 0
                            ? (sales / maxSales) * maxBarHeight
                            : 2.0;
                        final color = colors[index % colors.length];

                        return GestureDetector(
                          onLongPress: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Sales: \$${sales.toStringAsFixed(2)}'),
                              ),
                            );
                          },
                          child: Container(
                            width: barWidth,
                            margin: EdgeInsets.symmetric(horizontal: 4.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Stack(
                                  clipBehavior: Clip.none,
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Container(
                                      width: barWidth,
                                      height: barHeight.toDouble(),
                                      decoration: BoxDecoration(
                                        color: color,
                                        borderRadius:
                                            BorderRadius.circular(4.0),
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
                                  ],
                                ),
                                SizedBox(height: 4),
                                Container(
                                  width: barWidth,
                                  height: dateLineHeight,
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
          ),
        ],
      ),
    );
  }
}
