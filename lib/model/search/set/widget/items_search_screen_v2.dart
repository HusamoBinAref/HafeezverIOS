import 'package:flutter/material.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/Item/one/api/get.dart';
import 'package:hafeez/model/search/set/api/get_by_title_v2.dart';

import 'item_search_card.dart';

class ItemsSearchScreen extends StatefulWidget {
  ItemsSearchScreen({Key key}) : super(key: key);

  @override
  _ItemsSearchScreenState createState() => _ItemsSearchScreenState();
}

class _ItemsSearchScreenState extends State<ItemsSearchScreen> {
  int count = 10;
  final TextEditingController controller = TextEditingController();

  String get title => controller.value.text ?? "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(S.of(context).search_text),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
              child: Column(
            children: [
              TextFormField(
                controller: controller,
                onChanged: (val) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  labelText: S.of(context).search,
                  hintText: S.of(context).search + "...",
                ),
              ),
              if (controller.value.text.trim() != "")
                Expanded(
                  child: GetItemsByTitle.build(
                          title: controller.value.text.trim().trimLeft())
                      .futureWidget((context, asyncResultsItemsByTitle) {
                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 400,
                          childAspectRatio: 2 / 2.8,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        shrinkWrap: true,
                        cacheExtent: 100,
                        itemCount: asyncResultsItemsByTitle.data.list.length,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        itemBuilder: (context, index) {
                          var result =
                              asyncResultsItemsByTitle.data.list[index];
                          if (result.reference.path.contains("Item"))
                            return GetItem(
                                    reference: result.reference.parent.parent)
                                .widget((context, iTem) => SearchItemCard(
                                      iTem: iTem,
                                    ));
                          else
                            return Card(
                              child: ListTile(
                                title: Text(result.text),
                              ),
                            );
                        });
                  }),
                )
              else
                Container(),
            ],
          )),
        ),
      ),
    );
  }
}
