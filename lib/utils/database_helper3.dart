import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/load.dart';

class DatabaseHelper {

	static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
	static Database _database;                // Singleton Database

	String loadTable = 'load_table';
	String colId = 'id';
	String colWatt = 'watt';
	String colPin = 'pin';
	String colLoadType = 'loadtype';
	String colDate = 'date';

  
 

	DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

	factory DatabaseHelper() {

		if (_databaseHelper == null) {
			_databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
		}
		return _databaseHelper;
	}

	Future<Database> get database async {

		if (_database == null) {
			_database = await initializeDatabase();
		}
		return _database;
	}

	Future<Database> initializeDatabase() async {
		// Get the directory path for both Android and iOS to store database.
		Directory directory = await getApplicationDocumentsDirectory();
		String path = directory.path + 'loads2.db';

		// Open/create the database at a given path
		var loadsDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
		return loadsDatabase;
	}

	void _createDb(Database db, int newVersion) async {

		await db.execute('CREATE TABLE $loadTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colWatt TEXT, '
				'$colPin TEXT, $colLoadType INTEGER, $colDate TEXT)');
	}

	// Fetch Operation: Get all note objects from database
	Future<List<Map<String, dynamic>>> getLoadMapList() async {
		Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
		var result = await db.query(loadTable);
		return result;
	}

	// Insert Operation: Insert a Note object to database
	Future<int> insertLoad(Load load) async {
		Database db = await this.database;
		var result = await db.insert(loadTable, load.toMap());
		return result;
	}

	// Update Operation: Update a Note object and save it to database
	Future<int> updateLoad(Load load) async {
		var db = await this.database;
		var result = await db.update(loadTable, load.toMap(), where: '$colId = ?', whereArgs: [load.id]);
		return result;
	}

	// Delete Operation: Delete a Note object from database
	Future<int> deleteLoad(int id) async {
		var db = await this.database;
		int result = await db.rawDelete('DELETE FROM $loadTable WHERE $colId = $id');
		return result;
	}

	// Get number of Note objects in database
	Future<int> getCount() async {
		Database db = await this.database;
		List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $loadTable');
		int result = Sqflite.firstIntValue(x);
		return result;
	}

	// Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
	Future<List<Load>> getLoadList() async {

		var loadMapList = await getLoadMapList(); // Get 'Map List' from database
		int count = loadMapList.length;         // Count the number of map entries in db table

		List<Load> loadList = List<Load>();
		// For loop to create a 'Note List' from a 'Map List'
		for (int i = 0; i < count; i++) {
			loadList.add(Load.fromMapObject(loadMapList[i]));
		}

		return loadList;
	}

}






