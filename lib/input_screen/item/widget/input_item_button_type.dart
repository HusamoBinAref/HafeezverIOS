import 'package:flutter/material.dart';

class InputItemButtonType extends StatelessWidget {
  const InputItemButtonType({
    Key key,
    this.onPressed,
    this.icon,
    this.text,
  }) : super(key: key);
  final Function onPressed;
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Card(
        elevation: 0,
        color: Theme.of(context).primaryColorLight.withOpacity(0.15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 100,
                color: Theme.of(context).primaryColorLight,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
