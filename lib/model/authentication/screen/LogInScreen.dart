import 'package:flutter/material.dart';

import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/authentication/api/authentication.dart';
import 'package:hafeez/widget/containers.dart';

class LogInScreen extends StatefulWidget {
  final Function goRegister;
  final BuildContext context;
  final bool isAnony;

  const LogInScreen({
    Key key,
    this.goRegister,
    this.context,
    this.isAnony = false,
  }) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  static var _keyValidationForm = GlobalKey<FormState>();
  TextEditingController _textEditConEmail = TextEditingController();
  TextEditingController _textEditConPassword = TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool _loading = false;
  String error = "";
  final GetAuthentication _authService = GetAuthentication();

  @override
  void initState() {
    isPasswordVisible = false;
    isConfirmPasswordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Containers.waitting(context)
        : Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            margin: EdgeInsets.all(10),
            elevation: 5.0,
            child: Container(
              height: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                        key: _keyValidationForm,
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: Text(
                                S.of(context).logIn,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ), // title: login
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: const EdgeInsets.all(5),
                              child: TextFormField(
                                controller: _textEditConEmail,
                                keyboardType: TextInputType.emailAddress,
                                validator: _validateEmail,
                                decoration: InputDecoration(
                                  labelStyle:
                                      Theme.of(context).textTheme.subtitle1,
                                  labelText: S.of(context).email,
                                  icon: Icon(
                                    Icons.email,
                                    color: Theme.of(context).primaryColorLight,
                                  ),
                                ),
                              ),
                            ), //text field: email
                            Container(
                              margin: const EdgeInsets.all(5),
                              child: TextFormField(
                                controller: _textEditConPassword,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                validator: _validatePassword,
                                obscureText: !isPasswordVisible,
                                toolbarOptions: ToolbarOptions(paste: true),
                                decoration: InputDecoration(
                                    labelText: S.of(context).password,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        isPasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color:
                                            Theme.of(context).primaryColorLight,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isPasswordVisible =
                                              !isPasswordVisible;
                                        });
                                      },
                                    ),
                                    icon: Icon(
                                      Icons.vpn_key,
                                      color:
                                          Theme.of(context).primaryColorLight,
                                    )),
                              ),
                            ), //text field: password

                            Container(
                              margin: EdgeInsets.only(top: 32.0),
                              width: double.infinity,
                              child: RaisedButton(
                                elevation: 5.0,
                                padding:
                                    EdgeInsets.only(top: 16.0, bottom: 16.0),
                                child: Text(
                                  S.of(context).logIn,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                ),
                                onPressed: () {
                                  if (_keyValidationForm.currentState
                                      .validate()) {
                                    _onTappedButtonRegister();
                                  }
                                },
                                color: Theme.of(context).primaryColorLight,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0)),
                              ),
                            ), //button: login
                            Container(
                              margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    S.of(context).not_register,
                                  ),
                                  InkWell(
                                    splashColor: Theme.of(context)
                                        .primaryColorLight
                                        .withOpacity(0.5),
                                    onTap: () {
                                      _onTappedTextlogin();
                                    },
                                    child: Text(
                                      S.of(context).register,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  String _validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return S.of(context).invalid_email;
    } else {
      return null;
    }
  }

  String _validatePassword(String value) {
    return value.length < 5 ? S.of(context).password_length : null;
  }

  void _onTappedButtonRegister() async {
    setState(() {
      _loading = true;
    });
    dynamic result = await _authService.signInWithEmailAndPassword(
        _textEditConEmail.value.text, _textEditConPassword.value.text);
    print(result.toString());
    if (result == null) {
      setState(() {
        _loading = false;
      });
    } else {
      Navigator.of(widget.context).pop();
    }
  }

  void _onTappedTextlogin() {
    widget.goRegister();
  }
}
