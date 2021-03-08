import 'package:flutter/material.dart' show  Icons, BuildContext;
import 'package:hafeez/generated/l10n.dart';

import 'detials_model.dart';

class DetailsCollections {
  static Detials posts(BuildContext context) =>
      Detials(iconData: Icons.wysiwyg, text: S.of(context).posts);
  static Detials post(BuildContext context) =>
      Detials(iconData: Icons.wysiwyg, text: S.of(context).post);
  static Detials books(BuildContext context) =>
      Detials(iconData: Icons.book, text: S.of(context).books);
  static Detials book(BuildContext context) =>
      Detials(iconData: Icons.book, text: S.of(context).book);
  static Detials videos(BuildContext context) =>
      Detials(iconData: Icons.videocam, text: S.of(context).videos);
  static Detials video(BuildContext context) =>
      Detials(iconData: Icons.videocam, text: S.of(context).video);
  static Detials voices(BuildContext context) =>
      Detials(iconData: Icons.keyboard_voice, text: S.of(context).voices);
  static Detials voice(BuildContext context) =>
      Detials(iconData: Icons.keyboard_voice, text: S.of(context).voice);
  static Detials shiekhs(BuildContext context) =>
      Detials(iconData: Icons.person, text: S.of(context).sheikhs);
  static Detials departments(BuildContext context) =>
      Detials(iconData: Icons.grid_on, text: S.of(context).departments);
}
