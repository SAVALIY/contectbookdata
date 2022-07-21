import 'package:contectbookdata/Dbhelper.dart';
import 'package:contectbookdata/viewpage.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class insertpage extends StatefulWidget {

  Map? map;
  String? method;
  insertpage(this.method, {this.map});



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

    if(widget.method == "update")
      {
        tname.text = widget.map!['name'];
        tcontect.text = widget.map!['contact'];
      }

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



          String name = tname.text;
          String contact = tcontect.text;

          if(widget.method == "insert")
            {
              String qry = "INSERT INTO Anurag(name,contact) VALUES('$name','$contact')";
              int id = await db!.rawInsert(qry);

              if(id > 0){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return viewpage();
                },));
              }else{
                print("Not inserted Try Again");
              }


              print(id);
            }else{
            String q = " update Anurag set name='$name',contact='$contact' where id=${widget.map!['id']}";
            int id = await db!.rawUpdate(q);
            if(id==1)
              {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {

                  return viewpage();

                },));
              }
          }
        }, child: Text("${widget.method}"))

      ],),


    ), onWillPop: goback);
  }
}
