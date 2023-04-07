import 'package:contact_app/models/contact_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart'as path;


class DbHelper{
  static const String _createTableContact = '''create table $tblContact(
  $tblContactColId integer primary key autoincrement, 
  $tblContactColName text, 
  $tblContactColPhone text, 
  $tblContactColEmail text, 
  $tblContactColDesignation text, 
  $tblContactColAddress text, 
  $tblContactColCompany text, 
  $tblContactColWeb text, 
  $tblContactColFavorite integer)''';


  static Future<Database> _open() async{
    final rootPath = await getDatabasesPath();
    final dbPath = path.join(rootPath,'contact.db');
    return openDatabase(dbPath,version: 1 , onCreate:(db,version){
      db.execute(_createTableContact);
    } );
  }


  // insert data (Database)

  static Future<int> insertContact(ContactModel contactModel) async{
    final db = await _open();
    return db.insert(tblContact, contactModel.toMap());
  }


  // Update Contact (Database)

  static Future<int> updateContact(int id , Map<String , dynamic> map) async{
    final db = await _open();
    return db.update(tblContact, map,where: '$tblContactColId = ?',whereArgs: [id]);
  }


  // Get All Contact (Database)

  static Future<List<ContactModel>> getAllContact() async{
    final db = await _open();
    final List<Map<String,dynamic>> mapList = await db.query(tblContact);
    return List.generate(mapList.length, (index) =>ContactModel.fromMap(mapList[index]));
  }


  // Get All Favorite Contact (Database)

  static Future<List<ContactModel>> getAllFavoriteContact() async{
    final db = await _open();
    final List<Map<String,dynamic>> mapList = await db.query(tblContact,where: '$tblContactColFavorite = ?' ,whereArgs: [1]);
    return List.generate(mapList.length, (index) =>ContactModel.fromMap(mapList[index]));
  }


  // Get Contact Details on details page by Id

  static Future<ContactModel> getAllContactById(int id) async{
    final db = await _open();
    final List<Map<String,dynamic>> mapList = await db.query(tblContact,where: '$tblContactColId = ?',whereArgs: [id]);
    return ContactModel.fromMap(mapList.first);
  }




  // Delete Contact from Databse

  static Future<int> deleteContact(int id) async{
    final db = await _open();
    return db.delete(tblContact,where: '$tblContactColId = ?',whereArgs: [id]);
  }

}