import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:uitemplate/ui_pack/children/drawer_item.dart';
import 'package:uitemplate/ui_pack/children/sub_drawer_item.dart';
import 'package:uitemplate/ui_pack/responsive_scaffold.dart';



void main() {
  runApp(MyApp());

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) {
  print("BACKGROUND HANDLER");
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
  Future<void> initializeApp() async {
    await Firebase.initializeApp();
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print("Notification Settings : $settings");
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      print("Message : ${notification.title}");
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print("MESSAGE OPENED :${event.notification.title}");
    });

  }
  @override
  void initState() {
    initializeApp();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      title: Text("TEST TITLE"),
      drawerItems: [
        DrawerItem(icon: Icons.home, text: "Home",content: Container(color: Colors.red,)),
        DrawerItem(icon: Icons.dashboard, text: "Dashboard", content: Container(color: Colors.green,)),
        DrawerItem(icon: Icons.settings, text: "Settings",content: Container(color: Colors.purple,)),
        DrawerItem(
            icon: Icons.person,
            text: "Clients",
            subItems: [
              SubDrawerItems(icon: Icons.details, title: "Details",content: Container(color: Colors.blue,)),
              SubDrawerItems(icon: Icons.event, title: "Tasks",content: Container(color: Colors.blueGrey,))
            ]
        )
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
