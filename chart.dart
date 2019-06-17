import 'package:flutter/material.dart';
import 'Posts.dart';
import 'package:firebase_database/firebase_database.dart';

class MyApp extends StatefulWidget
{
  @override
    State<StatefulWidget> createState()
    {
      return _MyAppState();
    }
}

class _MyAppState extends State<MyApp> {

  List<Posts> postsList = [];

  var database;

  var databaseUtil;

  @override
  Future initState() async {
    super.initState();
  
DataSnapshot dataPostsDate = await database.reference().child('Posts').orderByChild('date').equalTo('13/06/2019').once();
Map<dynamic, dynamic>mapdate = await dataPostsDate.value;
List listdate = mapdate.values.toList();


 @override
    Widget build(BuildContext context){

return StreamBuilder(
stream: databaseUtil.getDate().child('date').onValue,
builder: (context, snapshot) {
  if (!snapshot.hasData) return CircularProgressIndicator();
  if (snapshot.hasData){
    Map<dynamic, dynamic> date = snapshot.data.snapshot.value;
    var datelist = date == null?[]:date.values.toList();
    var datefilter = datelist.where((i) => i["date"] == date["id"]).toList();
    return ListView.builder(
      itemCount: date.length,
    
    );

  }

}
);}
  }
}