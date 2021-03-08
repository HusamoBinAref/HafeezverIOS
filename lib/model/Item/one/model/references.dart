import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/department/set/api/get.dart';
import 'package:hafeez/model/department/one/model/data.dart';
import 'package:hafeez/model/word/Model/word.dart';
import 'package:hafeez/model/word/set/model/data.dart';
import 'package:hafeez/model/word/words.dart';
import 'package:hafeez/model/language/set/widget/screen.dart';
import 'package:hafeez/model/public/waiting/widget/uploading.dart';

import 'data.dart';

class ItemReferences {
  final List<DocumentReference> references;
  final ITem iTem;

  ItemReferences({@required this.iTem, @required this.references});

  //

  List<DocumentReference> get wordsReferences => references.where((element) => element.path.contains("Word")).toList();

  Widget wordsList() {
    return GetWords.buildOrderByDate.widget((context, _words) {
      _words.words.removeWhere((depart) => depart.reference.path.contains("Word/public"));

      // select item References
      for (var _word in _words.words.where((word) => wordsReferences.contains(word.reference))) {
        _word.isSelected = true;
      }
      return EdittingWordsScreen(words: _words, update: updateWords);
    });
  }

  showEdittingWordsScreen(BuildContext context) async {
    var words = await GetWords.buildOrderByDate.futureFun(wordsReferences);
    words.words.removeWhere((depart) => depart.reference.path.contains("Word/public"));
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return EdittingWordsScreen(words: words, update: updateWords);
      },
    ));
  }

  updateWords(BuildContext context, List<DocumentReference> referencesList) async {
    List<DocumentReference> allReferences = references
        .where(
          (element) => !(element.path.contains('Word')),
        )
        .toList();
    allReferences.addAll(referencesList);

    await iTem.reference.set(
      {"references": allReferences},
      SetOptions(merge: true),
    ).then((value) {
      iTem.upDateReferences = allReferences;
      Navigator.pop(context);
    });
  }

//
  List<DocumentReference> get departmentsReferences {
    return references.where((element) => element.path.contains('Department')).toList();
  }

  showEdittingDepartmentsScreen(BuildContext context) async {
    var departments = await GetDepartments.buildOrderByDate.futureFun(departmentsReferences);
    departments.removeWhere((element) => element.reference.path.contains("Department/public"));

    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return EdittingDepartmentsScreen(
          departments: departments,
          update: updateDepartments,
        );
      },
    ));
  }

  updateDepartments(BuildContext context, List<DocumentReference> referencesList) async {
    List<DocumentReference> allReferences = references
        .where(
          (element) => !(element.path.contains('Department')),
        )
        .toList();
    allReferences.addAll(referencesList);

    await iTem.reference.set(
      {"references": allReferences},
      SetOptions(merge: true),
    ).then((value) {});

    iTem.upDateReferences = allReferences;
    Navigator.pop(context);
  }
}

class EdittingDepartmentsScreen extends StatefulWidget {
  EdittingDepartmentsScreen({
    Key key,
    this.departments,
    this.update,
  }) : super(key: key);
  final List<Department> departments;
  final Function(BuildContext context, List<DocumentReference> references) update;

  @override
  _EdittingDepartmentsScreenState createState() => _EdittingDepartmentsScreenState();
}

class _EdittingDepartmentsScreenState extends State<EdittingDepartmentsScreen> {
  GlobalKey<FormState> form = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();

  List<Department> selectedDepartment() {
    return widget.departments.where((department) => department.isSelected).toList();
  }

  List<Department> unSelectedDepartment() {
    return widget.departments.where((department) => !department.isSelected).toList();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? WaittingUpload.spinKitCircle(context)
        : SafeArea(
            child: Scaffold(
              drawer: Drawer(child: LanguageScreen()),
              appBar: AppBar(
                centerTitle: true,
                title: Text(S.of(context).departments),
                actions: [
                  // save all
                  IconButton(
                      icon: Icon(Icons.save),
                      onPressed: () async {
                        if (form.currentState.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          await widget.update(context, selectedDepartment().map((department) => department.reference).toList());
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
                          unSelectedDepartment().forEach((element) {
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
                        selectedDepartment().forEach((element) {
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
              body: Container(
                child: Form(
                  key: form,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          validator: (value) {
                            return widget.departments.where((element) => element.isSelected).isNotEmpty
                                ? null
                                : S.of(context).select_one_department_or_more;
                          },
                          autofocus: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                            hoverColor: Theme.of(context).primaryColorLight,
                            focusColor: Theme.of(context).primaryColorLight,
                            alignLabelWithHint: true,
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            labelStyle: Theme.of(context).textTheme.subtitle1,
                            filled: true,
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
                          itemCount: widget.departments.length,
                          itemBuilder: (context, index) {
                            var department = widget.departments[index];
                            var isSelected = department.isSelected;
                            return department.title.widget(builder: (context, title) {
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
                                        selected: department.isSelected,
                                        onTap: () {
                                          setState(() {
                                            department.isSelected = !department.isSelected;
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
            ),
          );
  }
}

class EdittingWordsScreen extends StatefulWidget {
  EdittingWordsScreen({
    Key key,
    this.words,
    this.update,
  }) : super(key: key);
  final Words words;
  final Function(BuildContext context, List<DocumentReference> references) update;

  @override
  _EdittingWordsScreenState createState() => _EdittingWordsScreenState();
}

class _EdittingWordsScreenState extends State<EdittingWordsScreen> {
  GlobalKey<FormState> form = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();

  List<Word> selectedWord() {
    return widget.words.words.where((word) => word.isSelected).toList();
  }

  List<Word> unSelectedWord() {
    return widget.words.words.where((word) => !word.isSelected).toList();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? WaittingUpload.spinKitCircle(context)
        : SafeArea(
            child: Scaffold(
              drawer: Drawer(child: LanguageScreen()),
              appBar: AppBar(
                centerTitle: true,
                title: Text(S.of(context).words),
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
              body: Container(
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
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                            hoverColor: Theme.of(context).primaryColorLight,
                            focusColor: Theme.of(context).primaryColorLight,
                            alignLabelWithHint: true,
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            labelStyle: Theme.of(context).textTheme.subtitle1,
                            filled: true,
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
                          itemCount: widget.words.words.length,
                          itemBuilder: (context, index) {
                            var word = widget.words.words[index];
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
            ),
          );
  }
}
