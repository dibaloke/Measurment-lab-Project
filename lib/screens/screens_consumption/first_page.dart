import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:charts_flutter/flutter.dart' as charts;

var firestore_refernce_cfl_bedroom =
    Firestore.instance.collection('/Loads/CFL Light/Rooms').document('Bedroom');
//*Pull Data For Chart
Future<List<double>> getquery() async {
  List<double> data_list = [];
  var a = await firestore_refernce_cfl_bedroom.get();
  int i = 0;
  while (true) {
    if (a[i.toString()] == null) {
      break;
    } else {
      // print(a[i.toString()]);
    }
    data_list.add(a[i.toString()]);
    i++;
  }
  // print(data_list);
  return data_list;
}

var data = [
  Sales("Sun", 1, Colors.red),
  Sales("Mon", 0, Colors.green),
  Sales("Tue", 0, Colors.yellow),
  Sales("Wed", 0, Colors.pink),
  Sales("Thu", 0, Colors.purple),
  Sales("Fri", 0, Colors.brown),
  Sales("Sat", 0, Colors.orange),
];

//*Pull Data For Chart
class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SafeArea(child: Chart()),
    );
  }
}

class Chart extends StatefulWidget {
  Chart({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    var series = [
      charts.Series(
          domainFn: (Sales sales, _) => sales.day,
          measureFn: (Sales sales, _) => sales.sold,
          colorFn: (Sales sales, _) => sales.color,
          id: 'Sales',
          data: data)
    ];
    var chart = charts.PieChart(
      series,
      defaultRenderer: charts.ArcRendererConfig(
          arcRendererDecorators: [charts.ArcLabelDecorator()], arcWidth: 100),
      animate: true,
    );
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          getquery().then((List value) {
            data = [
              Sales("Sun", value[0], Colors.red),
              Sales("Mon", value[1], Colors.green),
              Sales("Tue", value[2], Colors.yellow),
            ];

            setState(() {
              data = [
                Sales("Sun", value[0], Colors.red),
                Sales("Mon", value[1], Colors.green),
                Sales("Tue", value[2], Colors.yellow),
              ];
            });
          });
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          children: <Widget>[
            Text(
              "Load Consumption",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 500, child: chart),
          ],
        ),
      ),
    );
  }
  

}

class Sales {
  final String day;
  double sold;
  final charts.Color color;
  Sales(this.day, this.sold, Color color)
      : this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}
