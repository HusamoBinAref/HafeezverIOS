import 'package:flutter/material.dart';
import 'package:hafeez/classes/commends/key_words.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/Item/set/controller/model/data.dart';
import 'package:hafeez/model/department/one/model/data.dart';
import 'package:hafeez/model/language/one/model/data.dart';
import 'package:hafeez/model/word/Model/word.dart';

class FinalItemWidget extends StatelessWidget {
  final Function loading;
  final ItemModel model;
  FinalItemWidget({
    Key key,
    @required this.loading,
    @required this.model,
  }) : super(key: key);
  final TextEditingController bookUrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (model.type == KeyWords.itemKeyWords[0])
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: bookUrl,
                  decoration: InputDecoration(
                    labelText: "ادخل رابط الكتاب ...",
                    hintText: "الكتاب ",
                  ),
                ),
              ),
            if (model.selectedTitles.isNotEmpty)
              _TitlesChildren(titles: model.selectedTitles),
            if (model.selectedDescriptions.isNotEmpty)
              _DescriptionsChildren(descriptions: model.selectedDescriptions),
            if (model.selectedDepartments.isNotEmpty)
              _DepartmentsChildren(departments: model.selectedDepartments),
            if (model.selectedWords.isNotEmpty)
              _WordsChildren(words: model.selectedWords),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.cloud_upload),
        onPressed: () {
          model.bookUrl = bookUrl.value.text;
          loading();
        },
      ),
    );
  }
}

class _DepartmentsChildren extends StatelessWidget {
  const _DepartmentsChildren({
    Key key,
    this.departments,
  }) : super(key: key);
  final List<Department> departments;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            color: Theme.of(context).primaryColorLight,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                S.of(context).departments,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          ),
          ...departments
              .map(
                (department) => department.title.widget(
                  builder: (context, title) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          title.text,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                    );
                  },
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}

class _WordsChildren extends StatelessWidget {
  const _WordsChildren({
    Key key,
    this.words,
  }) : super(key: key);
  final List<Word> words;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            color: Theme.of(context).primaryColorLight,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                S.of(context).words,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          ),
          ...words
              .map(
                (words) => words.title.widget(
                  builder: (context, title) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          title.text,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                    );
                  },
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}

class _DescriptionsChildren extends StatelessWidget {
  const _DescriptionsChildren({
    Key key,
    this.descriptions,
  }) : super(key: key);
  final List<Language> descriptions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            color: Theme.of(context).primaryColorLight,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                S.of(context).descriptions,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          ),
          ...descriptions
              .map((description) => Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(
                          description.textEditingController.value.text,
                          style: Theme.of(context).textTheme.subtitle1,
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                        ),
                        leading: LimitedBox(
                          maxHeight: 50,
                          child: description.iconWidget(context),
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ],
      ),
    );
  }
}

class _TitlesChildren extends StatelessWidget {
  const _TitlesChildren({
    Key key,
    this.titles,
  }) : super(key: key);
  final List<Language> titles;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            color: Theme.of(context).primaryColorLight,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                S.of(context).titles,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          ),
          ...titles
              .map((title) => Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(
                          title.textEditingController.value.text,
                          style: Theme.of(context).textTheme.subtitle1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        leading: LimitedBox(
                          maxHeight: 50,
                          child: title.iconWidget(context),
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ],
      ),
    );
  }
}
