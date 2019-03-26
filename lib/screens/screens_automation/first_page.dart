import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
//Switch
  bool _value1 = false;
  bool _value2 = false;
  bool _value3 = false;
  bool _value4 = false;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, position) {
        return Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
          Card(
            elevation: 7.0,
            child: Container(
                padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
                child: ExpansionTile(
                  title: ListTile(
                    leading: CircleAvatar(
                      radius: 40.0,
                      backgroundColor: Colors.transparent,
                      child: AssetImages_list[0],
                    ),
                    subtitle: Text("Celling Light"),
                    trailing: Switch(
                      activeColor: Color.fromRGBO(247, 230, 0, 0.5),
                      value: _value1,
                      onChanged: (bool value) {
                        setState(() {
                          _value1 = value;
                        });
                      },
                    ),
                  ),
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                          height: 60.0,
                          width: 55.0,
                        ),
                        Text("60W"),
                        SizedBox(
                          height: 60.0,
                          width: 150.0,
                        ),
                        Text("Installation:20/03/2019"),
                      ],
                    )
                  ],
                )),
          ),
          Card(
            elevation: 7.0,
            child: Container(
                padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
                child: ExpansionTile(
                                  title: ListTile(
                    leading: CircleAvatar(
                      radius: 40.0,
                      backgroundColor: Colors.transparent,
                      child: AssetImages_list[1],
                    ),
                    subtitle: Text("Tube light"),
                    trailing: Switch(
                      activeColor: Color.fromRGBO(247, 230, 0, 0.5),
                      value: _value2,
                      onChanged: (bool value) {
                        setState(() {
                          _value2 = value;
                        });
                      },
                    ),
                  ),
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                          height: 60.0,
                          width: 55.0,
                        ),
                        Text("60W"),
                        SizedBox(
                          height: 60.0,
                          width: 150.0,
                        ),
                        Text("Installation:20/03/2019"),
                      ],
                    )
                  ],
                )),
          ),
          Card(
            elevation: 7.0,
            child: Container(
                padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
                child: ExpansionTile(
                                  title: ListTile(
                    leading: CircleAvatar(
                      radius: 40.0,
                      backgroundColor: Colors.transparent,
                      child: CflImageAsset(),
                    ),
                    subtitle: Text("CFL Light"),
                    trailing: Switch(
                      activeColor: Color.fromRGBO(247, 230, 0, 0.5),
                      value: _value3,
                      onChanged: (bool value) {
                        setState(() {
                          _value3 = value;
                        });
                      },
                    ),
                  ),
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                          height: 60.0,
                          width: 55.0,
                        ),
                        Text("60W"),
                        SizedBox(
                          height: 60.0,
                          width: 150.0,
                        ),
                        Text("Installation:20/03/2019"),
                      ],
                    )
                  ],
                )

                ),
          ),
          Card(
            elevation: 7.0,
            child: Container(
                padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
                child: ExpansionTile(
                                  title: ListTile(
                    leading: CircleAvatar(
                      radius: 40.0,
                      backgroundColor: Colors.transparent,
                      child: AssetImages_list[3],
                    ),
                    subtitle: Text("Fan"),
                    trailing: Switch(
                      activeColor: Color.fromRGBO(247, 230, 0, 0.5),
                      value: _value4,
                      onChanged: (bool value) {
                        setState(() {
                          _value4 = value;
                        });
                      },
                    ),
                  ),
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                          height: 60.0,
                          width: 55.0,
                        ),
                        Text("60W"),
                        SizedBox(
                          height: 60.0,
                          width: 150.0,
                        ),
                        Text("Installation:20/03/2019"),
                      ],
                    )
                  ],
                )),
          ),
          Card(
            elevation: 7.0,
            child: Container(),
          ),
        ]);
      },
    );
  }
}

//Image Array
List AssetImages_list = [
  ClImageAsset(),
  TlImageAsset(),
  CflImageAsset(),
  FanImageAsset()
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
