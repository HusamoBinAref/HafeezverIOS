import 'package:flutter/material.dart'
    show
        BuildContext,
        Center,
        Container,
        Directionality,
        Key,
        StatelessWidget,
        Theme,
        Widget,
        TextDirection;
import 'package:hafeez/model/report/model/data.dart';
import 'package:provider/provider.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class ReportChart extends StatelessWidget {
  const ReportChart({Key key, this.lines, this.title}) : super(key: key);
  final List<Object> lines;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: Consumer<ReportInfo>(builder: (context, reportInfo, _) {
            return SfCartesianChart(
              legend: Legend(
                toggleSeriesVisibility: true,
                isVisible: true,
                isResponsive: true,
                position: LegendPosition.bottom,
                backgroundColor: Theme.of(context).primaryColor,
              ),
              tooltipBehavior: TooltipBehavior(enable: true),
              title: ChartTitle(
                text: title +
                    "   ( ${reportInfo.formatedStartTime} - ${reportInfo.formatedEndTime} )",
                alignment: ChartAlignment.center,
              ),

              // Initialize category axis
              primaryXAxis: CategoryAxis(),
              series: <ChartSeries>[
                // Initialize line series
                ...lines
              ],
            );
          }),
        ),
      ),
    );
  }
}
