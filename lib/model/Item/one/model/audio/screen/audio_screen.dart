import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart'
    show DefaultCacheManager;
import 'package:hafeez/model/Item/one/model/audio/model/data.dart';
import 'package:hafeez/model/Item/one/model/audio/screen/prograss_buttons_voice.dart';
import 'package:hafeez/model/public/cards/rounded_card.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/Item/one/model/description/one/model/description.dart';
import 'package:hafeez/model/Item/one/model/image/one/model/image.dart';
import 'package:hafeez/model/Item/one/model/title/one/model/data.dart';
import 'package:hafeez/model/Item/one/model/image/one/widget/edit/image.dart';

import 'package:hafeez/model/account/one/model/data.dart';
import 'package:hafeez/model/account/one/model/profile/model/image/model/image.dart';
import 'package:hafeez/model/account/one/model/profile/model/name/one/model/name.dart';
import 'package:hafeez/model/account/one/widget/components/tile.dart';
import 'package:hafeez/model/authentication/api/authentication.dart';

import '../../../model/data.dart';

class AudioScreen extends StatefulWidget {
  AudioScreen({
    Key key,
    @required this.iTem,
    this.itemTitle,
    this.itemDescription,
    this.nameProfile,
    this.imageProfile,
    this.account,
    this.extraTag = '',
    this.itemImage,
    this.itemAudio,
  }) : super(key: key);

  final ITem iTem;
  final ItemTitle itemTitle;
  final ItemDescription itemDescription;
  final ItemImage itemImage;
  final Account account;
  final NameProfile nameProfile;
  final ImageProfile imageProfile;
  final ItemAudio itemAudio;
  final String extraTag;

  @override
  _AudioScreenState createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  //we will need some variables
  bool playing = false; // at the begining we are not playing any song
  IconData playBtn = Icons.play_arrow; // the main state of the play button icon

  //Now let's start by creating our music player
  //first let's declare some object
  AudioPlayer _player;
  AudioCache cache;
  File _file;
  Duration position = new Duration();
  Duration musicLength = new Duration();
//we will create a custom slider

  bool isDownloading = false;
  Uint8List bytes;

  //we will create a custom slider
  bool isUpdating = false;
  int page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        elevation: 0,
        actions: actions(context),
      ),
      body: SafeArea(
        child: isUpdating
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: RoundedCard(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: Container(
                        color: Theme.of(context).primaryColor,
                        child: children(context),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        tooltip: S.of(context).description,
                        icon: Icon(
                          Icons.receipt_long,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          if (page != 0)
                            setState(() {
                              page = 0;
                            });
                        },
                      ),
                      IconButton(
                        tooltip: S.of(context).departments +
                            " , " +
                            S.of(context).words,
                        icon: Icon(
                          Icons.group_work,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          if (page != 1)
                            setState(() {
                              page = 1;
                            });
                        },
                      ),
                      IconButton(
                        tooltip: S.of(context).items_like,
                        icon: Icon(
                          Icons.link,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          if (page != 2)
                            setState(() {
                              page = 2;
                            });
                        },
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  Widget children(BuildContext context) {
    if (page == 0)
      return SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: childrenInfo(context),
      ));
    else
      return Container();
  }

  List<Widget> childrenInfo(BuildContext context) {
    return [
      widget.itemImage.widgets.hero(width: double.infinity, fit: BoxFit.cover),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: RoundedCard(
          elevation: 0,
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
          child: Row(
            children: [
              Expanded(
                child: AccountTileReady(
                  account: widget.account,
                  name: widget.nameProfile,
                  image: widget.imageProfile,
                  date: widget.iTem.widgets.createDateHero(context),
                  extraTag: widget.extraTag,
                ),
              ),
              widget.iTem.widgets.buttons(context),
            ],
          ),
        ),
      ),
      title.widgets.hero2(
        context,
      ),
      ProgresserAndButtonsAudio(
          playOrStop: playOrStop,
          slider: slider,
          position: position,
          musicLength: musicLength,
          isDownloading: isDownloading,
          playBtn: playBtn),
      if (description.text.trim() != "") description.widgets.hero2(context),
    ];
  }

  ItemTitle get title => widget.itemTitle;
  ItemDescription get description => widget.itemDescription;

  List<Widget> actions(BuildContext context) => [
        GetAuthentication().showIfEdittingIsAllow(
          child: IconButton(
              icon: Icon(
                Icons.mode_edit,
              ),
              onPressed: () {
                widget.iTem.widgets.showEdittingScreen(context, () {
                  widget.iTem.widgets.godetials(context);
                });
              }),
          reference: widget.iTem.user.reference,
        ),
        GetAuthentication().showIfEdittingIsAllow(
          child: IconButton(
              icon: Icon(
                Icons.add_photo_alternate_outlined,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ModifyImageWidget(
                    itemImage: widget.itemImage,
                  );
                }));
              }),
          reference: widget.iTem.user.reference,
        ),
        GetAuthentication().showIfEdittingIsAllow(
          child: widget.iTem.type == "Book"
              ? IconButton(
                  icon: Icon(
                    Icons.book_online,
                  ),
                  onPressed: () async {
                    setState(() {
                      isUpdating = true;
                    });
                    await widget.iTem.reference
                        .collection("Book")
                        .doc(widget.itemDescription.reference.id)
                        .set({"url": widget.itemDescription.text});
                    setState(() {
                      isUpdating = false;
                    });
                  })
              : Container(),
          reference: widget.iTem.user.reference,
        ),
      ];

// audio player
  Widget slider() {
    return Slider.adaptive(
        activeColor: Theme.of(context).primaryColorDark,
        inactiveColor: Theme.of(context).primaryColorLight.withOpacity(0.3),
        value: position.inSeconds.toDouble(),
        max: musicLength.inSeconds.toDouble(),
        onChanged: (value) {
          seekToSec(value.toInt());
        });
  }

  //let's create the seek function that will allow us to go to a certain position of the music
  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
  }

  Future getFile() async {
    var gfile = await DefaultCacheManager().getSingleFile(widget.itemAudio.url);
    setState(() {
      _file = gfile;
    });
  }

  //Now let's initialize our player
  @override
  void initState() {
    _player = AudioPlayer();

    cache = AudioCache(
      fixedPlayer: _player,
    );
    super.initState();

    //now let's handle the audioplayer time
    //this function will allow you to get the music duration

    // ignore: deprecated_member_use
    _player.durationHandler = (d) {
      setState(() {
        musicLength = d;
      });
    };

    //this function will allow us to move the cursor of the slider while we are playing the song

    // ignore: deprecated_member_use
    _player.positionHandler = (p) {
      setState(() {
        position = p;
      });
    };
  }

  downloading() async {
    if (_file == null) {
      setState(() {
        isDownloading = true;
      });
      await getFile();
      bytes = await _file.readAsBytes();
      cache.playBytes(bytes,
          mode: PlayerMode.LOW_LATENCY, stayAwake: true, isNotification: true);

      setState(() {
        isDownloading = false;
      });
    }
  }

  playOrStop() async {
    if (widget.itemAudio.url.isEmpty) return;
    await downloading();

    //here we will add the functionality of the play button
    if (!playing) {
      //now let's play the song
      _player.resume();
      setState(() {
        playBtn = Icons.pause;
        playing = true;
      });
    } else {
      _player.pause();
      setState(() {
        playBtn = Icons.play_arrow;
        playing = false;
      });
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
