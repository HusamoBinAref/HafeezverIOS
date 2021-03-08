import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hafeez/classes/tools/public_variables.dart';
import 'package:hafeez/generated/l10n.dart';

import 'package:hafeez/model/Item/model/types/post/tile.dart';

import 'package:hafeez/model/Item/set/model/data.dart';
import 'package:hafeez/model/department/set/api/get.dart';
import 'package:hafeez/model/public/no_thing/widget/item.dart';
import 'package:provider/provider.dart';

import '../../../manament_status/ms_all.dart';

class ItemsWidgets {
  final Items items;

  ItemsWidgets({@required this.items});

  Widget list(BuildContext context, {bool isAccount = false}) {
    if (items.list.isNotEmpty)
      return ListView.builder(
        primary: true,
        addAutomaticKeepAlives: true,
        addRepaintBoundaries: false,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        cacheExtent: MediaCheckFunctions.cacheItem,
        itemCount: items.list.length + 1,
        itemBuilder: (context, index) {
          if (items.list.length == index)
            return Consumer<ManagementState>(
                builder: (context, itemsManagement, _) {
              return AspectRatio(
                aspectRatio: 20 / 35,
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.arrow_drop_down),
                    onPressed: () {
                      itemsManagement.more();
                    },
                  ),
                ),
              );
            });
          else
            return AspectRatio(
                aspectRatio: 20 / 35,
                child: items.list[index].widgets
                    .view(context, isAccount: isAccount));
        },
      );
    else
      return NoItemWidget();
  }

  Widget videoGridList(BuildContext context,
      {bool isAccount = false, bool isDepartment = false}) {
    if (items.list.isNotEmpty)
      return GridView.builder(
        padding: !isDepartment
            ? const EdgeInsets.only(
                bottom: 10,
                top: GetDepartments.maxRowHeight + 40,
                left: 10,
                right: 10,
              )
            : const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            childAspectRatio: MediaCheckFunctions.videoCardAspectRatio,
            maxCrossAxisExtent: MediaCheckFunctions.maxWidthVideoCard,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        primary: true,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        cacheExtent: MediaCheckFunctions.cacheItem,
        itemCount: items.list.length,
        itemBuilder: (context, index) {
          return items.list[index].widgets.videoCard(context);
        },
      );
    else
      return NoItemWidget();
  }

  Widget postGridList(BuildContext context,
      {bool isAccount = false, bool isDepartment = false}) {
    if (items.list.isNotEmpty)
      return GridView.builder(
        padding: !isDepartment
            ? const EdgeInsets.only(
                bottom: 10,
                top: GetDepartments.maxRowHeight + 40,
                left: 10,
                right: 10,
              )
            : const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            childAspectRatio: MediaCheckFunctions.postCardAspectRatio,
            maxCrossAxisExtent: MediaCheckFunctions.maxWidthPostCard,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        primary: true,
        shrinkWrap: true,
        cacheExtent: MediaCheckFunctions.cacheItem,
        itemCount: items.list.length,
        itemBuilder: (context, index) {
          return items.list[index].widgets.postCard();
        },
      );
    else
      return NoItemWidget();
  }

  Widget audioGridList(BuildContext context,
      {bool isAccount = false, bool isDepartment = false}) {
    if (items.list.isNotEmpty)
      return GridView.builder(
        padding: !isDepartment
            ? const EdgeInsets.only(
                bottom: 10,
                top: GetDepartments.maxRowHeight + 40,
                left: 10,
                right: 10,
              )
            : const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            childAspectRatio: MediaCheckFunctions.voiceCardAspectRatio,
            maxCrossAxisExtent: MediaCheckFunctions.maxWidthVoiceCard,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        primary: true,
        shrinkWrap: true,
        cacheExtent: MediaCheckFunctions.cacheItem,
        itemCount: items.list.length,
        itemBuilder: (context, index) {
          return items.list[index].widgets.audioCard();
        },
      );
    else
      return NoItemWidget();
  }

  //
}
