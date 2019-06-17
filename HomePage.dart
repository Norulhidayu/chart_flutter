import 'package:flutter/material.dart';
import 'PhotoUpload.dart';
import 'Posts.dart';
import 'chart.dart';
import 'package:firebase_database/firebase_database.dart';

class HomePage extends StatefulWidget
{
  @override
    State<StatefulWidget> createState()
    {
      return _HomePageState();
    }
}

class _HomePageState extends State<HomePage>
{
  List<Posts> postsList = [];

  @override
  void initState() {
    super.initState();

    DatabaseReference postsRef = FirebaseDatabase.instance.reference().child("Posts");

    postsRef.once().then((DataSnapshot snap)
    {
      var KEYS = snap.value.keys;
      var DATA = snap.value;

      postsList.clear();

      for(var individualKey in KEYS)
      {
        Posts posts = new Posts
        (
          DATA[individualKey]['image'],
          DATA[individualKey]['description'],
          DATA[individualKey]['date'],
          DATA[individualKey]['time'],
          DATA[individualKey]['day'],
        );

        postsList.add(posts);
      }

        setState(() 
        {
          print('Length : $postsList.length');
        });
    });
  }

  @override
    Widget build(BuildContext context)
    {
      return new Scaffold
      (
        appBar: new AppBar
        (
          title: new Text("Home"),
        ),

        body: new Container
        (
          child: postsList.length == 0 ? new Text("No Image Post Available") : new ListView.builder
          (
            itemCount: postsList.length,
            itemBuilder: (_, index)
            {
              return PostsUI(postsList[index].image, postsList[index].description, postsList[index].date, postsList[index].time, postsList[index].day);
            }
          ),
        ),

        bottomNavigationBar: new BottomAppBar
        (
          color: Colors.pink,

          child: new Container
          (
            margin: const EdgeInsets.only(left: 50.0 , right: 50.0),

            child: new Row
            (
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,

              children: <Widget>
              [
                new IconButton
                (
                  icon: new Icon(Icons.insert_chart),
                  iconSize: 40,
                  color: Colors.white,

                  onPressed: ()
                  {
                    Navigator.push
                    (
                      context, 
                      MaterialPageRoute(builder: (context)
                      {
                          return new MyApp();
                      })
                      );
                  },
                ),

                new IconButton
                (
                  icon: new Icon(Icons.add_a_photo),
                  iconSize: 40,
                  color: Colors.white,

                  onPressed: ()
                  {
                    Navigator.push
                    (
                      context, 
                      MaterialPageRoute(builder: (context)
                      {
                          return new UploadPhotoPage();
                      })
                      );
                  },
                ),

              ],

            ),

          ),

        ),

      );
    }

    Widget PostsUI(String image, String description, String date, String time, String day)
    {
      return new Card
      (
        elevation: 10.0,
        margin: EdgeInsets.all(15.0),

        child: new Container
        (
          padding: new EdgeInsets.all(14.0),

          child: new Column
          (
            crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>
            [
              new Row
              (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>
                [

               new Text
              (
                day,
                style: Theme.of(context).textTheme.subtitle,
                textAlign: TextAlign.center,
              ),

                  new Text
              (
                date,
                style: Theme.of(context).textTheme.subtitle,
                textAlign: TextAlign.center,
              ),

              
              new Text
              (
                time,
                style: Theme.of(context).textTheme.subtitle,
                textAlign: TextAlign.center,
              )

              
                ],
                ),

              SizedBox(height: 10.0,),

              new Image.network(image,fit: BoxFit.cover),

              SizedBox(height: 10.0,),

               new Text
              (
                description,
                style: Theme.of(context).textTheme.subhead,
                textAlign: TextAlign.center,
              ),

            ],

          ),

        ),

      );

    }
}

