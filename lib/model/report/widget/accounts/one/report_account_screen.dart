import 'package:flutter/material.dart';
import 'package:hafeez/classes/routing/api/screens.dart';
import 'package:hafeez/model/Item/set/api/get.dart';
import 'package:hafeez/model/account/one/model/data.dart';
import 'package:hafeez/model/account/one/model/profile/model/image/model/image.dart';
import 'package:hafeez/model/account/one/model/profile/model/name/one/model/name.dart';
import 'package:hafeez/model/account/one/widget/components/tile.dart';
import 'package:hafeez/model/public/cards/rounded_card.dart';
import 'package:hafeez/model/report/model/data.dart';
import 'package:hafeez/model/report/widget/items/report_items_page.dart';
import 'package:hafeez/model/specialization/one/api/specialization.dart';
import 'package:provider/provider.dart';

import '../../report_date_unit_type_pop_up.dart';
import '../../time_picker.dart';

class ReportAccontScreen extends StatelessWidget {
  static navigator(BuildContext context, Account account,
      {ImageProfile imageProfile,
      NameProfile nameProfile,
      ReportInfo reportInfo}) {
    ScreenRouting.navigator(
      context,
      child: ChangeNotifierProvider<ReportInfo>(
          create: (context) => reportInfo != null
              ? ReportInfo(startDate: reportInfo.start, endDate: reportInfo.end)
              : ReportInfo(),
          builder: (context, snapshot) {
            return ReportAccontScreen(
                account: account,
                nameProfile: nameProfile,
                imageProfile: imageProfile);
          }),
    );
  }

  const ReportAccontScreen({
    Key key,
    @required this.account,
    this.nameProfile,
    this.imageProfile,
  }) : super(key: key);

  final Account account;
  final NameProfile nameProfile;
  final ImageProfile imageProfile;

  @override
  Widget build(BuildContext context) {
    return Consumer<ReportInfo>(builder: (context, reportInfo, _) {
      return Scaffold(
        appBar: AppBar(
          actions: [
            ReportDateUnitTypePopUp(
              reportInfo: reportInfo,
            ),
            IconButton(
                icon: Icon(Icons.calendar_today_rounded),
                onPressed: () {
                  ScreenRouting.myShowDialog(context,
                      child: ReportDatePicker(report: reportInfo));
                }),
          ],
        ),
        body: SafeArea(
          child: Container(
              child: SingleChildScrollView(
            child: Column(
              children: [
                RoundedCard(
                  borderRadius: BorderRadius.circular(10),
                  margin: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AccountTileReady(
                        account: account,
                        name: nameProfile,
                        image: imageProfile,
                        date: Text(account.createString),
                      ),
                      Row(
                          children: getSpecializations()
                              .map((spec) => RoundedCard(
                                    margin: const EdgeInsets.all(5),
                                    elevation: 0,
                                    borderRadius: BorderRadius.circular(30),
                                    color: Theme.of(context).primaryColorLight,
                                    child: spec.widget((context,
                                            specialization) =>
                                        specialization.title.widget(
                                            builder: (context, specTitle) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              specTitle.text,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          );
                                        })),
                                  ))
                              .toList()),
                    ],
                  ),
                ),
                ReportItemsPage(
                  getItems: GetItems.buildForAccount(account.reference),
                ),
              ],
            ),
          )),
        ),
      );
    });
  }

  List<GetSpecialization> getSpecializations() {
    return account.referencesAll.specializationsReferences
        .map((specailizationRef) =>
            GetSpecialization(reference: specailizationRef))
        .toList();
  }
}
