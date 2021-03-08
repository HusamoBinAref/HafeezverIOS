import 'package:flutter/material.dart';
import 'package:hafeez/classes/commends/key_words.dart';
import 'package:hafeez/classes/routing/api/screens.dart';
import 'package:hafeez/model/Item/set/controller/model/Voice.dart';
import 'package:hafeez/model/Item/set/controller/model/video.dart';
import 'package:hafeez/widget/containers.dart';
import 'components/departments.dart';
import 'components/descriptions.dart';
import 'components/words.dart';
import '../model/data.dart';
import 'components/titles.dart';
import '../add/widgets/../../widget/screen.dart';

class ItemAddWidgets extends StatefulWidget {
  ItemAddWidgets({Key key, @required this.model}) : super(key: key);
  final ItemModel model;
  static bool isReady(AsyncSnapshot snapshot) {
    return snapshot.connectionState == ConnectionState.done && snapshot.hasData;
  }

  static void book(BuildContext context, {String bookUrl}) {
    ScreenRouting.toNewItemScreen(context, KeyWords.itemKeyWords[0],
        bookUrl: bookUrl);
  }

  static void post(BuildContext context) {
    ScreenRouting.toNewItemScreen(context, KeyWords.itemKeyWords[1]);
  }

  static void video(BuildContext context, {VideoModel model}) {
    ScreenRouting.toNewItemScreen(
      context,
      KeyWords.itemKeyWords[2],
      videoModel: model,
    );
  }

  static void voice(BuildContext context, {VoiceModel model}) {
    ScreenRouting.toNewItemScreen(context, KeyWords.itemKeyWords[3]);
  }

  @override
  _ItemAddWidgetsState createState() => _ItemAddWidgetsState();
}

class _ItemAddWidgetsState extends State<ItemAddWidgets> {
  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: ToggleButtons(
          borderWidth: 2,
          borderRadius: BorderRadius.circular(5),
          children:
              widget.model.pages.map((e) => e['widget'] as Widget).toList(),
          fillColor: Theme.of(context).primaryColorLight,
          selectedColor: Theme.of(context).primaryColor,
          isSelected:
              widget.model.pages.map((e) => e['status'] as bool).toList(),
          onPressed: (index) {
            setState(() {
              widget.model.move(index);
            });
          },
        ),
      ),
      body: widget.model.isLoading
          ? Container(
              child:
                  Center(child: Containers.waitting(context)),
            )
          : Scaffold(
              body: [
                TitleWidget(
                  model: widget.model,
                ),
                DescriptionWidget(
                  model: widget.model,
                ),
                DepartmentsWidget(
                  model: widget.model,
                ),
                WordsWidget(
                  model: widget.model,
                ),
                FinalItemWidget(
                  model: widget.model,
                  loading: () {
                    setState(() {
                      widget.model.isLoading = !widget.model.isLoading;
                    });

                    widget.model.create(context).then((result) {
                      if (result != "done")
                        setState(() {
                          widget.model.isLoading = !widget.model.isLoading;
                        });
                      else
                        ScreenRouting.toHomeScreen(context);
                    });
                  },
                ),
              ][widget.model.pageNo],
            ),
    ));
  }
}
