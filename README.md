/// A widget that displays a bar chart for monthly sales data.
///
/// Requires [salesData] and [labels] to be non-empty and of the same length.
/// [selectedRange] can be used to display different time ranges.
/// Optional parameters allow customization of bar appearance and layout.
class MonthlySalesGraph extends StatelessWidget {
  /// Creates a [MonthlySalesGraph] widget.
  ///
  /// [salesData] and [labels] must not be empty and must have the same length.
  /// [selectedRange] determines which time range is currently selected.
  /// [maxBarHeight] specifies the maximum height of the bars.
  /// [barWidth] specifies the width of each bar.
  /// [colors] provides a list of colors for the bars.
  /// [dateLineHeight] specifies the height of the labels below the bars.
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
  
}
