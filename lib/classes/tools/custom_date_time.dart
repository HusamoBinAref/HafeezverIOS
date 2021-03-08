import 'package:hafeez/generated/l10n.dart';
import 'package:intl/intl.dart';

class CustomDateTime {
  CustomDateTime({this.date});
  DateTime date;

  set setDate(DateTime newDate) => date = newDate;

  String get getDate {
    if (date != null) {
      var format = DateFormat.yMMMMEEEEd(S.current.languageCode);
      return format.format(date);
    } else {
      return '';
    }
  }
}
