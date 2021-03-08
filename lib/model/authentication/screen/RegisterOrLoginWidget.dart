import 'package:flutter/material.dart';

import 'LogInScreen.dart';
import 'RegisterScreen.dart';

class RegisterOrLoginWidget extends StatefulWidget {
  RegisterOrLoginWidget({Key key}) : super(key: key);

  @override
  _RegisterOrLoginWidgetState createState() => _RegisterOrLoginWidgetState();
}

class _RegisterOrLoginWidgetState extends State<RegisterOrLoginWidget> {
  int isRegister = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: isRegister == 0
            ? LogInScreen(
                goRegister: () {
                  setState(() {
                    isRegister = (isRegister + 1) % 2;
                  });
                },
                context: context,
              )
            : RegisterScreen(
                goLogIn: () {
                  setState(() {
                    isRegister = (isRegister + 1) % 2;
                  });
                },
                context: context,
              ),
      ),
    );
  }
}
