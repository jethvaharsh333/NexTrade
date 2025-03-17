/*
import 'package:flutter/material.dart';
import 'package:nextrade/features/stock/domain/entities/stock_price.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StockChart extends StatefulWidget {
  final List<StockPrice> stockData;

  StockChart({required this.stockData});

  @override
  State<StockChart> createState() => _StockChartState();
}

class _StockChartState extends State<StockChart> {
  late ZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      enablePanning: true,
      enableDoubleTapZooming: true,
      zoomMode: ZoomMode.xy,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      // title: ChartTitle(text: "Stock Price Chart"),
      zoomPanBehavior: _zoomPanBehavior,
      margin: EdgeInsets.zero,
      borderWidth: 0,
      borderColor: Colors.transparent,
      plotAreaBorderWidth: 0,
      palette: <Color>[Colors.teal, Colors.red],

      primaryXAxis: const DateTimeAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        // isVisible: true,
        labelFormat: '{value}',
        borderWidth: 0,
        borderColor: Colors.transparent,
      ),
      primaryYAxis: const NumericAxis(
        labelFormat: '{value}',
        borderColor: Colors.transparent,
        majorTickLines: MajorTickLines(size: 0),
        isVisible: false, // Set to true for debugging
      ),

      series: <CartesianSeries>[
        SplineSeries<StockPrice, DateTime>(
          dataSource: widget.stockData,
          xValueMapper: (StockPrice data, _) => data.date,
          yValueMapper: (StockPrice data, _) => data.close.toDouble(),
          splineType: SplineType.natural,
          markerSettings: MarkerSettings(isVisible: true),
          animationDuration: 1000,
        ),
      ],
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:nextrade/features/stock/domain/entities/stock_price.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StockChart extends StatefulWidget {
  final List<StockPrice> stockData;

  StockChart({required this.stockData});

  @override
  State<StockChart> createState() => _StockChartState();
}

class _StockChartState extends State<StockChart> {
  late ZoomPanBehavior _zoomPanBehavior;
  late TooltipBehavior _tooltipBehavior; // Declare TooltipBehavior

  @override
  void initState() {
    super.initState(); // Always call super.initState() first

    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      enablePanning: true,
      enableDoubleTapZooming: true,
      zoomMode: ZoomMode.xy,
    );

    _tooltipBehavior = TooltipBehavior(
      enable: true,
      format: 'point.y%',
      header: '',
      canShowMarker: false,
      color: Colors.black87,
      textStyle: const TextStyle(color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      zoomPanBehavior: _zoomPanBehavior,
      tooltipBehavior: _tooltipBehavior, // Ensure this is initialized
      margin: EdgeInsets.zero,
      borderWidth: 0,
      borderColor: Colors.transparent,
      plotAreaBorderWidth: 0,

      primaryXAxis: const DateTimeAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        // intervalType: DateTimeIntervalType.months,
        // dateFormat: DateFormat.MMM(), // Show month names (JAN, FEB, etc.)
        isVisible: true,
        borderWidth: 0,
        borderColor: Colors.transparent,
      ),

      primaryYAxis: const NumericAxis(
        isVisible: false,
        borderColor: Colors.transparent,
        majorTickLines: MajorTickLines(size: 0),
      ),

      series: <CartesianSeries>[
        SplineAreaSeries<StockPrice, DateTime>(
          dataSource: widget.stockData,
          xValueMapper: (StockPrice data, _) => data.date,
          yValueMapper: (StockPrice data, _) => data.close.toDouble(),
          borderWidth: 2.5,
          borderColor: Color.fromRGBO(0, 255, 170, 1),

          // Gradient fill that creates the glow effect
          gradient: LinearGradient(
              colors: <Color>[
                Color.fromRGBO(0, 255, 170, 0.4),   // Bright green with moderate opacity at top
                Color.fromRGBO(0, 150, 100, 0.2),   // Mid green with lower opacity in middle
                Color.fromRGBO(0, 80, 60, 0.05)     // Dark green that fades to almost transparent
              ],
              stops: <double>[0.0, 0.4, 0.9],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
          ),
          animationDuration: 1500,
          // enableAnimation: true,
          opacity: 1.0,
          
          markerSettings: MarkerSettings(isVisible: false),
        ),
      ],
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:nextrade/features/stock/domain/entities/stock_price.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StockChart extends StatefulWidget {
  final List<StockPrice> stockData;

  StockChart({required this.stockData});

  @override
  State<StockChart> createState() => _StockChartState();
}

class _StockChartState extends State<StockChart> {
  late ZoomPanBehavior _zoomPanBehavior;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    super.initState();

    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      enablePanning: true,
      enableDoubleTapZooming: true,
      zoomMode: ZoomMode.xy,
    );

    _tooltipBehavior = TooltipBehavior(
      enable: true,
      format: 'point.y',
      header: '',
      canShowMarker: false,
      color: const Color.fromRGBO(40, 40, 50, 0.9),
      textStyle: const TextStyle(color: Color.fromRGBO(0, 255, 170, 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      zoomPanBehavior: _zoomPanBehavior,
      tooltipBehavior: _tooltipBehavior,
      margin: EdgeInsets.zero,
      borderWidth: 0,
      borderColor: Colors.transparent,
      plotAreaBorderWidth: 0,
      backgroundColor: const Color.fromRGBO(24, 24, 32, 1),

      // Configure grid lines to match the Meta chart
      primaryXAxis: DateTimeAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        intervalType: DateTimeIntervalType.auto,
        dateFormat: null,
        labelStyle: const TextStyle(
          color: Color.fromRGBO(150, 150, 150, 1),
          fontSize: 10,
        ),
        majorGridLines: const MajorGridLines(
          width: 0.5,
          color: Color.fromRGBO(70, 70, 80, 0.5),
          dashArray: <double>[5, 5],
        ),
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(size: 0),
      ),

      primaryYAxis: const NumericAxis(
        isVisible: false,
        majorGridLines: MajorGridLines(
          width: 0.5,
          color: Color.fromRGBO(70, 70, 80, 0.5),
          dashArray: <double>[5, 5],
        ),
      ),

      series: <CartesianSeries>[
        // Thin line series for the main graph line
        SplineSeries<StockPrice, DateTime>(
          dataSource: widget.stockData,
          xValueMapper: (StockPrice data, _) => data.date,
          yValueMapper: (StockPrice data, _) => data.close.toDouble(),
          color: const Color.fromRGBO(0, 255, 170, 1),
          width: 2,
          markerSettings: const MarkerSettings(isVisible: false),
          animationDuration: 1500,
        ),

        // Area series for the gradient fill
        SplineAreaSeries<StockPrice, DateTime>(
          dataSource: widget.stockData,
          xValueMapper: (StockPrice data, _) => data.date,
          yValueMapper: (StockPrice data, _) => data.close.toDouble(),
          borderWidth: 0,
          animationDuration: 1500,

          // More subtle gradient like in the META chart
          gradient: const LinearGradient(
              colors: <Color>[
                Color.fromRGBO(0, 255, 170, 0.3),  // Bright green with low opacity
                Color.fromRGBO(0, 150, 100, 0.1),  // Mid green with very low opacity
                Color.fromRGBO(24, 24, 32, 0.01)   // Almost transparent matching background
              ],
              stops: <double>[0.0, 0.3, 0.7],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
          ),
          opacity: 1.0,
        ),
      ],
    );
  }
}