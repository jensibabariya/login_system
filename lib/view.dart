import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:login_system/regestration_page.dart';
import 'package:login_system/main.dart';

class View extends StatefulWidget {
  @override
  State<View> createState() => _ViewState();
}

class _ViewState extends State<View> {
  List<Map> l = [];

  List<Map> list = [];
  bool temp = false;
  Box box = Hive.box('form');
  List data = [];
  int r_id = 0;

  List main = [];
  List user = [];

  bool t1 = false;
  TextEditingController t2 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();



    get();
  }

  get() async {
    String sql = "select * from data";
    l = await Home.database!.rawQuery(sql);
    int  a = box.get("user_details");
    String sql1 = "select * from data where id='${a}'";
    main = await Home.database!.rawQuery(sql1);
    print("main: $main");

    String sql2 = "select * from data where refer='${main[0]['id']}'";
    user = await Home.database!.rawQuery(sql2);
    print("user: $user");

    temp = true;

    setState(() {});

  }

  check_login(BuildContext context) {
    if (box.get("isLogin") == false) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return Home();
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    check_login(context);
    return Scaffold(
      drawer: Drawer(
          child: Container(
        child: ListView(
          children: [
            Container(
              height: 70,
              width: 70,
              alignment: Alignment.center,
              child: CircleAvatar(
                backgroundImage: FileImage(File("${l[0]['photo']}")),
              ),
            ),
            Card(
                child: ListTile(
              title: Text(" ${l[0]['name']} ",
                  style: TextStyle(color: Colors.black,fontSize: 18)),
            )),
            Card(
                child: ListTile(
              title: Text(" ${l[0]['email']} ",
                  style: TextStyle(color: Colors.black, fontSize: 18)),
            )),
            InkWell(onTap: () {

              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return Details(l[0]);
                },
              ));
            },
              child: Card(
                child: ListTile(
                  tileColor: Colors.blueGrey,
                  leading: Icon(Icons.edit, color: Colors.white),
                  title: Text("Edit",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                box.put("isLogin", false);
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return Home();
                  },
                ));
              },
              child: Card(
                child: ListTile(
                  tileColor: Colors.blueGrey,
                  leading: Icon(Icons.refresh, color: Colors.white),
                  title: Text(
                    "Logout",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
      appBar: AppBar(
        actions: [
          Wrap(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Details(main[0]);
                      },
                    ));
                  },
                  icon: Icon(Icons.add)),
              IconButton(onPressed: () {}, icon: Icon(Icons.search))
            ],
          )
        ],
        backgroundColor: Colors.blueGrey,
        title: Text("Contact List"),
      ),
      body: ListView.builder(
        itemCount: user.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(

              title: Text("${user[index]['name']}"),
              subtitle: Text("${user[index]['contact']}"),
              trailing: Wrap(
                children: [
                  IconButton(
                      onPressed: () {
                        String sql =
                            "delete from data where id='${user[index]['id']}'";
                        Home.database!.rawDelete(sql);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return View();
                          },
                        ));
                      },
                      icon: Icon(Icons.delete_forever)),

                  // IconButton(
                  //     onPressed: () {
                  //       Navigator.push(context, MaterialPageRoute(
                  //         builder: (context) {
                  //           return Details(user[index]);
                  //         },
                  //       ));
                  //     },
                  //     icon: Icon(Icons.edit))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
