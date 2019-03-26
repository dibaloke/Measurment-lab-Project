import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
 
class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: SafeArea(child: MyGroupedBarChart()),
    );
  }
}

class MyGroupedBarChart extends StatefulWidget {
  @override
  _MyGroupedBarChartState createState() => _MyGroupedBarChartState();
}

class _MyGroupedBarChartState extends State<MyGroupedBarChart> {
  @override
  Widget build(BuildContext context) {
     return new charts.BarChart(
      _createSampleData(),
    
      
    );
      
    
  }

  List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      new OrdinalSales('Bedroom', 5),
      new OrdinalSales('Kitchen', 25),
      new OrdinalSales('Washroom', 100),
    
    ];

    final tableSalesData = [
      new OrdinalSales('Bedroom', 25),
      new OrdinalSales('Kitchen', 50),
      new OrdinalSales('Washroom', 10),
      
    ];

    final mobileSalesData = [
      new OrdinalSales('Bedroom', 10),
      new OrdinalSales('Kitchen', 15),
      new OrdinalSales('Washroom', 50),
     
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Desktop',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Tablet',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tableSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Mobile',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: mobileSalesData,
      ),
    ];
  }
}
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}