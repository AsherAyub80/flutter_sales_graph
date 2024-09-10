library flutter_sales_graph;


class MonthlySalesGraph extends StatelessWidget {
  final List<double> salesData;
  final List<String> labels;
  final String selectedRange;
  final double maxBarHeight;
  final double barWidth;
  final List<Color> colors;
  final double dateLineHeight;

  const MonthlySalesGraph({
    Key? key,
    required this.salesData,
    required this.labels,
    required this.selectedRange,
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
    if (salesData.isEmpty || labels.isEmpty || salesData.length != labels.length) {
      return Center(child: Text('No data available or labels mismatch.'));
    }

    final double maxSales = salesData.reduce((a, b) => a > b ? a : b);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sales Data (${selectedRange})',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 400,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ['Last 7 Days', 'Last 30 Days', 'Last 12 Months']
                    .map((range) {
                  return ChoiceChip(
                    label: Text(range),
                    selected: selectedRange == range,
                    onSelected: (selected) {
                      // Implement logic to handle range change if needed
                    },
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(height: 16),
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
                    children: List.generate(salesData.length, (index) {
                      final sales = salesData[index];
                      final label = labels[index];
                      final barHeight = maxSales > 0 ? (sales / maxSales) * maxBarHeight : 2.0;
                      final color = colors[index % colors.length];

                      return Container(
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
                                if (sales > 0)
                                  Positioned(
                                    bottom: barHeight / 2 - 10,
                                    child: Container(
                                      width: barWidth + 20,
                                      alignment: Alignment.center,
                                      child: Transform.rotate(
                                        angle: -1.5708,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            '\$${barHeight >= 50 ? sales.toStringAsFixed(2) : sales.toStringAsFixed(0)}',
                                            style: TextStyle(
                                              fontSize: barHeight <= 50 ? barHeight / 2 : 10,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
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
