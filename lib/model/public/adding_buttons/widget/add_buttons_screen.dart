import 'package:flutter/material.dart'
    show
        BorderRadius,
        BuildContext,
        Center,
        Column,
        Container,
        EdgeInsets,
        Expanded,
        FloatingActionButton,
        Icon,
        IconData,
        Icons,
        InkWell,
        Key,
        Padding,
        Row,
        SafeArea,
        Scaffold,
        SingleChildScrollView,
        StatelessWidget,
        Text,
        Theme,
        Widget,
        required,
        CrossAxisAlignment;
import '../../../../classes/tools/public_variables.dart';
import '../../../Item/set/controller/api/video.dart';

import '../../cards/rounded_card.dart';
import '../../../../classes/routing/api/screens.dart';
import '../../../../generated/l10n.dart';
import '../../../Item/set/controller/widget/root.dart';

class AddButtonsScreen extends StatelessWidget {
  const AddButtonsScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.home),
          onPressed: () {
            ScreenRouting.toHomeScreen(context);
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CreateButton(
                  onTap: () { 
                    ItemAddWidgets.book(context);
                  },
                  iconData: Icons.menu_book,
                  label: S.of(context).add_book),
              CreateButton(
                  onTap: () {
                    ItemAddWidgets.post(context);
                  },
                  iconData: Icons.post_add,
                  label: S.of(context).add_post),
              CreateButton(
                  onTap: () {
                    VideoFunctions.addVideoLink(context);
                  },
                  iconData: Icons.video_call,
                  label: S.of(context).add_video),
              CreateButton(
                  onTap: () {
                    
                  },
                  iconData: Icons.keyboard_voice,
                  label: S.of(context).add_vioce),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateButton extends StatelessWidget {
  const CreateButton({
    Key key,
    @required this.onTap,
    @required this.iconData,
    @required this.label,
  }) : super(key: key);

  final Function onTap;
  final IconData iconData;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            onTap();
          },
          child: RoundedCard(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              height: MediaCheckFunctions.height(context) * 0.2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(iconData,
                        color: Theme.of(context).primaryColorLight, size: 100),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        label,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
