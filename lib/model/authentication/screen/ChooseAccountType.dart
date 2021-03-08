import 'package:flutter/material.dart';

import 'package:hafeez/classes/tools/placeholder.dart';

import 'RegisterOrLoginWidget.dart';

class ChooseAccountType extends StatefulWidget {
  ChooseAccountType({
    Key key,
  }) : super(key: key);
  @override
  _ChooseAccountTypeState createState() => _ChooseAccountTypeState();
}

class _ChooseAccountTypeState extends State<ChooseAccountType> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Scaffold(
            body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(
                height: 20,
              ),
              Text('Start Log In ...'),
            ],
          ))
        : Scaffold(
            appBar: AppBar(
              backgroundColor:
                  Theme.of(context).primaryColorLight.withOpacity(0.2),
              elevation: 0,
            ),
            body: Container(
              height: double.infinity,
              color: Theme.of(context).primaryColorLight.withOpacity(0.2),
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Card(
                        color: Theme.of(context).primaryColorLight,
                        margin: const EdgeInsets.all(0),
                        child: Container(
                          height: 70,
                          child: Center(
                            child: ListTile(
                              onTap: () {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return RegisterOrLoginWidget();
                                }));
                              },
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(200),
                                    child: Image.asset(
                                      PlaceHolderImages.appLightIcon,
                                      width: 40,
                                      height: 40,
                                    ),
                                  ),
                                  Text(
                                    "  " + "حساب حفيظ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
