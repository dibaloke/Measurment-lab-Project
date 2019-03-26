import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
 
class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      
      body:Chart() ,
    );
    
  }
}


class Chart extends StatefulWidget {
  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
bool toggle = false;
  Map<String, double> dataMap = new Map();

  
  @override
  void initState() {
    super.initState();
    dataMap.putIfAbsent("Light", () => 5);
    dataMap.putIfAbsent("Fan", () => 3);
    dataMap.putIfAbsent("Other Loads", () => 2);
    
  }

  @override
  Widget build(BuildContext context) {
    return PieChart(
      dataMap: dataMap,
      legendFontColor: Colors.blueGrey[900],
      legendFontSize: 14.0,
      legendFontWeight: FontWeight.w500,
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: 32.0,
      chartRadius: MediaQuery
          .of(context)
          .size
          .width / 2.7,
      showChartValuesInPercentage: true,
      showChartValues: true,
      chartValuesColor: Colors.blueGrey[900].withOpacity(0.9),
      );
  }
    void togglePieChart() {
    setState(() {
      toggle = !toggle;
    });
  }
  
}
