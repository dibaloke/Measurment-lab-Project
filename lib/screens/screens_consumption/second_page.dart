import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
 
class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child:SafeArea(child: TimeSeriesBar())
      ),
    );
  }
}

//Attempt

class TimeSeriesBar extends StatefulWidget {

  
  @override
  _TimeSeriesBarState createState() => _TimeSeriesBarState();
}

class _TimeSeriesBarState extends State<TimeSeriesBar> {

  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: charts.TimeSeriesChart(_createSampleData()),
      
    );
  }
}

List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    var data = [
      new TimeSeriesSales(new DateTime(2017, 9, 1), 5),
      new TimeSeriesSales(new DateTime(2017, 9, 2), 5),
      new TimeSeriesSales(new DateTime(2017, 9, 3), 25),
      new TimeSeriesSales(new DateTime(2017, 9, 4), 100),
      new TimeSeriesSales(new DateTime(2017, 9, 5), 75),
      new TimeSeriesSales(new DateTime(2017, 9, 6), 88),
      new TimeSeriesSales(new DateTime(2017, 9, 7), 65),
      new TimeSeriesSales(new DateTime(2017, 9, 8), 91),
      new TimeSeriesSales(new DateTime(2017, 9, 9), 100),
      new TimeSeriesSales(new DateTime(2017, 9, 10), 111),
      new TimeSeriesSales(new DateTime(2017, 9, 11), 90),
      new TimeSeriesSales(new DateTime(2017, 9, 12), 50),
      new TimeSeriesSales(new DateTime(2017, 9, 13), 40),
      new TimeSeriesSales(new DateTime(2017, 9, 14), 30),
      new TimeSeriesSales(new DateTime(2017, 9, 15), 40),
      new TimeSeriesSales(new DateTime(2017, 9, 16), 50),
      new TimeSeriesSales(new DateTime(2017, 9, 17), 30),
      new TimeSeriesSales(new DateTime(2017, 9, 18), 35),
      new TimeSeriesSales(new DateTime(2017, 9, 19), 40),
      new TimeSeriesSales(new DateTime(2017, 9, 20), 32),
      new TimeSeriesSales(new DateTime(2017, 9, 21), 31),
    ];

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }







/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
