
import 'dart:io';
import 'dart:math';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_system/main.dart';

import 'package:login_system/view.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:hive/hive.dart';

class Details extends StatefulWidget {
  Map? m;

  Details([this.m]);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  TextEditingController t4 = TextEditingController();
  ImagePicker picker = ImagePicker();
  PickedFile? image;
  String Gender = "";
  String Skill = "";
  bool is_img = false;
  String Photo = "";
  Box box = Hive.box('form');
  List<DropdownMenuItem> dd = [];
  List<DropdownMenuItem> mm = [];
  List<DropdownMenuItem> yy = [];
  String day = "DD",
      month = "MM",
      year = "YY",
      full_date = "";
  bool c1 = false,
      c2 = false,
      c3 = false;



  get() async {
    var status = await Permission.camera.status;
    var status1 = await Permission.storage.status;
    if (status.isDenied && status1.isDenied) {
      // You can request multiple permissions at once.
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
        Permission.camera,
      ].request();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
    if (widget.m != null) {
      t1.text = widget.m!['name'];
      t2.text = widget.m!['contact'];
      t3.text = widget.m!['email'];
      t4.text = widget.m!['password'];
      Gender = widget.m!['gender'];
      List skill = widget.m!['skill'].split("/");
      if (skill.contains("Android")) {
        c1 = true;
      }
      if (skill.contains("Flutter")) {
        c2 = true;
      }
      if (skill.contains("PHP")) {
        c3 = true;
      }
    }

    full_date = "$day/$month/$year";
    dd.add(DropdownMenuItem(
      child: Text("DD"),
      value: "DD",
    ));
    mm.add(DropdownMenuItem(
      child: Text("MM"),
      value: "MM",
    ));
    yy.add(DropdownMenuItem(
      child: Text("YY"),
      value: "YY",
    ));
    for (int i = 1; i <= 31; i++) {
      dd.add(DropdownMenuItem(
        child: Text("$i"),
        value: "${i}",
      ));
    }
    for (int i = 1; i <= 12; i++) {
      mm.add(DropdownMenuItem(
        child: Text("$i"),
        value: "${i}",
      ));
    }
    for (int i = 2000; i <= 2023; i++) {
      yy.add(DropdownMenuItem(
        child: Text("$i"),
        value: "${i}",
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text("Add Details"),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Card(
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: t1,
                    decoration: InputDecoration(hintText: "Enter Name"),
                  ),
                ),
                Card(
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: t2,
                    decoration: InputDecoration(hintText: "Enter Contact"),
                  ),
                ),
                Card(
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: t3,
                    decoration: InputDecoration(hintText: "Enter Email"),
                  ),
                ),
                Card(
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: t4,
                    decoration: InputDecoration(hintText: "Enter Password:"),
                  ),
                ),
                Row(
                  children: [
                    Card(
                        child: Container(
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.black)),
                          alignment: Alignment.center,
                          child: Text(
                            "Gender",
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                      activeColor: Colors.indigo,
                      value: "Female",
                      groupValue: Gender,
                      onChanged: (value) {
                        setState(() {
                          Gender = value.toString();
                        });
                      },
                    ),
                    Text(
                      "Female",
                      style: TextStyle(fontSize: 20),
                    ),
                    Radio(
                      activeColor: Colors.indigo,
                      value: "Male",
                      groupValue: Gender,
                      onChanged: (value) {
                        setState(() {
                          Gender = value.toString();
                        });
                      },
                    ),
                    Text(
                      "Male",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Card(
                        child: Container(
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.black)),
                          alignment: Alignment.center,
                          child: Text(
                            "Skill",
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: c1,
                      checkColor: Colors.indigo,
                      activeColor: Colors.white,
                      onChanged: (value) {
                        setState(() {
                          c1 = value!;
                        });
                        Text(
                          "Android",
                          style: TextStyle(fontSize: 20),
                        );
                      },
                    ),
                    Text(
                      "Android",
                      style: TextStyle(fontSize: 20),
                    ),
                    Checkbox(
                      checkColor: Colors.indigo,
                      activeColor: Colors.white,
                      value: c2,
                      onChanged: (value) {
                        setState(() {
                          c2 = value!;
                        });
                        Text(
                          "Flutter",
                          style: TextStyle(fontSize: 20),
                        );
                      },
                    ),
                    Text(
                      "Flutter",
                      style: TextStyle(fontSize: 20),
                    ),
                    Checkbox(
                      checkColor: Colors.indigo,
                      activeColor: Colors.white,
                      value: c3,
                      onChanged: (value) {
                        setState(() {
                          c3 = value!;
                        });
                        Text(
                          "PHP",
                          style: TextStyle(fontSize: 20),
                        );
                      },
                    ),
                    Text(
                      "PHP",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Card(
                        child: Container(
                          height: 30,
                          width: 90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.black)),
                          alignment: Alignment.center,
                          child: Text(
                            "Birthdate",
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton(
                      items: dd,
                      value: day,
                      onChanged: (value) {
                        day = value;
                        setState(() {});
                      },
                    ),
                    DropdownButton(
                      items: mm,
                      value: month,
                      onChanged: (value) {
                        month = value;
                        setState(() {});
                      },
                    ),
                    DropdownButton(
                      items: yy,
                      value: year,
                      onChanged: (value) {
                        year = value;
                        setState(() {});
                      },
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: Row(children: [
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title:
                              Text("Upload Photo from camera or gallery"),
                              actions: [
                                TextButton(
                                    onPressed: () async {
                                      is_img=true;
                                      image = await picker.getImage(
                                          source: ImageSource.camera);
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child: Text("Camera")),
                                TextButton(
                                    onPressed: () async {
                                      is_img=true;
                                      image = await picker.getImage(
                                          source: ImageSource.gallery);
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child: Text("Gallery"))
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 30,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.black)),
                        alignment: Alignment.center,
                        child: Text(
                          "Upload Photo",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      height: 30,
                      width: 60,
                      alignment: Alignment.center,
                      child: Text(
                        "Photo",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                        child: InkWell(
                          onTap: () async {
                            String Name = t1.text;
                            String Contact = t2.text;
                            String Email = t3.text;
                            String Password = t4.text;
                            String gender = Gender;

                            String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                            RegExp regExp = new RegExp(pattern);
                            if (Name == "") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Enter your name")));
                            } else if (Contact == "") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Enter your Contact Number")));
                            } else if (!regExp.hasMatch(Contact)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                      Text("Enter your valid Contact Number")));
                            } else if (Email == "") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Enter your Email")));
                            } else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(Email)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Enter your valid Email")));
                            } else if (Password == "") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Enter your Password")));
                            } else if (!RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                .hasMatch(Password)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Enter your valid Password")));
                            }
                            StringBuffer sb = new StringBuffer();
                            if (c1 == true) {
                              sb.write("Android");
                            }
                            if (c2 == true) {
                              if (sb.length > 0) {
                                sb.write("/");
                              }
                              sb.write("Flutter");
                            }
                            if (c3 == true) {
                              if (sb.length > 0) {
                                sb.write("/");
                              }
                              sb.write("PHP");
                            }
                            Skill = sb.toString();

                            var dir_path = await ExternalPath
                                .getExternalStoragePublicDirectory(
                                ExternalPath.DIRECTORY_DOWNLOADS) +
                                "/Images";
                            Directory Dir = Directory(dir_path);
                            if (!await Dir.exists()) {
                              Dir.create();
                            }
                            String img_name = "Myimg${Random().nextInt(1000)}.jpg";
                            if (widget.m!= null) {
                              // if (is_img == true) {
                              //   File f1 = File("${widget.m!['photo']}");
                              //   f1.delete();
                              //   File file = File("${dir_path}/${img_name}");
                              //   Photo = file.path;
                              //   file.writeAsBytes(await image!.readAsBytes());
                              // } else {
                              //   Photo = widget.m!['photo'];
                              // }
                            } else {
                              if (is_img == true) {
                                File file = File("${dir_path}/${img_name}");
                                Photo = file.path;
                                file.writeAsBytes(await image!.readAsBytes());
                              } else {
                                Photo = "";
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Upload your photo")));
                              }
                            }

                            // if (widget.m != null) {
                            //   String sql =
                            //       "update data set refer=${widget.m!['id']}, name='$Name', contact='$Contact', email='$Email', password='$Password',gender='$Gender', skill='$Skill', date='$full_date', photo='$Photo' where id='${widget.m!['id']}'";
                            //   Home.database!.rawUpdate(sql);
                            // } else {
                              if (widget.m != null) {
                                String sql =
                                    "insert into data (refer,name,contact,email,password,gender,skill,date,photo) values "
                                    "('${widget.m!['id'].toString()}','$Name','$Contact','$Email','$Password','$Gender','$Skill','$full_date','$Photo')";
                                Home.database!.rawInsert(sql);
                              }
                              else {
                                String sql =
                                    "insert into data (refer,name,contact,email,password,gender,skill,date,photo) values "
                                    "('${0}','$Name','$Contact','$Email','$Password','$Gender','$Skill','$full_date','$Photo')";

                                Home.database!.rawInsert(sql);
                              }

                              setState(() {

                              });
                              Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return Home();
                              },
                            ));
                          },
                          child: Container(
                            height: 30,
                            width: 80,
                            color: Colors.black,
                            alignment: Alignment.center,
                            child: Text(
                              "Submit",
                              style: TextStyle(fontSize: 20,
                                  color: Colors.white),
                            ),
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
