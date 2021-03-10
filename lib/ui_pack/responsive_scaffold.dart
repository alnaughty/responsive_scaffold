import 'package:flutter/material.dart';
import 'package:uitemplate/ui_pack/children/drawer_item.dart';

class ResponsiveScaffold extends StatefulWidget {
  BuildContext context;
  final Widget title;
  Color backgroundColor = Colors.white;
  Color drawerBackgroundColor = Colors.white.withOpacity(0.8);
  final List<DrawerItem> drawerItems;
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
  DrawerItem _selectedDrawerItem;
  Widget _selectedContent;
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  void onUpdate(DragUpdateDetails details) {
    setState(() {
        if(details.localPosition.dx <= maximumDrawerWidth && details.localPosition.dx >= minimumDrawerWidth){
          drawerWidth = details.localPosition.dx;
        }
    dragEndAt = details.localPosition.dx;
    });
  }
  void onDragEnd(DragEndDetails details){
    if(dragStartAt > maximumDrawerWidth - 100){
      if(dragStartAt > dragEndAt){
        setState(() {
          drawerWidth = minimumDrawerWidth;
        });
      }else{
        setState(() {
          drawerWidth = maximumDrawerWidth;
        });
      }
    }else{
      if(dragEndAt > maximumDrawerWidth - 100){
        setState(() {
          drawerWidth = maximumDrawerWidth;
        });
      }else{
        setState(() {
          drawerWidth = minimumDrawerWidth;
        });
      }
    }
    setState(() {
      dragStartAt = minimumDrawerWidth;
    });
  }
  void onDragStart(DragStartDetails details){
    setState(() {
      dragStartAt = details.localPosition.dx;
    });
  }
  @override
  void initState() {
    if(mounted){
      setState(() {
        showDrawerText = drawerWidth == maximumDrawerWidth;
        if(widget.drawerItems != null){
          for(var item in widget.drawerItems){
            if(item.content != null && item.subItems == null){
              _selectedContent = item.content;
              break;
            }
          }
        }
      });
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        //check if tablet or not
        if(MediaQuery.of(context).size.width > 900 && MediaQuery.of(context).size.width < 1600){
          minimumDrawerWidth = 60;
          if(!_showDrawer){
            drawerWidth = minimumDrawerWidth;
            showDrawerText = false;
            _showDrawer = true;
          }
        }else if(MediaQuery.of(context).size.width > 1600){
          minimumDrawerWidth = 60;
          if(_showDrawer){
            _showDrawer = false;
            drawerWidth = maximumDrawerWidth;
            showDrawerText = true;
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
                                color: item.content == _selectedContent ? Colors.grey[200] : Colors.transparent,
                                height: 60,
                                child: MaterialButton(
                                  padding: const EdgeInsets.symmetric(horizontal: 25),
                                  onPressed: item.subItems != null && item.subItems.length > 0 ? (){
                                    setState(() {
                                      if(_selectedDrawerItem == item){
                                        _selectedDrawerItem = null;
                                      }else{
                                        _selectedDrawerItem = item;
                                      }
                                    });
                                  } : item.content != null ? (){
                                    setState(() {
                                      _selectedContent = item.content;
                                    });
                                  } : null,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(item.icon,),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text("${item.text}"),
                                      ),
                                      if((item.subItems != null && item.subItems.length > 0))...{
                                        Icon(_selectedDrawerItem == item ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down)
                                      }
                                    ],
                                  ),
                                ),
                              ),
                              if((item.subItems != null && item.subItems.length > 0))...{
                                for(var sub_items in item.subItems)...{
                                  AnimatedContainer(
                                      width: double.infinity,
                                      color: _selectedContent == sub_items.content ? Colors.grey[200] : Colors.transparent,
                                      height: _selectedDrawerItem == item ? 60 : 0,
                                      duration: Duration(milliseconds: 100 * (item.subItems.indexOf(sub_items) + 1)),
                                      child: MaterialButton(
                                        onPressed: sub_items.content != null ? (){
                                          setState(() {
                                            _selectedContent  = sub_items.content;
                                          });
                                        } : null,
                                        padding: const EdgeInsets.symmetric(horizontal: 35),
                                        child: Row(
                                          children: [
                                            if(_selectedDrawerItem == item)...{
                                              Icon(sub_items.icon),
                                            },
                                            if(sub_items.title != null)...{
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(sub_items.title),
                                              )
                                            }
                                          ],
                                        ),
                                      )
                                  )
                                }
                              }
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
                                    color: _selectedContent == item.content ? Colors.grey[200] : Colors.transparent,
                                    width: double.infinity,
                                    height: 60,
                                    child: MaterialButton(
                                      padding: const EdgeInsets.symmetric(horizontal: 25),
                                      onPressed: item.subItems != null && item.subItems.length > 0 ? (){
                                        setState(() {
                                          if(_selectedDrawerItem == item){
                                            _selectedDrawerItem = null;
                                          }else{
                                            _selectedDrawerItem = item;
                                          }
                                        });
                                      } : item.content != null ? (){
                                        setState(() {
                                          _selectedContent = item.content;
                                        });
                                      } : null,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(item.icon,),
                                          if(showDrawerText)...{
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text("${item.text}"),
                                            )
                                          },
                                          if((item.subItems != null && item.subItems.length > 0) && showDrawerText)...{
                                            Icon(_selectedDrawerItem == item ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down)
                                          }
                                        ],
                                      ),
                                    ),
                                  ),
                                  if((item.subItems != null && item.subItems.length > 0) && showDrawerText)...{
                                    for(var sub_items in item.subItems)...{
                                      AnimatedContainer(
                                        width: double.infinity,
                                        color: _selectedContent == sub_items.content ? Colors.grey[200] : Colors.transparent,
                                        height: _selectedDrawerItem == item ? 60 : 0,
                                        duration: Duration(milliseconds: 100 * (item.subItems.indexOf(sub_items) + 1)),
                                        child: MaterialButton(
                                          onPressed: sub_items.content != null ? (){
                                            setState(() {
                                              _selectedContent  = sub_items.content;
                                            });
                                          } : null,
                                          padding: const EdgeInsets.symmetric(horizontal: 35),
                                          child: Row(
                                            children: [
                                              if(_selectedDrawerItem == item)...{
                                                Icon(sub_items.icon),
                                              },
                                              if(sub_items.title != null)...{
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Text(sub_items.title),
                                                )
                                              }
                                            ],
                                          ),
                                        )
                                      )
                                    }
                                  }
                                }
                              ],
                            ),
                          )
                        },
                        Expanded(
                          child: _selectedContent
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

