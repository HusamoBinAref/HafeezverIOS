import 'package:flutter/material.dart'
    show
        BuildContext,
        CircularProgressIndicator,
        Column,
        CrossAxisAlignment,
        Icon,
        IconButton,
        IconData,
        Key,
        MainAxisAlignment,
        Row,
        StatelessWidget,
        Text,
        TextStyle,
        Theme,
        Widget,
        required;

class ProgresserAndButtonsAudio extends StatelessWidget {
  const ProgresserAndButtonsAudio({
    Key key,
    @required this.position,
    @required this.musicLength,
    @required this.isDownloading,
    @required this.playBtn,
    this.playOrStop,
    this.slider,
  }) : super(key: key);

  final Duration position;
  final Duration musicLength;
  final bool isDownloading;
  final IconData playBtn;
  final Function playOrStop;
  final Function slider;

  @override
  Widget build(BuildContext context) {
    return Column(
      
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //Let's start by adding the controller
        //let's add the time indicator text

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${position.inMinutes}:${position.inSeconds.remainder(60)}",
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            slider(),
            Text(
              "${musicLength.inMinutes}:${musicLength.inSeconds.remainder(60)}",
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            IconButton(
              // iconSize: 62.0,
              color: Theme.of(context).primaryColorLight,
              onPressed: () async {
                if (!isDownloading) await playOrStop();
              },
              icon: Icon(
                playBtn,
              ),
            ),
            if (isDownloading) CircularProgressIndicator(),
          ],
        ),
      ],
    );
  }
}
