import 'package:flutter/material.dart';
import 'package:hafeez/generated/l10n.dart';
import '../../model/data.dart';

class WordsWidget extends StatefulWidget {
  final ItemModel model;
  const WordsWidget({
    Key key,
    @required this.model,
  }) : super(key: key);

  @override
  _WordsWidgetState createState() => _WordsWidgetState();
}

class _WordsWidgetState extends State<WordsWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.model.formKeys[3],
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              validator: (value) {
                return widget.model.selectedWords.isNotEmpty ? null : S.of(context).select_one_word_or_more;
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
              controller: widget.model.searchWordController,
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              cacheExtent: 30,
              itemCount: widget.model.wordsList.words.length,
              itemBuilder: (context, index) {
                var word = widget.model.wordsList.words[index];
                var isSelected = word.isSelected;
                return word.title.widget(builder: (context, title) {
                  var searchText = widget.model.searchWordController.value.text;
                  if (searchText.isEmpty || title.text.contains(searchText))
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
    );
  }
}
