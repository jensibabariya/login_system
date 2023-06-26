import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_system/regestration_page.dart';
import 'package:login_system/view.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory appDocumentsDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentsDir.path);

  var box = await Hive.openBox('form');
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  static Database? database;


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  Box box = Hive.box('form');

  List<Map>l=[];
bool temp=false;
  initState() {
    // TODO: implement initState
    super.initState();
    create();
    temp=box.get("isLogin")??false;

  }
 check_login(BuildContext context)
 {
   if(temp==true)
     {
       Future.delayed(Duration.zero).then((value) =>
       Navigator.push(context, MaterialPageRoute(builder: (context) {
         return View();
       },)));
     }
 }

  create() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    Home.database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
         '''CREATE TABLE data(id INTEGER PRIMARY KEY AUTOINCREMENT , refer TEXT, name TEXT, contact TEXT, email TEXT,password TEXT,gender TEXT,skill TEXT,date TEXT,photo TEXT)''');



    });

  }

  @override
  Widget build(BuildContext context) {
   check_login(context);
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: 40,
              child: Text(
                "Login To Your Account",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextField(
              controller: t1,
              decoration: InputDecoration(
                hintText: "Enter Username",
              ),
              textAlign: TextAlign.center,
            ),
            TextField(
              controller: t2,
              decoration: InputDecoration(
                hintText: "Enter Password",
              ),
              textAlign: TextAlign.center,
            ),
            InkWell(
              onTap: () async {
                  String nme=t1.text;
                  String pass=t2.text;
                  String sql="select * from data where name='$nme' and password='$pass'";

                  List<Map> l=await Home.database!.rawQuery(sql);
                  print("l=${l[0]}");

                    if(l.length==1)
                    {
                      box.put("isLogin", true);
                      box.put("user_details", l[0]['id']);
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return View();
                      },));
                    }
                    else
                    {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Invalid username or password")));
                    }

                  },
              child: Container(
                decoration: BoxDecoration(color: Colors.blueGrey),
                margin: EdgeInsets.all(10),
                alignment: Alignment.center,
                height: 40,
                width: 80,
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {

                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return Details();

                  },
                ));


              },
              child: Container(
                margin: EdgeInsets.all(10),
                alignment: Alignment.center,
                height: 50,
                width: double.infinity,
                child: Text(
                  "Create New Account",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
