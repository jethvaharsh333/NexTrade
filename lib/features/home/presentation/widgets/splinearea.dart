import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class splinearea extends StatefulWidget {
  const splinearea({super.key});

  @override
  State<splinearea> createState() => _splineareaState();
}

class _splineareaState extends State<splinearea> {
  TooltipBehavior? _tooltipBehavior;
  late List<ChartSampleData>? _chartsampledata;

  @override
  void initState() {
    _chartsampledata = getChartSampleData();
    _tooltipBehavior = TooltipBehavior(
        enable: true,
        format: 'point.x : point.y Mw',
        header: '',
        canShowMarker: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          // height: 500,
          // width: 500,
          child: SfCartesianChart(
            margin: EdgeInsets.zero,
            borderWidth: 0,
            borderColor: Colors.transparent,
            plotAreaBorderWidth: 0,
            palette: <Color>[Colors.red],
            primaryXAxis: DateTimeAxis(
              majorGridLines: const MajorGridLines(width: 1),
              isVisible: false,
              borderWidth: 0,
              borderColor: Colors.transparent,
              intervalType: DateTimeIntervalType.months,
              interval: 2,
              labelIntersectAction: AxisLabelIntersectAction.rotate45,
              dateFormat: DateFormat.yMd(),
            ),
            primaryYAxis: const NumericAxis(
              minimum: 0,
              maximum: 10.0,
              interval: 1,
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              labelFormat: '{value}',
              isVisible: false,
              borderWidth: 0,
              borderColor: Colors.transparent,
              axisLine: const AxisLine(width: 0),
              majorTickLines: const MajorTickLines(size: 0),
            ),
            series: <SplineAreaSeries>[
              SplineAreaSeries<ChartSampleData, DateTime>(
                dataSource: _chartsampledata,
                xValueMapper: (ChartSampleData data, _) => data.x as DateTime,
                yValueMapper: (ChartSampleData data, _) => data.yValue,
                // color: const Color.fromRGBO(200, 84, 84, 1),
                opacity: 0.2,
                markerSettings: const MarkerSettings(
                    height: 15, width: 15, isVisible: false),
                gradient: const LinearGradient(colors: <Color>[
                  Color.fromRGBO(66, 255, 255, 1),
                  Color.fromRGBO(66, 231, 60, 1)
                ], stops: <double>[
                  0.0,
                  0.7
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                borderColor: const Color.fromRGBO(0, 128, 128, 1),
              )
            ],
            tooltipBehavior: TooltipBehavior(enable: false),
          ),
        ),
      ),
    );
  }

  List<ChartSampleData> getChartSampleData() {
    return [
      ChartSampleData(x: DateTime(2017, 10, 31), yValue: 6.3),
      ChartSampleData(x: DateTime(2017, 12, 15), yValue: 6.5),
      ChartSampleData(x: DateTime(2018, 01, 23), yValue: 6.0),
      ChartSampleData(x: DateTime(2018, 04, 18), yValue: 4.5),
      ChartSampleData(x: DateTime(2018, 07, 21), yValue: 5.2),
      ChartSampleData(x: DateTime(2018, 07, 29), yValue: 6.4),
      ChartSampleData(x: DateTime(2018, 08, 05), yValue: 6.9),
      ChartSampleData(x: DateTime(2018, 08, 09), yValue: 5.9),
      ChartSampleData(x: DateTime(2018, 08, 19), yValue: 6.3),
      ChartSampleData(x: DateTime(2018, 09, 28), yValue: 7.5),
      ChartSampleData(x: DateTime(2018, 10, 10), yValue: 6.0),
      ChartSampleData(x: DateTime(2018, 11, 14), yValue: 5.6),
      ChartSampleData(x: DateTime(2019, 03, 17), yValue: 5.5),
      ChartSampleData(x: DateTime(2019, 4, 12), yValue: 6.8),
    ];
  }
}

class ChartSampleData {
  ChartSampleData({this.x, this.yValue});

  dynamic x;
  num? yValue;
}
