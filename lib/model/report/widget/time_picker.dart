import 'package:flutter/material.dart'
    show BuildContext, Key, Scaffold, StatelessWidget, Widget, required;
import 'package:hafeez/model/report/model/data.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart'
    show SfDateRangePicker;
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ReportDatePicker extends StatelessWidget {
  const ReportDatePicker({
    Key key,
    @required this.report,
  }) : super(key: key);

  final ReportInfo report;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SfDateRangePicker(
      view: DateRangePickerView.month,
      monthViewSettings: DateRangePickerMonthViewSettings(firstDayOfWeek: 6),
      selectionMode: DateRangePickerSelectionMode.range,
      initialSelectedRange: PickerDateRange(report.start, report.end),
      onSelectionChanged: (DateRangePickerSelectionChangedArgs range) {
        report.start = range.value.startDate;
        report.end = range.value.endDate;
      },
    ));
  }
}
