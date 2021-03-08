import 'package:hafeez/generated/l10n.dart';
import 'package:intl/intl.dart';

class ElementsOfDateTimeUnit {
  final DateTime dateTime;
  final int count;

  ElementsOfDateTimeUnit({
    this.dateTime,
    this.count,
  });

  String get monthText =>
      DateFormat.yMMMM(S.current.languageCode).format(dateTime);
  String get dayText {
    return DateFormat.MMMd(S.current.languageCode).format(dateTime);
  }

  DateTime get date {
    return dateTime;
  }
}
