/// Bar chart example
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:wallet_apps/index.dart';

class GroupedBarChart extends StatelessWidget {

  final List<charts.Series> seriesList;
  final bool animate;

  GroupedBarChart(this.seriesList, {this.animate});

  factory GroupedBarChart.withSampleData() {
    return new GroupedBarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: true,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.grouped,
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: new charts.SmallTickRendererSpec(

        // Tick and Label styling here.
        labelStyle: new charts.TextStyleSpec(
          fontSize: 16, // size in Pts.
          color: charts.ColorUtil.fromDartColor(hexaCodeToColor(AppColors.textColor))
        ),

        // Change the line colors to match text color.
        lineStyle: new charts.LineStyleSpec(
            color: charts.ColorUtil.fromDartColor(hexaCodeToColor(AppColors.textColor))
          )
        ),
      ),

      primaryMeasureAxis: new charts.NumericAxisSpec(
        renderSpec: new charts.GridlineRendererSpec(

          // Tick and Label styling here.
          labelStyle: new charts.TextStyleSpec(
            fontSize: 16, // size in Pts.
            color: charts.ColorUtil.fromDartColor(hexaCodeToColor(AppColors.textColor))
          ),

          // Change the line colors to match text color.
          lineStyle: new charts.LineStyleSpec(
            color: charts.ColorUtil.fromDartColor(hexaCodeToColor(AppColors.textColor))
          )
        )
      ),
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    
    final desktopSalesData = [
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
    ];

    final tableSalesData = [
      new OrdinalSales('2014', 25),
      new OrdinalSales('2015', 50),
      new OrdinalSales('2016', 10),
      new OrdinalSales('2017', 20),
    ];

    final mobileSalesData = [
      new OrdinalSales('2014', 10),
      new OrdinalSales('2015', 15),
      new OrdinalSales('2016', 50),
      new OrdinalSales('2017', 45),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        seriesColor: charts.ColorUtil.fromDartColor(hexaCodeToColor("#79D29E")),
        id: 'SEL',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        seriesColor: charts.ColorUtil.fromDartColor(hexaCodeToColor("#43C378")),
        id: 'Bitcoin',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tableSalesData,
      ),
      
      new charts.Series<OrdinalSales, String>(
        areaColorFn: (_, __) => charts.ColorUtil.fromDartColor(hexaCodeToColor(AppColors.secondary)),
        seriesColor: charts.ColorUtil.fromDartColor(hexaCodeToColor(AppColors.secondary)),
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(hexaCodeToColor(AppColors.secondary)),
        // fillColorFn: (_, __) =>
        //     charts.ColorUtil.fromDartColor(hexaCodeToColor(AppColors.secondary)),
        id: 'XLM',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: mobileSalesData,
      ),
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}