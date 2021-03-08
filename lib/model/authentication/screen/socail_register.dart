import 'package:flutter/material.dart'
    show
        AssetImage,
        BuildContext,
        Card,
        Color,
        Colors,
        Column,
        Container,
        DropdownButton,
        DropdownMenuItem,
        FloatingActionButton,
        Hero,
        InputDecoration,
        Key,
        OutlineInputBorder,
        RaisedButton,
        Scaffold,
        StatelessWidget,
        TextField,
        Theme,
        showDatePicker;
import 'package:flutter/material.dart';

import 'package:hafeez/classes/tools/custom_date_time.dart';
import 'package:hafeez/generated/l10n.dart';

class SocialRegister extends StatelessWidget {
  const SocialRegister(
      {Key key,
      this.tag,
      this.color,
      this.image,
      this.onTap,
      this.isLoading = false})
      : super(key: key);

  final String tag;
  final Color color;
  final AssetImage image;
  final Function(BuildContext) onTap;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: color,
      //   elevation: 0,
      // ),
      backgroundColor: Colors.transparent,
      body: Hero(
        tag: tag,
        child: Container(
            color: color,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 100.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 6.0,
                      ),
                    ],
                    image: DecorationImage(
                      image: image,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: RegisterFields(
                    color: color,
                  ),
                ),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onTap(context);
        },
        child: Icon(
          Icons.check_circle,
          size: 50,
        ),
        backgroundColor: color,
      ),
    );
  }
}

class RegisterFields extends StatefulWidget {
  RegisterFields({
    Key key,
    this.color,
  }) : super(key: key);
  final Color color;

  @override
  _RegisterFieldsState createState() => _RegisterFieldsState();
}

class _RegisterFieldsState extends State<RegisterFields> {
  int dropdownValue = 0;
  int dropdownIsDead = 0;
  CustomDateTime _dateTime = CustomDateTime(
    date: DateTime.now(),
  );
  CustomDateTime _dateTimeDead = CustomDateTime(
    date: DateTime.now(),
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: EdgeInsets.all(10),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: S.of(context).account_name,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        // width: 4,
                        color: Theme.of(context).appBarTheme.color,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  enabled: false,
                  controller: TextEditingController.fromValue(
                      TextEditingValue(text: _dateTime.getDate.toString())),
                  decoration: InputDecoration(
                    labelText: S.of(context).account_prith_date,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        // width: 4,
                        color: Theme.of(context).appBarTheme.color,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  elevation: 2,
                  child: Text(
                    S.of(context).account_prith_date,
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: _dateTime.date,
                      firstDate: DateTime.parse("1500-01-01"),
                      lastDate: DateTime.now(),
                      fieldLabelText: S.of(context).account_prith,
                    ).then((value) => setState(() {
                          _dateTime.setDate = value;
                        }));
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButton<int>(
                  value: dropdownValue,
                  iconSize: 35,
                  isExpanded: true,
                  // elevation: 10,
                  underline: Container(
                    height: 2,
                    color: Colors.grey[400],
                  ),
                  onChanged: (int newValue) {
                    if (newValue != 0)
                      setState(() {
                        dropdownValue = newValue;
                      });
                  },
                  items: <int>[0, 1, 2].map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value == 0
                          ? S.of(context).account_gender
                          : ((value == 1)
                              ? S.of(context).account_gender_male
                              : S.of(context).account_gender_female)),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButton<int>(
                  value: dropdownIsDead,
                  iconSize: 35,
                  isExpanded: true,
                  // elevation: 10,
                  underline: Container(
                    height: 2,
                    color: Colors.grey[400],
                  ),
                  onChanged: (int newValue) {
                    if (newValue != 0)
                      setState(() {
                        dropdownIsDead = newValue;
                      });
                  },

                  items: <int>[0, 1, 2].map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value == 0
                          ? 'الحالة'
                          : ((value == 1)
                              ? "على قيد الحياة"
                              : "متوفي رحمة الله عليه")),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 10,
                ),
                if (dropdownIsDead == 2)
                  TextField(
                    enabled: false,
                    controller: TextEditingController.fromValue(
                        TextEditingValue(
                            text: _dateTimeDead.getDate.toString())),
                    decoration: InputDecoration(
                      labelText: S.of(context).account_prith_date,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          // width: 4,
                          color: Theme.of(context).appBarTheme.color,
                        ),
                      ),
                    ),
                  ),
                if (dropdownIsDead == 2)
                  SizedBox(
                    height: 10,
                  ),
                if (dropdownIsDead == 2)
                  RaisedButton(
                    elevation: 2,
                    child: Text(
                      S.of(context).account_prith_date,
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: _dateTimeDead.date,
                        firstDate: DateTime.parse("1500-01-01"),
                        lastDate: DateTime.now(),
                        fieldLabelText: S.of(context).account_prith,
                      ).then(
                        (value) {
                          setState(() {
                            _dateTimeDead.setDate = value;
                          });
                        },
                      );
                    },
                  ),
                if (dropdownIsDead == 2)
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
