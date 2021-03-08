import 'package:flutter/material.dart';
import 'package:hafeez/model/account/one/model/profile/model/image/model/image.dart';

class AccountScreenImageCard extends StatelessWidget {
  const AccountScreenImageCard({
    Key key,
    @required this.imageProfile,
    @required this.extraTag,
  }) : super(key: key);

  final ImageProfile imageProfile;
  final String extraTag;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 10 / 10,
      child: Container(
        width: double.infinity,
        child: imageProfile.widgets.hero(context,
            extraTag: extraTag,
            width: double.infinity,
            height: double.infinity),
      ),
    );
  }
}

class EdittingImageProfile extends StatelessWidget {
  const EdittingImageProfile({
    Key key,
    @required this.imageProfile,
    @required this.extraTag,
  }) : super(key: key);

  final ImageProfile imageProfile;
  final String extraTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        child: imageProfile.widgets.hero(context,
            extraTag: extraTag,
            width: double.infinity,
            height: double.infinity),
      ),
    );
  }
}
