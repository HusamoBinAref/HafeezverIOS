import 'package:flutter/material.dart'
    show
        AppBar,
        BorderRadius,
        BoxFit,
        BuildContext,
        Center,
        CircularProgressIndicator,
        Colors,
        Column,
        Container,
        CrossAxisAlignment,
        EdgeInsets,
        Expanded,
        Icon,
        IconButton,
        IconThemeData,
        Icons,
        Key,
        MaterialPageRoute,
        Navigator,
        Padding,
        Radius,
        Row,
        SafeArea,
        Scaffold,
        SingleChildScrollView,
        State,
        StatefulWidget,
        Theme,
        Widget,
        required;
import 'package:hafeez/classes/tools/placeholder.dart';
import 'package:hafeez/model/public/cards/rounded_card.dart';
import 'package:hafeez/model/Item/one/model/book/set/widget/list_view.dart';
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

class PostDetailsScreen extends StatefulWidget {
  PostDetailsScreen({
    Key key,
    @required this.iTem,
    this.itemTitle,
    this.itemDescription,
    this.nameProfile,
    this.imageProfile,
    this.account,
    this.extraTag = '',
    this.itemImage,
  }) : super(key: key);

  final ITem iTem;
  final ItemTitle itemTitle;
  final ItemDescription itemDescription;
  final ItemImage itemImage;
  final Account account;
  final NameProfile nameProfile;
  final ImageProfile imageProfile;
  final String extraTag;

  @override
  _PostDetailsScreenState createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
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

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     IconButton(
                  //       tooltip: S.of(context).description,
                  //       icon: Icon(
                  //         Icons.receipt_long,
                  //         color: Theme.of(context).primaryColor,
                  //       ),
                  //       onPressed: () {
                  //         if (page != 0)
                  //           setState(() {
                  //             page = 0;
                  //           });
                  //       },
                  //     ),
                  //     IconButton(
                  //       tooltip: S.of(context).departments +
                  //           " , " +
                  //           S.of(context).words,
                  //       icon: Icon(
                  //         Icons.group_work,
                  //         color: Theme.of(context).primaryColor,
                  //       ),
                  //       onPressed: () {
                  //         if (page != 1)
                  //           setState(() {
                  //             page = 1;
                  //           });
                  //       },
                  //     ),
                  //     IconButton(
                  //       tooltip: S.of(context).items_like,
                  //       icon: Icon(
                  //         Icons.link,
                  //         color: Theme.of(context).primaryColor,
                  //       ),
                  //       onPressed: () {
                  //         if (page != 2)
                  //           setState(() {
                  //             page = 2;
                  //           });
                  //       },
                  //     ),
                  //   ],
                  // ),
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
      widget.itemImage.widgets.hero(
          placeHolderTag: widget.iTem.type == "Book"
              ? PlaceHolderImages.bookImage
              : PlaceHolderImages.postImage,
          width: double.infinity,
          fit: BoxFit.cover),
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
      if (widget.iTem.type == "Book")
        Container(
          height: 90,
          child: widget.iTem.books.widget((context, books) =>
              books.list.isNotEmpty
                  ? ItemBooksListView(books: books)
                  : Container()),
        ),
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
}
