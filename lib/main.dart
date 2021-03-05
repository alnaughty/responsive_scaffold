import 'package:flutter/material.dart';
import 'package:uitemplate/ui_pack/responsive_scaffold.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      title: Text("TEST TITLE"),
      drawerItems: [
        {
          "icon" : Icons.home,
          "title" : "Home"
        },
        {
          "icon" : Icons.dashboard,
          "title" : "Dashboard"
        },{
          "icon" : Icons.settings,
          "title" : "Settings"
        }
      ],
      drawerBackgroundColor: Colors.grey[800],
      backgroundColor: Colors.white,
        body: Container(
          color: Colors.black,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              for(var x=1;x<20;x++)...{
                GestureDetector(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blue
                    ),
                    height: 150,
                  ),
                )
              }
            ],
          ),
        )
    );
  }
}
