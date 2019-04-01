import 'package:flutter/material.dart';
import '../../models/load.dart';
import '../../utils/database_helper2.dart';
import 'load_detail2.dart';
import 'package:sqflite/sqflite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

var firestore_reference_Automation =
    Firestore.instance.collection('Automation').document('bedroom');
List<bool> _switchvalues1 = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,
false,false,false,false,false,false,false,false,false,false,false,false,false,
false,false,false,false,false,false,false,false,false,false,false,false,false,false,
false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,
false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,
false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,
false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,
false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,
false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,
false,false,false,false,false,false,false,false,false,false,false,false,false,false];



 
class SecondPage extends StatefulWidget {
  
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  DatabaseHelper databaseHelper1 = DatabaseHelper();
  List<Load> loadlist1;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (loadlist1 == null) {
      loadlist1 = List<Load>();
      updateListView();
    }

    return Scaffold(
      body: getloadlist1View(),
      floatingActionButton: FloatingActionButton(
        heroTag:"btn1" ,

        backgroundColor: Colors.green,
        onPressed: () {
          debugPrint('FAB clicked');
          navigateToDetail(Load('', '', 2), 'Add Load');
        },
        tooltip: 'Add Load',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getloadlist1View() {
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
                child: getPriorityIcon(this.loadlist1[position].loadtype),
              ),
              title: Text(
                this.loadlist1[position].watt + "W",
                style: titleStyle,
              ),
              subtitle: Text(this.loadlist1[position].date),
              trailing: Switch(
                activeColor: Color.fromRGBO(247, 230, 0, 0.5),
                value:getSwitchValue(position),
                onChanged: (bool value) {
                 //!!!!!
                  //_switchvalues11[position]=value;
                //!!!!
                  firestore_reference_Automation.updateData({
                    this.loadlist1[position].pin:
                         !_switchvalues1[position]
                  }).catchError((e) {
                    print(e);
                  });

                  setState(() {
                    // this.loadlist1[position].switchvalue = value;
                     _switchvalues1[position]=value;
                  });
                },
              ),
              onTap: () {
                debugPrint("ListTile Tapped");
                navigateToDetail(this.loadlist1[position], 'Edit Load');
              },
            ),
          ),
          secondaryActions: <Widget>[
            IconSlideAction(
              icon: Icons.delete,
              foregroundColor: Colors.red,
              onTap: (){
firestore_reference_Automation.updateData({this.loadlist1[position].pin:FieldValue.delete()}).whenComplete((){
  print('Field Deleted');
});
_delete(context,this.loadlist1[position]);

              },

            )
          ],
        );
      },
    );
  }

   getSwitchValue(int position) {
    
    
      // print(_switchvalues1);
      return _switchvalues1[position];

    
   
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
    int result = await databaseHelper1.deleteLoad(load.id);
    if (result != 0) {
      _showSnackBar(context, ' Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message),action:SnackBarAction(
      label:"OK" ,
      onPressed: (){
     



      },

    ) ,);
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
    final Future<Database> dbFuture = databaseHelper1.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Load>> loadlist1Future = databaseHelper1.getLoadList();
      loadlist1Future.then((loadlist1) {
        setState(() {
          this.loadlist1 = loadlist1;
          this.count = loadlist1.length;
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