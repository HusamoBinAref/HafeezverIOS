// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:hafeez/classes/placeholder.dart';
// import 'package:hafeez/model/Item/set/controller/model/Voice.dart';
// import 'package:hafeez/widget/cache_image_widgets.dart';
// import '../widget/root.dart';

// class VoiceFunctions {
//   static Future<void> addVoiceLink(
//     BuildContext context,
//   ) async {
//     VoiceModel media = await showDialog(
//         context: context,
//         child: Builder(
//           builder: (context) {
//             return Dialog(
//               child: AddVoiceWidget(),
//             );
//           },
//         ));

//     if (media != null) {
//       ItemAddWidgets.voice(context, model: media);
//     }
//   }
// }

// class AddVoiceWidget extends StatefulWidget {
//   const AddVoiceWidget({
//     Key key,
//   }) : super(key: key);

//   @override
//   _AddVoiceWidgetState createState() => _AddVoiceWidgetState();
// }

// class _AddVoiceWidgetState extends State<AddVoiceWidget> {
//   final VoiceModel model = VoiceModel();
//   final assetsAudioPlayer = AssetsAudioPlayer();

//   Widget get imageBuilder {
//     if (model.imageFile != null)
//       return Image.file(model.imageFile);
//     else if (model.imageUrl.length > 0) {
//       return CacheImageWidget(
//         imageUrl: model.imageUrl,
//         assetImageTag: PlaceHolderImages.voiceImage,
//       );
//     } else
//       return Image.asset(PlaceHolderImages.voiceImage);
//   }

//   bool _play = false;
//   Widget get voiceBuilder {
//     if (model.voiceFile != null)
//       return AudioWidget(
//         audio: Audio.file(model.voiceFile.path),
//         play: _play,
//         child: RaisedButton(
//             child: Text(
//               _play ? "pause" : "play",
//             ),
//             onPressed: () {
//               setState(() {
//                 _play = !_play;
//               });
//             }),
//         onReadyToPlay: (duration) {
//           //onReadyToPlay
//         },
//         onPositionChanged: (current, duration) {
//           //onPositionChanged
//         },
//       );
//     else
//       return AudioWidget.assets(
//         path: model.voiceUrl,
//         play: _play,
//         child: RaisedButton(
//             child: Text(
//               _play ? "pause" : "play",
//             ),
//             onPressed: () {
//               setState(() {
//                 _play = !_play;
//               });
//             }),
//         onReadyToPlay: (duration) {
//           //onReadyToPlay
//         },
//         onPositionChanged: (current, duration) {
//           //onPositionChanged
//         },
//       );
//   }

//   void selectimage() async {
//     var image = await FilePicker.getFile(type: FileType.image);

//     if (image != null && image.path.length > 0)
//       setState(() {
//         model.imageFile = image;
//       });
//   }

//   void selectsong() async {
//     var voice = await FilePicker.getFile(type: FileType.audio);
//     if (voice != null && voice.path.length > 0)
//       setState(() {
//         model.voiceFile = voice;
//       });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: Column(
//       children: <Widget>[
//         imageBuilder,
//         RaisedButton(
//           onPressed: () {
//             selectimage();
//           },
//           child: Text("Select Image"),
//         ),
//         Divider(),
//         if (model.voiceFile != null || model.voiceUrl.length > 0) voiceBuilder,
//         RaisedButton(
//           onPressed: () {
//             selectsong();
//           },
//           child: Text("Select Song"),
//         ),
//         RaisedButton(
//           onPressed: () {},
//           child: Text("Upload"),
//         ),
//       ],
//     ));
//   }
// }
