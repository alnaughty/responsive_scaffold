import 'package:uitemplate/pack/main_pack.dart';

void main() async{
  runApp(MyApp());
  PushNotification().init();

}
class MyApp extends StatelessWidget {
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
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      DesktopWindow.setMinWindowSize(Size(500,700));
    }
    return ResponsiveScaffold(
      title: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300]
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text("Zeus Template")
        ],
      ),
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
