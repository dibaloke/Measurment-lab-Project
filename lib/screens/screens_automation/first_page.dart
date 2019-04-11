import 'dart:async';
import 'package:flutter/material.dart';
import '../../models/load.dart';
import '../../utils/database_helper.dart';
import 'load_detail.dart';
import 'package:sqflite/sqflite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'dart:math';

//Firestore References
var firestore_reference_Automation =
  Firestore.instance.collection('Automation').document('bedroom');
var firestore_refernce_cfl_bedroom=Firestore.instance.collection('/Loads/CFL Light/Rooms').document('Bedroom');  

List<bool> _switchvalues = [
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,

  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false
];

//?Watch
List<Stopwatch> watch = [
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch(),
  Stopwatch()
];


class FirstPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FirstPageState();
  }
}

class FirstPageState extends State<FirstPage> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Load> loadList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (loadList == null) {
      loadList = List<Load>();
      updateListView();
    }

    return Scaffold(
      body: getLoadListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FAB clicked');
          navigateToDetail(Load('', '', 2), 'Add Load');
        },
        tooltip: 'Add Load',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getLoadListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Slidable(
          delegate: SlidableDrawerDelegate(),
          child: Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              onLongPress: () {},
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: getPriorityIcon(this.loadList[position].loadtype),
              ),
              title: Text(
                this.loadList[position].watt + "W",
                style: titleStyle,
              ),
              subtitle: Text(this.loadList[position].date),
              trailing: Switch(
                activeColor: Color.fromRGBO(247, 230, 0, 0.5),
                value: getSwitchValue(position),
                onChanged: (bool value) {
                  //!!!!!
                  //_switchvalues[position]=value;
                  //!!!!
                  firestore_reference_Automation.updateData({
                    this.loadList[position].pin: !_switchvalues[position]
                  }).catchError((e) {
                    print(e);
                  });

                  setState(() {
                    // this.loadList[position].switchvalue = value;
                    _switchvalues[position] = value;
                  //?Watch
                    if (value == true) {
                      watch[position].start();
                    } else if (value == false) {
                      
                      watch[position].stop();
                      var timeSoFar =
                          (watch[position].elapsedMilliseconds / 1000);


                      var loadtype_placeholder=this.loadList[position].loadtype;
                      var watt_placeholder=int.parse(this.loadList[position].watt);
                      var energyplaceholder=watt_placeholder*timeSoFar;
                      print("$position $timeSoFar $loadtype_placeholder");

                      firestore_refernce_cfl_bedroom.updateData({
                    position.toString():energyplaceholder
                  }).catchError((e) {
                    print(e);
                  });

                      
                    }
                    //?Watch
                  });
                },
              ),
              onTap: () {
                debugPrint("ListTile Tapped");
                navigateToDetail(this.loadList[position], 'Edit Load');
              },
            ),
          ),
          secondaryActions: <Widget>[
            IconSlideAction(
              icon: Icons.delete,
              foregroundColor: Colors.red,
              onTap: () {
                firestore_reference_Automation.updateData({
                  this.loadList[position].pin: FieldValue.delete()

                }).whenComplete(() {
                  print('Field Deleted');
                });
                firestore_refernce_cfl_bedroom.updateData({
                  position.toString(): FieldValue.delete()
                  
                }).whenComplete(() {
                  print('Field Deleted');
                });
                _delete(context, this.loadList[position]);
              },
            )
          ],
        );
      },
    );
  }

  getSwitchValue(int position) {
    // print(_switchvalues);
    return _switchvalues[position];
  }

  getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return AssetImages_list[0];
        break;
      case 2:
        return AssetImages_list[1];
        break;
      case 3:
        return AssetImages_list[2];
        break;
      case 4:
        return AssetImages_list[3];
        break;
      case 5:
        return AssetImages_list[4];
        break;

      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  void _delete(BuildContext context, Load load) async {
    int result = await databaseHelper.deleteLoad(load.id);
    if (result != 0) {
      _showSnackBar(context, ' Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: "OK",
        onPressed: () {},
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Load load, String watt) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LoadDetail(load, watt);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Load>> loadListFuture = databaseHelper.getLoadList();
      loadListFuture.then((loadList) {
        setState(() {
          this.loadList = loadList;
          this.count = loadList.length;
        });
      });
    });
  }
}

List AssetImages_list = [
  ClImageAsset(),
  TlImageAsset(),
  CflImageAsset(),
  FanImageAsset(),
  OtherImageAsset()
];

// Image Classes
class ClImageAsset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('img/cl.png');
    Image image = Image(
      image: assetImage,
      width: 250.0,
      height: 250.0,
    );
    return Container(
      child: image,
    );
  }
}

class TlImageAsset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('img/tl.png');
    Image image = Image(
      image: assetImage,
      width: 250.0,
      height: 250.0,
    );
    return Container(
      child: image,
    );
  }
}

class CflImageAsset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('img/cfl.png');
    Image image = Image(
      image: assetImage,
      width: 250.0,
      height: 250.0,
    );
    return Container(
      child: image,
    );
  }
}

class FanImageAsset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('img/f.png');
    Image image = Image(
      image: assetImage,
      width: 250.0,
      height: 250.0,
    );
    return Container(
      child: image,
    );
  }
}

class OtherImageAsset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('img/other.jpeg');
    Image image = Image(
      image: assetImage,
      width: 250.0,
      height: 250.0,
    );
    return Container(
      child: image,
    );
  }
}
