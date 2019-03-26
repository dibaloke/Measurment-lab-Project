import 'package:flutter/material.dart';
import './screens_consumption/first_page.dart';
import './screens_consumption/second_page.dart';
import './screens_consumption/third_page.dart';


import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Consumption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      
      body:MyHomePage()
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}
 
class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController controller;
 
  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 3);
  }
 
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Consumption'),
        backgroundColor: Colors.blue,
        bottom: new TabBar(
            controller: controller,
            tabs: <Widget>[
             Tab(icon: new Icon(Icons.pie_chart)),
             Tab(icon: new Icon(Icons.show_chart)),
             Tab(icon: new Icon(FontAwesomeIcons.chartBar)),
          ],
      ),
        ),
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
               FirstPage(),
               SecondPage(),
               ThirdPage(),
        ],
      )
    );
  }
}











