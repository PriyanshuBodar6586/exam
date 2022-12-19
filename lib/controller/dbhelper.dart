import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Dbhelper{
  Database?db;

  Future<Database>chackDatabase()async{
    if(db!=null){
     return db!;
    }else{
      return await createDatabase();
    }
  }
  Future<Database>createDatabase()async{
    Directory folder = await getApplicationDocumentsDirectory();
    String path = join(folder.path,"rnw.db");

    return openDatabase(path,version: 1,onCreate: (db,version){
      String query =
          "CREATE TABLE product(id INTEGER PRIMARY KEY AUTOINCREMENT,pname TEXT,amount TEXT,quntity Text)";
      String query1 =
          "CREATE TABLE coupon(id INTEGER PRIMARY KEY AUTOINCREMENT,cname TEXT,camount TEXT,coupon_id INTEGER,cquntity INTEGER )";
      db.execute(query1);
      db.execute(query);
    });

  }
  void insertData(String n1,String m1,String s1)async{
    db=await chackDatabase();
    db!.insert("product",{"pname":n1,"amount":m1,"quntity":s1,});
  }
  Future<List<Map>> readData()async{
    db= await chackDatabase();
    String query = "SELECT * FROM product";
    List<Map> PRODUCTList = await db!.rawQuery(query,null);
    return PRODUCTList;
  }
  void deleteData(String id)async{
    db=await chackDatabase();
    db!.delete("product",where:"id = ?",whereArgs:[int.parse(id)]);
  }
  void updataData(String id,String n1,String s1,String m1,)async{
    db=await chackDatabase();
    db!.update("product",{"pname":n1,"amount":m1,"quntity":s1},
   where: "id = ?",whereArgs: [int.parse(id)]);
  }
//==========================================================================//

  // ==========================================================================//



  Future<List<Map>> ProreadData({String? id})async{
    db= await chackDatabase();
    String query = "";
    if(id!=null)
    {
      query = "SELECT * FROM product where client_id = $id";
    }
    else
    {
      query = "SELECT * FROM coupon  ";
    }
    List<Map> COUPONList = await db!.rawQuery(query,null);
    return COUPONList;
  }

  void couponinsertData(String n1, String a1,int clientId, int cquntity) async {
    db = await chackDatabase();
    db!.insert("product", {"cname": n1, "camount":a1,"coupon_id":clientId,"cquntity":cquntity,});
  }

  Future<List<Map>> couponreadData(String id) async {
    db = await chackDatabase();
    String query = "SELECT * FROM product where client_id = $id";
    List<Map> couponlist = await db!.rawQuery(query, null);
    return couponlist;
  }

  void coupondeleteData(String id) async {
    db = await chackDatabase();
    db!.delete("coupon", where: "id = ?", whereArgs: [int.parse(id)]);
  }

  void couponupdateData(String id, String n1, String a1,int clientId,int cquntity,) async {
    db = await chackDatabase();
    db!.update("product", {"name":n1,"amount":a1,"client_id":clientId,"cquntity":cquntity,},
        where:"id = ?",whereArgs: [int.parse(id)]);
  }
}