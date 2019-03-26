import 'package:flutter/material.dart';
import 'package:unicorndial/unicorndial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Security extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(56, 229, 9, 0.5),
        title: Text("Security"),
      ),
      body: Example(),
    );
  }
}

class Example extends StatefulWidget {
  _Example createState() => _Example();
}

class _Example extends State<Example> {

  //Reference to firebase instance


 var firestore_reference_Security=Firestore.instance.collection('user').document('Security');

                        






  
  //security_state_counter
  void security_state_counter_func(val) {
    if (val == true) {
      security_state_counter++;
    } else {
      security_state_counter--;
    }
    firestore_reference_Security.updateData({'Security_State_Counter':security_state_counter}).catchError((e){
                        print(e);
                      });
    print(security_state_counter);
  }

  int security_state_counter = 0;
  //Checkbox
  bool _ischecked1 = false;
  bool _ischecked2 = false;
  bool _ischecked3 = false;

  //security_state_color_setter FUNCTION
   Color security_state_color_func(){
     if(security_state_counter==0){
       return Colors.red;

  }

    if(security_state_counter==1){
       return Colors.red;

  }
  else if(security_state_counter==2){
       return Color.fromRGBO(229, 207, 36,1);

  }
  else if(security_state_counter==3){
       return Colors.green;

  }


  }

  //security_state_Text_setter FUNCTION

  String security_state_text_func(){
     if(security_state_counter==0){
       return "Unsecured";

  }

    if(security_state_counter==1){
       return "Unsecured";

  }
  else if(security_state_counter==2){
       return "Partially Secured";

  }
  else if(security_state_counter==3){
       return "Secured";

  }


  }

  


  @override
  Widget build(BuildContext context) {
    var childButtons = List<UnicornButton>();

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Laser",
        currentButton: FloatingActionButton(
          heroTag: "Laser",
          backgroundColor: Colors.redAccent,
          mini: true,
          child: Icon(Icons.highlight),
          onPressed: () {
            print("Laser Security");
          },
        )));

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "RFID",
        currentButton: FloatingActionButton(
            onPressed: () {
              print("RFID");
            },
            heroTag: "RFID",
            backgroundColor: Colors.green,
            mini: true,
            child: Icon(Icons.picture_in_picture))));

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "PIR",
        currentButton: FloatingActionButton(
            onPressed: () {
              print("Security System 3");
            },
            heroTag: "PIR",
            backgroundColor: Colors.blueAccent,
            mini: true,
            child: Icon(Icons.settings_input_antenna))));

    return Scaffold(
        floatingActionButton: UnicornDialer(
            backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
            parentButtonBackground: Colors.redAccent,
            orientation: UnicornOrientation.VERTICAL,
            parentButton: Icon(Icons.add),
            childButtons: childButtons),
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 90.0,
              ),
              Icon(
                FontAwesomeIcons.shieldAlt,
                color: security_state_color_func(),
                size: 160.0,
              ),
              SizedBox(
                height: 90.0,
              ),
              Text(
                security_state_text_func(),
                style: TextStyle(
                    color: security_state_color_func(),
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0),
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 140,
                  ),
                  //Laser
                  Checkbox(
                    onChanged: (bool val) {
                      security_state_counter_func(val);
                      firestore_reference_Security.updateData({'laser':val}).catchError((e){
                        print(e);
                      });

                      setState(() {
                        _ischecked1 = val;
                      });
                    },
                    value: _ischecked1,
                    activeColor: Colors.redAccent,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  //RFID
                  Checkbox(
                    onChanged: (bool val) {
                      security_state_counter_func(val);
                      firestore_reference_Security.updateData({'RFID':val}).catchError((e){
                        print(e);
                      });

                      setState(() {
                        _ischecked2 = val;
                      });
                    },
                    value: _ischecked2,
                    activeColor: Colors.green,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Checkbox(
                    onChanged: (bool val) {
                      security_state_counter_func(val);
                      firestore_reference_Security.updateData({'PIR':val}).catchError((e){
                        print(e);
                      });

                      setState(() {
                        _ischecked3 = val;
                      });
                    },
                    value: _ischecked3,
                    activeColor: Colors.blueAccent,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
