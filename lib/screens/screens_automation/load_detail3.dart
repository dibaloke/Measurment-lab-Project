import 'dart:async';
import 'package:flutter/material.dart';
import 'third_page.dart';
import '../../utils/database_helper3.dart';
import 'package:intl/intl.dart';
import '../../models/load.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


//for delete operation
 var firestore_reference_Automation=Firestore.instance.collection('Automation').document('bedroom');

class LoadDetail extends StatefulWidget {

	final String appBarTitle;
  final Load load;


	LoadDetail(this.load,this.appBarTitle);

	@override
  State<StatefulWidget> createState() {

    return LoadDetailState(this.load,this.appBarTitle);
  }
}

class LoadDetailState extends State<LoadDetail> {

	static var _loadchoices = ['Celling Light', 'Tube Light','CFL Light','Fan','Other'];

	DatabaseHelper helper = DatabaseHelper();

	String appBarTitle;
  Load load;
	

	TextEditingController wattController = TextEditingController();
	TextEditingController pinController = TextEditingController();

	LoadDetailState(this.load, this.appBarTitle);

	@override
  Widget build(BuildContext context) {

		TextStyle textStyle = Theme.of(context).textTheme.title;

		wattController.text = load.watt;
		pinController.text = load.pin;

    return WillPopScope(

	    onWillPop: () {
	    	// Write some code to control things, when user press Back navigation button in device navigationBar
		    moveToLastScreen();
	    },

	    child: Scaffold(
	    appBar: AppBar(
		    title: Text(appBarTitle),
		    leading: IconButton(icon: Icon(
				    Icons.arrow_back),
				    onPressed: () {
		    	    // Write some code to control things, when user press back button in AppBar
		    	    moveToLastScreen();
				    }
		    ),
	    ),

	    body: Padding(
		    padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
		    child: ListView(
			    children: <Widget>[

			    	// First element
				    ListTile(
					    title: DropdownButton(
							    items: _loadchoices.map((String dropDownStringItem) {
							    	return DropdownMenuItem<String> (
									    value: dropDownStringItem,
									    child: Text(dropDownStringItem),
								    );
							    }).toList(),

							    style: textStyle,

							    value: getLoadChoiceAsString(load.loadtype),
                onChanged: (valueSelectedByUser){
                  setState(() {
                    debugPrint("User Selected $valueSelectedByUser");
                    updateLoadAsInt(valueSelectedByUser);
                  });
                },
					    ),
				    ),

				    // Second Element
				    Padding(
					    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
					    child: TextField(
                keyboardType: TextInputType.number,
						    controller: wattController,
						    style: textStyle,
						    onChanged: (value) {
						    	debugPrint('Something changed in watt Text Field');
                  	updateWatt();
						      
						    },
						    decoration: InputDecoration(
							    labelText: 'Watt',
							    labelStyle: textStyle,
							    border: OutlineInputBorder(
								    borderRadius: BorderRadius.circular(5.0)
							    )
						    ),
					    ),
				    ),

				    // Third Element
				    Padding(
					    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
					    child: TextField(
                keyboardType: TextInputType.number,
						    controller: pinController,
						    style: textStyle,
						    onChanged: (value) {
							    debugPrint('Something changed in pin Text Field');
                  updatePin();
							
						    },
						    decoration: InputDecoration(
								    labelText: 'PIN',
								    labelStyle: textStyle,
								    border: OutlineInputBorder(
										    borderRadius: BorderRadius.circular(5.0)
								    )
						    ),
					    ),
				    ),

				    // Fourth Element
				    Padding(
					    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
					    child: Row(
						    children: <Widget>[
						    	Expanded(
								    child: RaisedButton(
									    color: Theme.of(context).primaryColorDark,
									    textColor: Theme.of(context).primaryColorLight,
									    child: Text(
										    'Save',
										    textScaleFactor: 1.5,
									    ),
									    onPressed: () {
									    	setState(() {
									    	  debugPrint("Save button clicked");
                           _save();
									    	  
									    	});
									    },
								    ),
							    ),

							    Container(width: 5.0,),

							    Expanded(
								    child: RaisedButton(
									    color: Theme.of(context).primaryColorDark,
									    textColor: Theme.of(context).primaryColorLight,
									    child: Text(
										    'Delete',
										    textScaleFactor: 1.5,
									    ),
									    onPressed: () {
										    setState(() {
											    debugPrint("Delete button clicked");
											      _delete();
										    });
									    },
								    ),
							    ),

						    ],
					    ),
				    ),

			    ],
		    ),
	    ),

    ));
  }

  void moveToLastScreen() {
		Navigator.pop(context, true);
  }

	// Convert the String priority in the form of integer before saving it to Database
	void updateLoadAsInt(String value) {
		switch (value) {
			case 'Celling Light':
				load.loadtype= 1;
				break;
			case 'Tube Light':
				load.loadtype = 2;
				break;
      case 'CFL Light':
				load.loadtype = 3;
				break;  
      case 'Fan':
				load.loadtype = 4;
				break; 
      case 'Other':
				load.loadtype = 5;
				break; 
		}
	}

	// Convert int priority to String priority and display it to user in DropDown
	String getLoadChoiceAsString(int value) {
		String loadchoice;
		switch (value) {
			case 1:
				loadchoice = _loadchoices[0];  //Celling Light
				break;
			case 2:
				loadchoice = _loadchoices[1];  // Tube Light
				break;
      case 3:
				loadchoice = _loadchoices[2];  // CFL Light
				break;
      case 4:
				loadchoice = _loadchoices[3];  // Fan
				break;
      case 5:
				loadchoice = _loadchoices[4];  // Other
				break;
       
		}
		return loadchoice;
	}

	// Update the title of Note object
  void updateWatt(){
    load.watt = wattController.text;
  }

	// Update the description of Note object
	void updatePin() {
		load.pin = pinController.text;
	}



// Save data to database
	void _save() async {

		moveToLastScreen();

		load.date = DateFormat.yMMMd().format(DateTime.now());
		int result;
		if (load.id != null) {  // Case 1: Update operation
			result = await helper.updateLoad(load);
		} else { // Case 2: Insert Operation
			result = await helper.insertLoad(load);
		}

		

	}

	void _delete() async {
  firestore_reference_Automation.updateData({load.pin:FieldValue.delete()}).whenComplete((){
  print('Field Deleted');
});
		moveToLastScreen();

		// Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
		// the detail page by pressing the FAB of NoteList page.
		if (load.id == null) {
			_showAlertDialog('Status', 'No  Load was deleted');
			return;
		}

		// Case 2: User is trying to delete the old note that already has a valid ID.
		int result = await helper.deleteLoad(load.id);
	
	}

	void _showAlertDialog(String watt, String message) {

		AlertDialog alertDialog = AlertDialog(
			title: Text(watt),
			content: Text(message),
		);
		showDialog(
				context: context,
				builder: (_) => alertDialog
		);
	}

  

}









