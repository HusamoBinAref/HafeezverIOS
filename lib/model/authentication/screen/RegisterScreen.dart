import 'package:flutter/material.dart';

import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/authentication/api/authentication.dart';
import 'package:hafeez/widget/containers.dart';

class RegisterScreen extends StatefulWidget {
  final Function goLogIn;
  final bool isAnony;
  final BuildContext context;

  const RegisterScreen({
    Key key,
    this.goLogIn,
    this.isAnony = false,
    this.context,
  }) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static var _keyValidationForm = GlobalKey<FormState>();

  TextEditingController _textEditConEmail = TextEditingController();
  TextEditingController _textEditConPassword = TextEditingController();
  TextEditingController _textEditConConfirmPassword = TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool _loading = false;
  final GetAuthentication _authService = GetAuthentication();
  int dropdownValue = 0;

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
            elevation: 5.0,
            margin: EdgeInsets.all(10),
            child: Container(
              height: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Text(
                          S.of(context).register,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ), // title: login
                      Form(
                        key: _keyValidationForm,
                        child: Column(
                          children: <Widget>[
                            Card(
                              color: Colors.transparent,
                              elevation: 0,
                              child: TextFormField(
                                controller: _textEditConEmail,
                                keyboardType: TextInputType.emailAddress,
                                // validator: _validateEmail,
                                decoration: InputDecoration(
                                    labelText: S.of(context).email,
                                    labelStyle:
                                        Theme.of(context).textTheme.subtitle1,
                                    icon: Icon(
                                      Icons.email,
                                      color:
                                          Theme.of(context).primaryColorLight,
                                    )),
                              ),
                            ), //text field: email
                            Card(
                              color: Colors.transparent,
                              elevation: 0,
                              child: TextFormField(
                                controller: _textEditConPassword,
                                keyboardType: TextInputType.text,
                                validator: _validatePassword,
                                obscureText: !isPasswordVisible,
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
                            Card(
                              color: Colors.transparent,
                              elevation: 0,
                              child: TextFormField(
                                  controller: _textEditConConfirmPassword,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  validator: _validateConfirmPassword,
                                  obscureText: !isConfirmPasswordVisible,
                                  decoration: InputDecoration(
                                      labelText: S.of(context).confirm_password,
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          isConfirmPasswordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isConfirmPasswordVisible =
                                                !isConfirmPasswordVisible;
                                          });
                                        },
                                      ),
                                      icon: Icon(
                                        Icons.vpn_key,
                                        color:
                                            Theme.of(context).primaryColorLight,
                                      ))),
                            ),

                            // Register button
                            Container(
                              margin: EdgeInsets.only(top: 32.0),
                              width: double.infinity,
                              child: RaisedButton(
                                color: Theme.of(context).primaryColorLight,
                                elevation: 5.0,
                                padding:
                                    EdgeInsets.only(top: 16.0, bottom: 16.0),
                                child: Text(
                                  S.of(context).register,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
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
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0)),
                              ),
                            ), //button: register
                            Container(
                                margin:
                                    EdgeInsets.only(top: 16.0, bottom: 16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      S.of(context).already_register,
                                    ),
                                    InkWell(
                                      splashColor: Theme.of(context)
                                          .primaryColorLight
                                          .withOpacity(0.5),
                                      onTap: () {
                                        _onTappedTextlogin();
                                      },
                                      child: Text(
                                        S.of(context).logIn,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    )
                                  ],
                                )) //button: go to login //text field: password
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

  String _validatePassword(String value) {
    if (value.length < 5) {
      return S.of(context).password_length;
    } else if (value.trim() != _textEditConConfirmPassword.value.text.trim()) {
      return "notMatch";
    } else {
      return null;
    }
  }

  String _validateConfirmPassword(String value) {
    if (value.length < 5) {
      return S.of(context).password_length;
    } else if (value.trim() != _textEditConPassword.value.text.trim()) {
      return "notMatch";
    } else {
      return null;
    }
  }

  void _onTappedButtonRegister() async {
    setState(() {
      _loading = true;
    });
    dynamic result = await _authService.registerWithEmailAndPassword(
        _textEditConEmail.value.text.trim(),
        _textEditConPassword.value.text.trim());

    if (result == null) {
      setState(() {
        _loading = false;
      });
    } else {
      /// name
      // await FirebaseFirestore.instance
      //     .collection('User')
      //     .doc(FirebaseAuth.instance.currentUser.uid)
      //     .collection('Profile')
      //     .doc('name')
      //     .set({"text": _textEditConName.value.text});

      Navigator.of(widget.context).pop();
    }
  }

  void _onTappedTextlogin() {
    widget.goLogIn();
  }
}
