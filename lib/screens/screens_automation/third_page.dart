import 'package:flutter/material.dart';
import '../../models/load.dart';
import '../../utils/database_helper3.dart';
import 'load_detail3.dart';
import 'package:sqflite/sqflite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

var firestore_reference_Automation =
    Firestore.instance.collection('Automation').document('bedroom');
List<bool> _switchvalues2 = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,
false,false,false,false,false,false,false,false,false,false,false,false,false,
false,false,false,false,false,false,false,false,false,false,false,false,false,false,
false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,
false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,
false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,
false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,
false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,
false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,
false,false,false,false,false,false,false,false,false,false,false,false,false,false];




class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {

  DatabaseHelper databaseHelper2 = DatabaseHelper();
  List<Load> loadlist2;
  int count = 0;

  @override
  Widget build(BuildContext context) {
     if (loadlist2 == null) {
      loadlist2 = List<Load>();
      updateListView();
    }

    return Scaffold(
      body: getloadlist2View(),
      floatingActionButton: FloatingActionButton(
        heroTag:"btn2",
        backgroundColor: Colors.amber,
        onPressed: () {
          debugPrint('FAB clicked');
          navigateToDetail(Load('', '', 2), 'Add Load');
        },
        tooltip: 'Add Load',
        child: Icon(Icons.add),
      ),
    );
  }
ListView getloadlist2View() {
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
                child: getPriorityIcon(this.loadlist2[position].loadtype),
              ),
              title: Text(
                this.loadlist2[position].watt + "W",
                style: titleStyle,
              ),
              subtitle: Text(this.loadlist2[position].date),
              trailing: Switch(
                activeColor: Color.fromRGBO(247, 230, 0, 0.5),
                value:getSwitchValue(position),
                onChanged: (bool value) {
                 //!!!!!
                  //_switchvalues211[position]=value;
                //!!!!
                  firestore_reference_Automation.updateData({
                    this.loadlist2[position].pin:
                         !_switchvalues2[position]
                  }).catchError((e) {
                    print(e);
                  });

                  setState(() {
                    // this.loadlist2[position].switchvalue = value;
                     _switchvalues2[position]=value;
                  });
                },
              ),
              onTap: () {
                debugPrint("ListTile Tapped");
                navigateToDetail(this.loadlist2[position], 'Edit Load');
              },
            ),
          ),
          secondaryActions: <Widget>[
            IconSlideAction(
              icon: Icons.delete,
              foregroundColor: Colors.red,
              onTap: (){
firestore_reference_Automation.updateData({this.loadlist2[position].pin:FieldValue.delete()}).whenComplete((){
  print('Field Deleted');
});
_delete(context,this.loadlist2[position]);

              },

            )
          ],
        );
      },
    );
  }

   getSwitchValue(int position) {
    
    
      // print(_switchvalues2);
      return _switchvalues2[position];

    
   
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
    int result = await databaseHelper2.deleteLoad(load.id);
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
    final Future<Database> dbFuture = databaseHelper2.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Load>> loadlist2Future = databaseHelper2.getLoadList();
      loadlist2Future.then((loadlist2) {
        setState(() {
          this.loadlist2 = loadlist2;
          this.count = loadlist2.length;
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