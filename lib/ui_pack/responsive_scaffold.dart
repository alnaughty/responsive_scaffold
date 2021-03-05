import 'package:flutter/material.dart';

class ResponsiveScaffold extends StatefulWidget {
  BuildContext context;
  final Widget title;
  Color backgroundColor = Colors.white;
  Color drawerBackgroundColor = Colors.white.withOpacity(0.8);
  final List<Map<dynamic,dynamic>> drawerItems;
  Widget body = Container(
    color: Colors.white,
  );
  ResponsiveScaffold({this.body,this.title,this.drawerItems, this.backgroundColor, this.drawerBackgroundColor});
  @override
  _ResponsiveScaffoldState createState() => _ResponsiveScaffoldState();
}

class _ResponsiveScaffoldState extends State<ResponsiveScaffold> {
  double drawerWidth = 0.0;
  double maximumDrawerWidth = 300;
  bool showTextField = false;
  double minimumDrawerWidth;
  double dragEndAt = 0.0;
  double dragStartAt = 0.0;
  bool showDrawerText = true;
  bool _showDrawer = false;

  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  void onUpdate(DragUpdateDetails details) {
    print(details.localPosition.direction);
    setState(() {
        if(details.localPosition.dx <= maximumDrawerWidth && details.localPosition.dx >= minimumDrawerWidth){
          drawerWidth = details.localPosition.dx;
        }
    dragEndAt = details.localPosition.dx;
    });
  }
  void onDragEnd(DragEndDetails details){
    print(dragEndAt);
    if(dragEndAt > maximumDrawerWidth - 100){
      setState(() {
        drawerWidth = maximumDrawerWidth;
      });
    }else{
      setState(() {
        drawerWidth = minimumDrawerWidth;
      });
    }
    setState(() {
      dragStartAt = minimumDrawerWidth;
    });
  }
  void onDragStart(DragStartDetails details){
    setState(() {
      dragStartAt = details.localPosition.dx;
    });
    print(dragStartAt);
  }
  @override
  void initState() {
    if(mounted){
      setState(() {
        showDrawerText = drawerWidth == maximumDrawerWidth;
      });
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        //check if tablet or not
        if(MediaQuery.of(context).size.width > 900){
          minimumDrawerWidth = 60;
          if(!_showDrawer){
            _showDrawer = true;
            drawerWidth = minimumDrawerWidth;
            showDrawerText = false;
          }
        }else{
          minimumDrawerWidth = 0;
          if(_showDrawer){
            drawerWidth = minimumDrawerWidth;
          }
          _showDrawer = false;
//          drawerWidth = maximumDrawerWidth;
        }
        return Scaffold(
          key: _key,
          drawer: MediaQuery.of(context).size.width > 900 ? null : Drawer(
            child: Container(
              color: Colors.white,
              width: 500,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: AlignmentDirectional.centerStart,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: (){
                            Navigator.of(context).pop(null);
                          },
                        ),
                        if(widget.title != null)...{
                          Container(
                            height: 60,
                            alignment: AlignmentDirectional.centerStart,
                            margin: const EdgeInsets.only(left: 15),
                            child: widget.title,
                          )
                        },
                      ],
                    )
                  ),
                  Expanded(
                      child: ListView(
                        children: [
                          if(widget.drawerItems!= null)...{
                            for(var item in widget.drawerItems)...{
                              Container(
                                width: double.infinity,
                                height: 60,
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(item['icon'],),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Text("${item['title']}"),
                                    )
                                  ],
                                ),
                              )
                            }
                          }
                        ],
                      )
                  )
                ],
              ),
            ),
          ),
          body: GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
              setState(() {
                showTextField = false;
              });
            },
            onHorizontalDragStart: MediaQuery.of(context).size.width > 900 ? onDragStart : null,
            onHorizontalDragUpdate: MediaQuery.of(context).size.width > 900 ? onUpdate : null,
            onHorizontalDragEnd: MediaQuery.of(context).size.width > 900 ? onDragEnd : null,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              color: widget.backgroundColor,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 2,
                          offset: Offset(0,3)
                        )
                      ]
                    ),

                    child: Row(
                      children: [
                        //leading
                        if(widget.drawerItems != null)...{
                          IconButton(
                            icon: Icon(Icons.menu),
                            onPressed: (){
                              if(MediaQuery.of(context).size.width > 900){
                                setState(() {
                                  drawerWidth = drawerWidth == minimumDrawerWidth ? maximumDrawerWidth : minimumDrawerWidth;
                                });
                              }else{
                                _key.currentState.openDrawer();
                              }
                            },
                          ),
                        },
                        if(widget.title != null)...{
                          Container(
                            margin: const EdgeInsets.only(left: 15),
                            alignment: AlignmentDirectional.centerStart,
                            child: widget.title,
                          ),
                        }
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        if(MediaQuery.of(context).size.width > 900)...{
                          AnimatedContainer(
                            onEnd: (){
                              setState(() {
                                showDrawerText = drawerWidth == maximumDrawerWidth;
                              });
                              print(showDrawerText);
                            },
                            duration: Duration(milliseconds: 100),
                            width: drawerWidth,
                            height: MediaQuery.of(context).size.height,
                            color: Colors.white,
                            child: ListView(
                              children: [
                                for(var item in widget.drawerItems)...{
                                  Container(
                                    width: double.infinity,
                                    height: 60,
                                    padding: EdgeInsets.symmetric(horizontal: showDrawerText ? 15 : 0),
                                    child: MaterialButton(
                                      onPressed: (){},
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(item['icon'],),
                                          if(showDrawerText)...{
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text("${item['title']}"),
                                            )
                                          }

                                        ],
                                      ),
                                    ),
                                  )
                                }
                              ],
                            ),
                          )
                        },
                        Expanded(
                          child: widget.body,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}

