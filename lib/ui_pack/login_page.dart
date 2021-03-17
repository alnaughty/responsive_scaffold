import 'dart:io';
import 'dart:math';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:uitemplate/ui_pack/faded_transition_widget.dart';
import 'package:uitemplate/ui_pack/login_children/login_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginService service = new LoginService();
  GlobalKey _key = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool showContent = (Platform.isWindows || Platform.isLinux || Platform.isMacOS) && size.width > 900;
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      DesktopWindow.setMinWindowSize(Size(500,700));
    }
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Row(
          children: [
            //content
            if(showContent)...{
              Expanded(
                child: Container(
                  color: Colors.red,
                ),
              )
            },
            Container(
              width: showContent ? size.width/3 : size.width,
              height: size.height,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  //Logo
                  AnimatedWidgetX(
                      child: Container(
                    width: size.height/5,
                    height: size.height/5,
                    color: Colors.red,
                  ), delay: 0.5, duration: Duration(milliseconds: 600),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AnimatedWidgetX(
                      child: service.field,
                      delay: 1,
                      duration: Duration(milliseconds: 600)
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AnimatedWidgetX(
                      child: service.passwordField(
                        onPress: (){
                          setState(() {
                            service.showPassword = !service.showPassword;
                          });
                        }
                      ),
                      delay: 1.5,
                      duration: Duration(milliseconds: 600)
                  ),
                  Spacer(),
                  //Button
                  AnimatedWidgetX(
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        color: Colors.red,
                      ),
                      delay: 2.5,
                      duration: Duration(milliseconds: 600)
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
