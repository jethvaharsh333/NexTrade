import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// import 'C:/Users/jethv/AppData/Local/Pub/Cache/hosted/pub.dev/syncfusion_flutter_charts-24.1.47+2/lib/src/charts/cartesian_chart.dart';
class spline extends StatefulWidget {
  const spline({super.key});

  @override
  State<spline> createState() => _splineState();
}

class _splineState extends State<spline> {
  late List<ChartData>? _chartdata;
  late ZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    _chartdata = getChartData();
    _zoomPanBehavior = ZoomPanBehavior(enableMouseWheelZooming : true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
          child: SfCartesianChart(
            margin: EdgeInsets.zero,
            zoomPanBehavior: _zoomPanBehavior,
            borderWidth: 0,
            borderColor: Colors.transparent,
            plotAreaBorderWidth: 0,
            palette: <Color>[
              Colors.teal,
              Colors.red
            ],
            primaryXAxis: const NumericAxis(
              minimum: 17,
              maximum: 28,
              interval: 1,
              isVisible: false,
              borderWidth: 0,
              borderColor: Colors.transparent,
            ),
            primaryYAxis: const NumericAxis(
              minimum: 9000,
              maximum: 31000,
              interval: 2000,
              axisLine: AxisLine(width: 0),
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              labelFormat: '{value}',
              majorTickLines: MajorTickLines(size: 0),
              isVisible: false,
              borderWidth: 0,
              borderColor: Colors.transparent,
            ),
            series: <SplineSeries>[
              SplineSeries<ChartData, int>(
                dataSource: _chartdata,
                xValueMapper: (ChartData x, _) => x.day,
                yValueMapper: (ChartData x, _) => x.bal,
                // markerSettings: MarkerSettings(isVisible: isFalse.matches(_chartdata,{})),
                markerSettings: const MarkerSettings(isVisible: false),
              ),
            ],
            tooltipBehavior: TooltipBehavior(enable: true),
          ),
        ),
      ),
    );
  }

  List<ChartData> getChartData() {
    return [
      ChartData(day: 17, bal: 21500),
      ChartData(day: 18, bal: 19500),
      ChartData(day: 19, bal: 19500),
      ChartData(day: 20, bal: 19500),
      ChartData(day: 21, bal: 22000),
      ChartData(day: 22, bal: 25000),
      ChartData(day: 23, bal: 28000),
      ChartData(day: 24, bal: 30000),
      ChartData(day: 25, bal: 28500),
      ChartData(day: 26, bal: 25500),
      ChartData(day: 27, bal: 25500),
      ChartData(day: 28, bal: 10500),
    ];
  }
}

class ChartData{
  ChartData({this.day,this.bal});
  int? day = 0;
  double? bal = 0;
}
