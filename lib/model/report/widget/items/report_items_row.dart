import 'package:flutter/material.dart'
    show
        AspectRatio,
        BuildContext,
        Card,
        Axis,
        Column,
        Key,
        Row,
        SingleChildScrollView,
        StatelessWidget,
        Widget,
        required;
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/Item/set/model/data.dart';
import 'package:hafeez/model/report/api/get_date_time_units.dart';
import 'package:hafeez/model/report/model/data.dart';
import 'package:hafeez/model/report/widget/items/report_items_screen.dart';
import 'package:hafeez/model/report/widget/report_chart.dart';
import 'package:provider/provider.dart';

import '../report_card.dart';

class ReportItemsRow extends StatelessWidget {
  const ReportItemsRow({
    Key key,
    @required this.items,
    this.cardWidth = 150,
  }) : super(key: key);
  final Items items;
  final double cardWidth;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<ReportInfo>(builder: (context, reportInfo, _) {
        return Column(
          children: [
            if (reportInfo.dateUnitIndex == 0)
              buildChartByDays(reportInfo)
            else if (reportInfo.dateUnitIndex == 1)
              buildChartByMonths(reportInfo)
            else if (reportInfo.dateUnitIndex == 2)
              buildChartByDays(reportInfo),
            buildRowItems(reportInfo, context),
          ],
        );
      }),
    );
  }

  Card buildChartByMonths(ReportInfo reportInfo) {
    return Card(
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: ReportChart(
          title: S.current.monthly_report_of + S.current.elments,
          lines: [
            DateTimeUnits.getItemsLineByMonths(
              itemsList: items.list,
              color: reportInfo.allItems.color,
              type: reportInfo.allItems.title +
                  " ( " +
                  items.list.length.toString() +
                  " ) ",
              start: reportInfo.start,
              end: reportInfo.end,
            ),
            DateTimeUnits.getItemsLineByMonths(
              itemsList: items.getByType("Post").list,
              color: reportInfo.posts.color,
              type: reportInfo.posts.title +
                  " ( " +
                  items.getByType("Post").list.length.toString() +
                  " ) ",
              start: reportInfo.start,
              end: reportInfo.end,
            ),
            DateTimeUnits.getItemsLineByMonths(
              itemsList: items.getByType("Book").list,
              color: reportInfo.books.color,
              type: reportInfo.books.title +
                  " ( " +
                  items.getByType("Book").list.length.toString() +
                  " ) ",
              start: reportInfo.start,
              end: reportInfo.end,
            ),
            DateTimeUnits.getItemsLineByMonths(
              itemsList: items.getByType("Video").list,
              color: reportInfo.videos.color,
              type: reportInfo.videos.title +
                  " ( " +
                  items.getByType("Video").list.length.toString() +
                  " ) ",
              start: reportInfo.start,
              end: reportInfo.end,
            ),
            DateTimeUnits.getItemsLineByMonths(
              itemsList: items.getByType("Voice").list,
              color: reportInfo.voices.color,
              type: reportInfo.voices.title +
                  " ( " +
                  items.getByType("Voice").list.length.toString() +
                  " ) ",
              start: reportInfo.start,
              end: reportInfo.end,
            ),
          ],
        ),
      ),
    );
  }

  Card buildChartByDays(ReportInfo reportInfo) {
    return Card(
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: ReportChart(
          title: S.current.dayly_report_of + S.current.elments,
          lines: [
            DateTimeUnits.getItemsLineByDays(
              itemsList: items.list,
              color: reportInfo.allItems.color,
              type: reportInfo.allItems.title +
                  " ( " +
                  items.list.length.toString() +
                  " ) ",
              start: reportInfo.start,
              end: reportInfo.end,
            ),
            DateTimeUnits.getItemsLineByDays(
              itemsList: items.getByType("Post").list,
              color: reportInfo.posts.color,
              type: reportInfo.posts.title +
                  " ( " +
                  items.getByType("Post").list.length.toString() +
                  " ) ",
              start: reportInfo.start,
              end: reportInfo.end,
            ),
            DateTimeUnits.getItemsLineByDays(
              itemsList: items.getByType("Book").list,
              color: reportInfo.books.color,
              type: reportInfo.books.title +
                  " ( " +
                  items.getByType("Book").list.length.toString() +
                  " ) ",
              start: reportInfo.start,
              end: reportInfo.end,
            ),
            DateTimeUnits.getItemsLineByDays(
              itemsList: items.getByType("Video").list,
              color: reportInfo.videos.color,
              type: reportInfo.videos.title +
                  " ( " +
                  items.getByType("Video").list.length.toString() +
                  " ) ",
              start: reportInfo.start,
              end: reportInfo.end,
            ),
            DateTimeUnits.getItemsLineByDays(
              itemsList: items.getByType("Voice").list,
              color: reportInfo.voices.color,
              type: reportInfo.voices.title +
                  " ( " +
                  items.getByType("Voice").list.length.toString() +
                  " ) ",
              start: reportInfo.start,
              end: reportInfo.end,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRowItems(ReportInfo reportInfo, BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          CardReport(
            width: cardWidth,
            title: reportInfo.allItems.title,
            color: reportInfo.allItems.color,
            value: items.list.length.toString(),
            onTap: () {
              // ReportItemsScreen.navigator(
              //   context,
              //   reportInfo: reportInfo,
              //   items: items,
              //   title: reportInfo.allItems.title,
              // );
            },
          ),
          CardReport(
            width: cardWidth,
            title: reportInfo.posts.title,
            color: reportInfo.posts.color,
            value: items.getByType("Post").list.length.toString(),
            onTap: () {
              // ReportItemsScreen.navigator(
              //   context,
              //   reportInfo: reportInfo,
              //   items: items.getByType("Post"),
              //   title: reportInfo.posts.title,
              // );
            },
          ),
          CardReport(
            width: cardWidth,
            title: reportInfo.books.title,
            color: reportInfo.books.color,
            value: items.getByType("Book").list.length.toString(),
            onTap: () {
              ReportItemsScreen.navigator(
                context,
                reportInfo: reportInfo,
                items: items.getByType("Book"),
                title: reportInfo.books.title,
              );
            },
          ),
          CardReport(
            width: cardWidth,
            title: reportInfo.videos.title,
            color: reportInfo.videos.color,
            value: items.getByType("Video").list.length.toString(),
            onTap: () {
              // ReportItemsScreen.navigator(
              //   context,
              //   reportInfo: reportInfo,
              //   items: items.getByType("Video"),
              //   title: reportInfo.videos.title,
              // );
            },
          ),
          CardReport(
            width: cardWidth,
            title: reportInfo.voices.title,
            color: reportInfo.voices.color,
            value: items.getByType("Voice").list.length.toString(),
            onTap: () {
              // ReportItemsScreen.navigator(
              //   context,
              //   reportInfo: reportInfo,
              //   items: items.getByType("Voice"),
              //   title: reportInfo.voices.title,
              // );
            },
          ),
        ],
      ),
    );
  }
}
