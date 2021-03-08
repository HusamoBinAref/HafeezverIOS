import 'package:flutter/material.dart';
import 'package:hafeez/model/account/one/model/profile/api/get.dart';
import 'package:hafeez/model/account/one/model/profile/model/description/one/model/data.dart';
import 'package:hafeez/model/account/one/model/profile/model/image/model/image.dart';
import 'package:hafeez/model/account/one/model/profile/model/name/one/model/name.dart';

class AccountProfileWidgets {
  final GetProfile profile;

  AccountProfileWidgets({@required this.profile});

  Widget nameAndImageBuilder(
      Function(BuildContext context, NameProfile name, ImageProfile image) builder) {
    return profile.image.widget((context, image) =>
        profile.names.currentName((context, name) => builder(context, name, image)));
  } 

  Widget nameAndImageAndDescriptionBuilder(
      Function(BuildContext context, NameProfile name, ImageProfile image,
              DescriptionProfile description)
          builder) {
    return nameAndImageBuilder((context, name, image) => profile.descriptions
        .currentDescription((context, description) => builder(context, name, image, description)));
  }
}
