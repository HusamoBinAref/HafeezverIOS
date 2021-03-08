import 'package:flutter/material.dart'
    show
        BorderRadius,
        BuildContext,
        Column,
        Container,
        CrossAxisAlignment,
        EdgeInsets,
        Key,
        Padding,
        Row,
        Scaffold,
        SingleChildScrollView,
        Stack,
        StatelessWidget,
        Text,
        TextStyle,
        Theme,
        Widget,
        required;
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/account/one/model/data.dart';
import 'package:hafeez/model/account/one/model/profile/model/image/model/image.dart';
import 'package:hafeez/model/account/one/model/profile/model/name/one/model/name.dart';
import 'package:hafeez/model/public/cards/rounded_card.dart';
import 'package:hafeez/model/specialization/one/api/specialization.dart';

import 'components/buttons.dart';
import 'components/image_card.dart';

class AccountProfileDataEditable2 extends StatelessWidget {
  const AccountProfileDataEditable2({
    Key key,
    @required this.account,
    @required this.nameProfile,
    @required this.imageProfile,
    this.extraTag = '',
  }) : super(key: key);
  final Account account;
  final NameProfile nameProfile;
  final ImageProfile imageProfile;
  final String extraTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RoundedCard(
                  borderRadius: BorderRadius.circular(15),
                  margin: const EdgeInsets.all(5),
                  elevation: 1,
                  child: Column(
                    children: [
                      AccountScreenImageCard(
                          imageProfile: imageProfile, extraTag: extraTag),
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
                RoundedCard(
                  borderRadius: BorderRadius.circular(10),
                  margin: const EdgeInsets.all(5),
                  elevation: 1,
                  // color: Theme.of(context).primaryColorLight,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Row(
                      children: [
                        Text(
                          S.of(context).account_name + "  :  ",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        nameProfile.widgets.hero(context),
                      ],
                    ),
                  ),
                ),
                RoundedCard(
                  borderRadius: BorderRadius.circular(10),
                  margin: const EdgeInsets.all(5),
                  child: account.profile.descriptions.currentDescription(
                    (context, description) => description.widgets.textWidget(
                      context,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ButtonWithBorderRadiusColumn(
            account: account,
            imageProfile: imageProfile,
            nameProfile: nameProfile,
          ),
        ],
      ),
    );
  }

  List<GetSpecialization> getSpecializations() {
    return account.referencesAll.specializationsReferences
        .map((specailizationRef) =>
            GetSpecialization(reference: specailizationRef))
        .toList();
  }

  Widget buildNameCard(BuildContext context) {
    return RoundedCard(
      borderRadius: BorderRadius.circular(10),
      margin: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Theme.of(context).primaryColorLight,
            padding: const EdgeInsets.all(5),
            child: Text(
              S.of(context).account_name,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            child: account.profile.names.currentName((context, name) =>
                name.widgets.hero(context,
                    extraTag: extraTag,
                    extraText: account.isSheikh
                        ? S.of(context).account_type_sheikh
                        : "",
                    fontSize: 20)),
          ),
        ],
      ),
    );
  }
}
