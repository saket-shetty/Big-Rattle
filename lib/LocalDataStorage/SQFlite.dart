import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class SQFliteHelper {
  final String dbname = "NewsData.db";
  final int version = 1;

  static final String tableName = "News";
  static final colID = "id";
  static final colImage = "image";
  static final colHeadline = "headline";
  static final colDescription = "description";
  static final colAuthor = "author";
  static final colDate = "date";

  Database _database;

  SQFliteHelper._privateConstructor();
  static final instance = SQFliteHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, dbname);
    return await openDatabase(path,version:version, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      '''
        CREATE TABLE $tableName(
          $colID INTEGER PRIMARYKEY,
          $colImage TEXT NOT NULL,
          $colHeadline TEXT NOT NULL,
          $colDescription TEXT NOT NULL,
          $colAuthor TEXT NOT NULL,
          $colDate TEXT NOT NULL
        ) 
      '''
    );
  }

  //INSERT

  Future<int> insert(Map<String, dynamic> row) async{
    Database db = await instance.database;
    return await db.insert(tableName, row);
  }

}
