import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


//Import Screens
import './screens/security.dart';
import './screens/automation.dart';
import './screens/consumption.dart';
import './screens/notification.dart';


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dash Board"),
        elevation: .1,
        backgroundColor: Color.fromRGBO(49, 87, 110, 1.0),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.only(top:150.0,left:20,right:20),
          children: <Widget>[
            makeDashboardItem("Security", Icons.lock, Colors.green,Color.fromRGBO(56, 229, 9, 0.1)),
            makeDashboardItem(
                "Automation", Icons.lightbulb_outline, Colors.yellow,Color.fromRGBO(247, 230, 0, 0.1)),
            makeDashboardItem("Consumption",  FontAwesomeIcons.chartBar, Colors.blue,Color.fromRGBO(0, 160, 247 ,0.1)),
            makeDashboardItem("Notifications", FontAwesomeIcons.bell, Colors.brown,Color.fromRGBO(76, 43, 0, 0.1))
          ],
        ),
      ),
    );
  }

  Card makeDashboardItem(String title, IconData icon, Color _color,Color _boxColor) {
    return Card(
        
        elevation: 3.0,
        margin: new EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color:_boxColor,),
          child: new InkWell(
            
            splashColor: _boxColor,
            onTap: () {

                // print(title);
              if(title=="Security"){
                Navigate_to_Security(context);
              }
              else if(title=="Automation"){
                Navigate_to_Automation(context);
              }
              else if(title=="Consumption"){
                Navigate_to_Consumption(context);
              }
             else if(title=="Notifications"){
                Navigate_to_Notifications(context);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                Center(
                    child: Icon(
                  icon,
                  size: 40.0,
                  color: _color,
                )),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text(title,
                      style:
                          new TextStyle(fontSize: 18.0, color: Colors.black)),
                )
              ],
            ),
          ),
        ));
  }
}
  void Navigate_to_Security(context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Security()));
}

void Navigate_to_Automation(context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Automation()));
}
void Navigate_to_Consumption(context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Consumption()));
}
void Navigate_to_Notifications(context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Notifications()));
}