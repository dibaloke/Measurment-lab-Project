import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

 var firestore_refernce_cfl_bedroom=Firestore.instance.collection('/Loads/CFL Light/Rooms').document('Bedroom');

     getquery() async {
    var a= await firestore_refernce_cfl_bedroom.get();
    int i=0;
    while (true) {
      if(a[i.toString()]==null){
        break;
      }
      else{
        print(a[i.toString()]);
      }
      i++;
    }
    
    
  }
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
 double lightenergy=0;
 double fanenergy=0;
 double otherloadenergy=0;
  
  @override
  void initState() {
    super.initState();
    dataMap.putIfAbsent("Light", () => lightenergy);
    dataMap.putIfAbsent("Fan", () => 3);
    dataMap.putIfAbsent("Other Loads", () => 2);
    
  }

  @override
  Widget build(BuildContext context) {
   getquery();
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

   queryValues() async {
   var total = 0.0;

     
  var docs = firestore_refernce_cfl_bedroom.snapshots();
  
  
  print(docs);
}
  
}
