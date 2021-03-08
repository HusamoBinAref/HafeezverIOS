import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/account/one/model/data.dart';
import 'package:hafeez/model/specialization/one/model/specialization.dart';
import 'package:hafeez/model/specialization/set/api/get.dart';
import 'package:hafeez/model/specialization/set/model/data.dart';
import 'package:hafeez/model/language/set/widget/screen.dart';
import 'package:hafeez/model/public/waiting/widget/uploading.dart';

class AccountReferences {
  final List<DocumentReference> references;
  final Account account;

  AccountReferences({@required this.account, @required this.references});

  //

  List<DocumentReference> get specializationsReferences =>
      references.where((element) => element.path.contains("Specialization")).toList();

  Widget specializationsList() {
    return GetSpecializations.buildOrderByDate.widget((context, _specializations) {
      _specializations.specializations.removeWhere((special) => special.reference.path.contains("Specialization/public"));

      // select item References
      for (var _specialization in _specializations.specializations
          .where((specialization) => specializationsReferences.contains(specialization.reference))) {
        _specialization.isSelected = true;
      }
      return EdittingSpecializationsScreen(specializations: _specializations, update: updateSpecializations);
    });
  }

  updateSpecializations(BuildContext context, List<DocumentReference> referencesList) async {
    List<DocumentReference> allReferences = references
        .where(
          (element) => !(element.path.contains('Specialization')),
        )
        .toList();
    allReferences.addAll(referencesList);

    await account.snapshot.reference.set(
      {"references": allReferences},
      SetOptions(merge: true),
    ).then((value) {
      // account.upDateReferences = allReferences;
      Navigator.pop(context);
    });
  }
}

class EdittingSpecializationsScreen extends StatefulWidget {
  EdittingSpecializationsScreen({
    Key key,
    this.specializations,
    this.update,
  }) : super(key: key);
  final Specializations specializations;
  final Function(BuildContext context, List<DocumentReference> references) update;

  @override
  _EdittingSpecializationsScreenState createState() => _EdittingSpecializationsScreenState();
}

class _EdittingSpecializationsScreenState extends State<EdittingSpecializationsScreen> {
  GlobalKey<FormState> form = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();

  List<Specialization> selectedWord() {
    return widget.specializations.specializations.where((word) => word.isSelected).toList();
  }

  List<Specialization> unSelectedWord() {
    return widget.specializations.specializations.where((word) => !word.isSelected).toList();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? WaittingUpload.spinKitCircle(context)
        : Scaffold(
            drawer: Drawer(child: LanguageScreen()),
            appBar: AppBar(
              centerTitle: true,
              title: Text(S.of(context).spacializations),
              actions: [
                // save all
                IconButton(
                    icon: Icon(Icons.save),
                    onPressed: () async {
                      if (form.currentState.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        await widget.update(context, selectedWord().map((word) => word.reference).toList());
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }),
                // selecting all
                IconButton(
                    icon: Icon(
                      Icons.select_all,
                      color: Theme.of(context).primaryColorLight,
                    ),
                    onPressed: () {
                      setState(() {
                        unSelectedWord().forEach((element) {
                          element.isSelected = true;
                        });
                      });
                    }),

                // unselecting all
                IconButton(
                  icon: Icon(
                    Icons.select_all,
                    color: Theme.of(context).primaryColorLight.withOpacity(0.7),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedWord().forEach((element) {
                        element.isSelected = false;
                      });
                    });
                  },
                ),
                IconButton(
                    icon: Icon(Icons.arrow_back_rounded),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ],
            ),
            body: SafeArea(
              child: Form(
                key: form,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        validator: (value) {
                          return selectedWord().isNotEmpty ? null : S.of(context).select_one_department_or_more;
                        },
                        autofocus: true,
                        decoration: InputDecoration(
                          labelStyle: Theme.of(context).textTheme.subtitle1,
                          labelText: S.of(context).search,
                          suffixIcon: Icon(Icons.search, color: Theme.of(context).primaryColorLight),
                        ),
                        controller: controller,
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        cacheExtent: 100,
                        itemCount: widget.specializations.specializations.length,
                        itemBuilder: (context, index) {
                          var word = widget.specializations.specializations[index];
                          var isSelected = word.isSelected;
                          return word.title.widget(builder: (context, title) {
                            var searchDepartmentText = controller.value.text;
                            if (searchDepartmentText.isEmpty || title.text.contains(searchDepartmentText))
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: ListTile(
                                      selectedTileColor: Theme.of(context).primaryColorLight,
                                      title: Text(
                                        title.text,
                                        style: isSelected
                                            ? Theme.of(context)
                                                .textTheme
                                                .subtitle1
                                                .copyWith(color: Theme.of(context).primaryColor)
                                            : Theme.of(context).textTheme.subtitle1,
                                      ),
                                      selected: word.isSelected,
                                      onTap: () {
                                        setState(() {
                                          word.isSelected = !word.isSelected;
                                        });
                                      }),
                                ),
                              );
                            else
                              return Container();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
