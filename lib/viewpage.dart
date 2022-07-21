import 'package:contectbookdata/Dbhelper.dart';
import 'package:contectbookdata/insertpage.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class viewpage extends StatefulWidget {
  const viewpage({Key? key}) : super(key: key);

  @override
  State<viewpage> createState() => _viewpageState();
}

class _viewpageState extends State<viewpage> {

  List<Map<String, Object?>> l = List.empty(growable: true);
  Database? db;
  bool status = false;

  @override
  void initState() {
    super.initState();

    getalldata();

  }

  getalldata() async {
    db = await Dbhelper().creatdata();

    String qry = "SELECT * FROM Anurag";

    List<Map<String, Object?>> x = await db!.rawQuery(qry);
    l.addAll(x);


    setState(() {
      status = true;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ContectBook")),
      body: status?(l.length>0 ? ListView.builder(
        itemCount: l.length ,
        itemBuilder: (context, index) {

          Map m = l[index];

          return ListTile(
            onLongPress: () {
              showDialog(builder: (context) {

                return AlertDialog(
                  title: Text("Delete"),
                  content: Text("Are You sure to delete this contect"),
                  actions: [
                    TextButton(onPressed: () {
                      Navigator.pop(context);
                      int id = m['id'];

                      String qry = "DELETE FROM Anurag WHERE  id= '$id'";
                      db!.rawDelete(qry).then((value) {

                        l.removeAt(index);

                        setState(() {

                        });

                      },);


                    }, child: Text("Yes")),
                    TextButton(onPressed: () {
                      Navigator.pop(context);
                    }, child: Text("No")),
                  ],
                );

              },context: context);

            },

            leading:Text("${m['id']}"),
            title:Text("${m['name']}"),
            subtitle: Text("${m['contact']}"),


          );

      },):Center(child: Text("No Data Found"))) : Center(child: CircularProgressIndicator()),

      floatingActionButton:FloatingActionButton(onPressed: () {

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return insertpage();

        },));

      },child: Icon(Icons.add)),



    );
  }


}
