import 'package:flutter/material.dart';
import './screens_automation/first_page.dart';
import './screens_automation/second_page.dart';
import './screens_automation/third_page.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Automation extends StatelessWidget {
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
        title: new Text('Automation'),
        backgroundColor: Color.fromRGBO(247, 230, 0, 0.5),
        bottom: new TabBar(
            controller: controller,
            tabs: <Widget>[
             Tab(icon: new Icon(Icons.local_hotel)),
             Tab(icon: new Icon(Icons.local_dining)),
             Tab(icon: new Icon(FontAwesomeIcons.bath)),
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