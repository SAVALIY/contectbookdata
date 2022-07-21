import 'package:contectbookdata/Dbhelper.dart';
import 'package:contectbookdata/viewpage.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class insertpage extends StatefulWidget {
  const insertpage({Key? key}) : super(key: key);

  @override
  State<insertpage> createState() => _insertpageState();
}

class _insertpageState extends State<insertpage> {

  TextEditingController tname= TextEditingController();
  TextEditingController tcontect= TextEditingController();

  Database? db;

  void handalsubmitted(){
    tname.clear();
    tcontect.clear();
  }

  @override
  void initState() {
    super.initState();
    Dbhelper().creatdata().then((value) {

      db = value;

    },);

  }

 Future<bool> goback(){

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return viewpage();
    },));


    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(

      appBar: AppBar(title: Text("Creat Contect"),leading: IconButton(onPressed: () {

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return viewpage();
        },));

      }, icon: Icon(Icons.arrow_back_ios))),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(controller: tname,),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(controller: tcontect,),
        ),
        ElevatedButton(onPressed: () async{


          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return viewpage();
          },));
          String name = tname.text;
          String contact = tcontect.text;

          String qry = "INSERT INTO Anurag(name,contact) VALUES('$name','$contact')";
          int id = await db!.rawInsert(qry);

          handalsubmitted();

          print(id);

        }, child: Text("Save"))

      ],),


    ), onWillPop: goback);
  }
}
