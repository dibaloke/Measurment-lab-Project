
class Load {

	int _id;
	String _watt;
	String _pin;
	String _date;
	int _loadtype; 
  bool _switchvalue=false;
  

	Load(this._watt, this._date, this._loadtype, [this._pin,this._switchvalue]);

	Load.withId(this._id, this._watt, this._date, this._loadtype, [this._pin]);

	int get id => _id;

	String get watt => _watt;

	String get pin => _pin;

	int get loadtype => _loadtype;

	String get date => _date;


  bool get switchvalue => _switchvalue;

	set watt(String newWatt) {
		if (newWatt.length <= 255) {
			this._watt = newWatt;
		}
	}

	set pin(String newPin) {
		if (newPin.length <= 255) {
			this._pin = newPin;
		}
	}

	set loadtype(int newLoadtype) {
		if (newLoadtype >= 1 && newLoadtype <= 6) {
			this._loadtype = newLoadtype;
		}
	}

	set date(String newDate) {
		this._date = newDate;
	}
    
   set switchvalue(bool newSwitchvalue) {
		this._switchvalue = newSwitchvalue;
	} 


	// Convert a Load object into a Map object
	Map<String, dynamic> toMap() {

		var map = Map<String, dynamic>();
		if (id != null) {
			map['id'] = _id;
		}
		map['watt'] = _watt;
		map['pin'] = _pin;
		map['loadtype'] = _loadtype;
		map['date'] = _date;
  

   
    
		return map;
	}

	// Extract a Load object from a Map object
	Load.fromMapObject(Map<String, dynamic> map) {
		this._id = map['id'];
		this._watt = map['watt'];
		this._pin = map['pin'];
		this._loadtype = map['loadtype'];
		this._date = map['date'];
   
    
    
	}
}









