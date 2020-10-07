import 'package:charts_flutter/flutter.dart' as charts;
import 'package:wallet_apps/index.dart';

Widget zeeChartBody(BuildContext context, List<dynamic> _portfolioData, HomeModel _homeModel) {
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      children: <Widget>[
        Card( /* Chart */
          margin: EdgeInsets.only(bottom: 35.35),
          child: Container(
            height: 261.65,
            child: Center(
              child: PointsLineChart.withSampleData(),
            ),
          ),
        ),
        // portfolioList(context, "Trading Portfolio", _portfolioData, false, _homeModel)
      ],
    ),
  );
}

class PointsLineChart extends StatelessWidget {
  
  final List<charts.Series> seriesList;
  final bool animate;

  PointsLineChart(this.seriesList, {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory PointsLineChart.withSampleData() {
    return new PointsLineChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(seriesList,
      animate: animate,
      defaultRenderer: new charts.LineRendererConfig(includePoints: true)
    );
  }

  // Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 5),
      new LinearSales(1, 25),
      new LinearSales(2, 100),
      new LinearSales(3, 75),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
