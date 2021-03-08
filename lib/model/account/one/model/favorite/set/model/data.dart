import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hafeez/classes/commends/key_words.dart';
import 'package:hafeez/model/account/one/model/favorite/one/model/data.dart';
import 'package:hafeez/model/account/one/model/favorite/set/widget/root.dart';

class Favorites {
  static Favorites build(QuerySnapshot snapshot) {
    if (snapshot.docs.isNotEmpty) {
      return Favorites(list: snapshot.docs.map(Favorite.build).toList());
    } else
      return Favorites(list: []);
  }

  Favorites({@required this.list});
  final List<Favorite> list;

  List<Favorite> get _books =>
      list.where((favorite) => favorite.type == KeyWords.itemKeyWords[0]).toList();
  List<Favorite> get _posts =>
      list.where((favorite) => favorite.type == KeyWords.itemKeyWords[1]).toList();
  List<Favorite> get _videos =>
      list.where((favorite) => favorite.type == KeyWords.itemKeyWords[2]).toList();
  List<Favorite> get _voices =>
      list.where((favorite) => favorite.type == KeyWords.itemKeyWords[3]).toList();
  List<Favorite> get _sheikhs =>
      list.where((favorite) => favorite.type == KeyWords.isSheikh).toList();
  List<Favorite> get _departments =>
      list.where((favorite) => favorite.type == KeyWords.department).toList();

  FavoritesWidgets get widgetsByAll => FavoritesWidgets(favorites: this);
  FavoritesWidgets get widgetsByBooks => FavoritesWidgets(favorites: Favorites(list: _books));
  FavoritesWidgets get widgetsByPosts => FavoritesWidgets(favorites: Favorites(list: _posts));
  FavoritesWidgets get widgetsByVideos => FavoritesWidgets(favorites: Favorites(list: _videos));
  FavoritesWidgets get widgetsByVoices => FavoritesWidgets(favorites: Favorites(list: _voices));
  FavoritesWidgets get widgetsByDepartments =>
      FavoritesWidgets(favorites: Favorites(list: _departments));

  FavoritesWidgets get widgetsBySheikhs => FavoritesWidgets(favorites: Favorites(list: _sheikhs));
}
