import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';

Widget syncFusionChart() {
  return Container(
    margin: EdgeInsets.all(size4),
    child: SfCartesianChart(
      primaryXAxis: CategoryAxis(), // Initialize category axis.
      series: <LineSeries<SalesData, String>>[ 
        LineSeries<SalesData, String>(
          color: getHexaColor(lightBlueSky),
          dataSource: [
            SalesData('Jan', 35),
            SalesData('Feb', 28),
            SalesData('Mar', 34),
            SalesData('Apr', 32),
            SalesData('May', 40)
          ],
          xValueMapper: (SalesData sales, _) => sales.year,
          yValueMapper: (SalesData sales, _) => sales.sales,
          isVisible: true
        )
      ]
    ),
  );
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}