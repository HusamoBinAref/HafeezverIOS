import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hafeez/model/Item/one/api/get.dart';
import 'package:hafeez/model/account/one/api/get.dart';
import 'package:hafeez/model/department/one/api/department.dart';
import 'package:hafeez/model/specialization/one/api/specialization.dart';

class SearchResult {
  SearchResult({
    this.type,
    this.result,
  });
  static SearchResult build(DocumentSnapshot snapshot) {
    return getResult(snapshot.reference);
  }

  final String type;
  final dynamic result;

  static bool isItem(DocumentReference reference) => reference.path.contains("Item");
  static bool isUser(DocumentReference reference) => reference.path.contains("User");
  static bool isDepartment(DocumentReference reference) => reference.path.contains("Department");
  static bool isSpecailization(DocumentReference reference) => reference.path.contains("Specailization");

  static SearchResult getResult(DocumentReference reference) {
    if (isItem(reference))
      return SearchResult(type: "Item", result: GetItem(reference: reference));
    else if (isUser(reference))
      return SearchResult(type: "User", result: GetAccount(reference: reference));
    else if (isDepartment(reference))
      return SearchResult(type: "Department", result: GetDepartment(reference: reference));
    else if (isSpecailization(reference))
      return SearchResult(type: "Specailization", result: GetSpecialization(reference: reference));
    else
      return SearchResult(
        type: "",
      );
  }
}

class SearchItemResult {
  static SearchItemResult build(SearchResult result) {
    return SearchItemResult(item: result.result as GetItem);
  }

  final GetItem item;

  SearchItemResult({@required this.item});
}

class SearchAccountResult {
  static SearchAccountResult build(SearchResult result) {
    return SearchAccountResult(account: result.result as GetAccount);
  }

  final GetAccount account;

  SearchAccountResult({@required this.account});
}
