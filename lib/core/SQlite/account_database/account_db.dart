import 'package:shoghl/features/home_feature/data/model/account_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../../features/home_feature/data/model/treatment_model.dart';
import '../../../features/laborers_feature/data/attendance_model.dart';
import '../../../features/laborers_feature/data/laborer_model.dart';


class AccountDatabase {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initializeDatabase();
      return _db;
    } else {
      return _db;
    }
  }

  //initialize database
  initializeDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'account_database.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 3, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) {
    print('======================database upgraded======================');
  }

  //create table
  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS Account(
      accountId INTEGER PRIMARY KEY AUTOINCREMENT,
      ownerName TEXT,
      locationName TEXT,
      lastEdit TEXT,
      totalIncome INTEGER,
      totalExpenses INTEGER
    )
  ''');


    await db.execute('''
    CREATE TABLE IF NOT EXISTS Treatment(
       treatmentId INTEGER PRIMARY KEY AUTOINCREMENT,
      accountId INTEGER,
      title TEXT,
      time TEXT,
      cost INTEGER,
      details TEXT,
      isIncome INTEGER,
      FOREIGN KEY (accountId) REFERENCES Account(accountId)
    )
  ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS Laborer(
      laborerId INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      id INTEGER
    )
  ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS Attendance(
      attendanceId INTEGER PRIMARY KEY AUTOINCREMENT,
      laborerId INTEGER,
      date TEXT,
      status TEXT,
      FOREIGN KEY (laborerId) REFERENCES Laborer(laborerId)
    )
  ''');

    print('======================database created======================');
  }



  insertAccountData({required Account account}) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(
        "INSERT INTO Account(ownerName, locationName, lastEdit, totalIncome, totalExpenses) VALUES ('${account.ownerName}', '${account.locationName}', '${account.lastEdit}', ${account.totalIncome}, ${account.totalExpenses})");
    return response;
  }

  getAccountData() async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery("SELECT * FROM 'Account'");
    return response;
  }

  // Insert data into Treatment table
  insertTreatmentData({required Treatment treatment,required int accId}) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(
        "INSERT INTO Treatment(accountId, title, time, cost, details, isIncome) VALUES ('$accId','${treatment.title}', '${treatment.time}', ${treatment.cost}, '${treatment.details}', ${treatment.isIncome ? 1 : 0})");
    return response;
  }

  // Get data from Treatment table
  getTreatmentData({required int accId}) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery("SELECT * FROM 'Treatment' WHERE accountId = $accId");
    return response;
  }

  getIncomeTreatments() async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery('''
    SELECT t.*, a.ownerName as accountName 
    FROM Treatment t 
    INNER JOIN Account a ON t.accountId = a.accountId 
    WHERE t.isIncome = 0
  ''');
    return response;
  }
  getExpensesTreatments() async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery('''
    SELECT t.*, a.ownerName as accountName 
    FROM Treatment t 
    INNER JOIN Account a ON t.accountId = a.accountId 
    WHERE t.isIncome = 1
  ''');
    return response;
  }
  deleteAccountWithTreatments(int accountId) async {
    Database? mydb = await db;
    await mydb!.delete('Treatment', where: 'accountId = ?', whereArgs: [accountId]);
    await mydb.delete('Account', where: 'accountId = ?', whereArgs: [accountId]);
  }

  Future<int> insertLaborer(Laborer laborer) async {
    Database? mydb = await db;
    int response = await mydb!.insert('Laborer', laborer.toMap());
    return response;
  }

  Future<List<Laborer>> getLaborers() async {
    Database? mydb = await db;
    List<Map<String, dynamic>> response = await mydb!.query('Laborer');
    return response.map((map) => Laborer.fromMap(map)).toList();
  }

  Future<int> insertAttendance(Attendance attendance) async {
    Database? mydb = await db;
    int response = await mydb!.insert('Attendance', attendance.toMap());
    return response;
  }

  Future<int> deleteLaborer(int laborerId) async {
    Database? mydb = await db;
    await mydb!.delete('Attendance', where: 'laborerId = ?', whereArgs: [laborerId]);
    int response = await mydb.delete('Laborer', where: 'laborerId = ?', whereArgs: [laborerId]);
    return response;
  }

  Future<List<Attendance>> getAttendanceByLaborer(int laborerId) async {
    Database? mydb = await db;
    List<Map<String, dynamic>> response = await mydb!.query('Attendance', where: 'laborerId = ?', whereArgs: [laborerId]);
    return response.map((map) => Attendance.fromMap(map)).toList();
  }
}
