import 'package:flutter/painting.dart';
import 'package:hafeez/model/Item/one/model/data.dart';
import 'package:hafeez/model/account/one/model/data.dart';
import 'package:hafeez/model/report/model/items_of_month.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DateTimeUnits {
// Days
  static List<DateTime> getDays(DateTime start, DateTime end) {
    if (end == null) end = DateTime.now();
    List<DateTime> days = <DateTime>[];
    while (!start.isAfter(end)) {
      days.add(start);
      start = start.add(Duration(days: 1));
    }
    return days;
  }

// Months
  static List<DateTime> getMonths(DateTime start, DateTime end) {
    if (end == null) end = DateTime.now();
    List<DateTime> months = <DateTime>[];
    while (!start.isAfter(end)) {
      months.add(DateTime(start.year, start.month, 1));
      start = DateTime(start.year, start.month + 1, start.day);
    }
    return months;
  }

// items by  days
  static List<ElementsOfDateTimeUnit> _itemsOfDays(
      List<ITem> itemsList, DateTime start, DateTime end) {
    var daysList = getDays(start, end);
    return daysList
        .map(
          (day) => ElementsOfDateTimeUnit(
              dateTime: day,
              count: itemsList
                  .where((item) =>
                      item.createAt.year == day.year &&
                      item.createAt.month == day.month &&
                      item.createAt.day == day.day)
                  .toList()
                  .length),
        )
        .toList();
  }

  static Object getItemsLineByDays(
      {List<ITem> itemsList,
      String type,
      Color color,
      DateTime start,
      DateTime end}) {
    var daysValue = _itemsOfDays(itemsList, start, end);
    return SplineSeries<ElementsOfDateTimeUnit, String>(
      dataSource: [...daysValue],
      xValueMapper: (ElementsOfDateTimeUnit itemsOfMonths, _) =>
          itemsOfMonths.dayText,
      yValueMapper: (ElementsOfDateTimeUnit itemsOfMonths, _) =>
          itemsOfMonths.count,
      dataLabelSettings: DataLabelSettings(isVisible: true),
      pointColorMapper: (ElementsOfDateTimeUnit itemsOfmonth, _) => color,
      color: color,
      // name of line
      name: type,
      width: 2,
      enableTooltip: true,
    );
  }

  /// items by months
  static List<ElementsOfDateTimeUnit> _itemsOfMonths(
      List<ITem> itemsList, DateTime start, DateTime end) {
    var monthsList = getMonths(start, end);
    return monthsList
        .map(
          (month) => ElementsOfDateTimeUnit(
              dateTime: month,
              count: itemsList
                  .where((item) =>
                      item.createAt.year == month.year &&
                      item.createAt.month == month.month)
                  .toList()
                  .length),
        )
        .toList();
  }

  /// items lines by months
  static Object getItemsLineByMonths(
      {List<ITem> itemsList,
      String type,
      Color color,
      DateTime start,
      DateTime end}) {
    var monthsValue = _itemsOfMonths(itemsList, start, end);
    return SplineSeries<ElementsOfDateTimeUnit, String>(
      enableTooltip: true,
      dataSource: [...monthsValue],
      xValueMapper: (ElementsOfDateTimeUnit itemsOfMonths, _) =>
          itemsOfMonths.monthText,
      yValueMapper: (ElementsOfDateTimeUnit itemsOfMonths, _) =>
          itemsOfMonths.count,
      dataLabelSettings: DataLabelSettings(isVisible: true),
      name: type,
      pointColorMapper: (ElementsOfDateTimeUnit itemsOfmonth, _) => color,
      color: color,
      width: 2,
    );
  }

  /// accounts by days
  static List<ElementsOfDateTimeUnit> _accountsOfDays(
      List<Account> itemsList, DateTime start, DateTime end) {
    var daysList = getDays(start, end);
    return daysList
        .map(
          (day) => ElementsOfDateTimeUnit(
              dateTime: day,
              count: itemsList
                  .where((item) =>
                      item.createAt.year == day.year &&
                      item.createAt.month == day.month &&
                      item.createAt.day == day.day)
                  .toList()
                  .length),
        )
        .toList();
  }

  /// accounts lines by days
  static Object getAccountsLineByDays(
      {List<Account> accountsList,
      String type,
      Color color,
      DateTime start,
      DateTime end}) {
    var daysValue = _accountsOfDays(accountsList, start, end);
    return SplineSeries<ElementsOfDateTimeUnit, String>(
      dataSource: [...daysValue],
      xValueMapper: (ElementsOfDateTimeUnit itemsOfMonths, _) =>
          itemsOfMonths.dayText,
      yValueMapper: (ElementsOfDateTimeUnit itemsOfMonths, _) =>
          itemsOfMonths.count,
      dataLabelSettings: DataLabelSettings(isVisible: true),
      pointColorMapper: (ElementsOfDateTimeUnit itemsOfmonth, _) => color,
      color: color,
      // name of line
      name: type,
      width: 2,
      enableTooltip: true,
    );
  }

  /// accounts by months
  static List<ElementsOfDateTimeUnit> _accountsOfMonths(
      List<Account> accountsList, DateTime start, DateTime end) {
    var monthsList = getMonths(start, end);
    return monthsList
        .map(
          (month) => ElementsOfDateTimeUnit(
              dateTime: month,
              count: accountsList
                  .where((item) =>
                      item.createAt.year == month.year &&
                      item.createAt.month == month.month)
                  .toList()
                  .length),
        )
        .toList();
  }

  /// accounts lines by months
  static Object getAccountsLineByMonths(
      {List<Account> accountsList,
      String type,
      Color color,
      DateTime start,
      DateTime end}) {
    var monthsValue = _accountsOfMonths(accountsList, start, end);
    return SplineSeries<ElementsOfDateTimeUnit, String>(
      enableTooltip: true,
      dataSource: [...monthsValue],
      xValueMapper: (ElementsOfDateTimeUnit itemsOfMonths, _) =>
          itemsOfMonths.monthText,
      yValueMapper: (ElementsOfDateTimeUnit itemsOfMonths, _) =>
          itemsOfMonths.count,
      dataLabelSettings: DataLabelSettings(isVisible: true),
      name: type,
      pointColorMapper: (ElementsOfDateTimeUnit itemsOfmonth, _) => color,
      color: color,
      width: 2,
    );
  }
}
