import 'package:bands/model/band.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class PieChartBand extends StatefulWidget {
  const PieChartBand({Key key, this.bands}) : super(key: key);

  @override
  _PieChartBandState createState() => _PieChartBandState();
  final List<Band> bands;
}

class _PieChartBandState extends State<PieChartBand> {
  List<Color> colorList = [
    Colors.red[400],
    Colors.green[400],
    Colors.blue[400],
    Colors.yellow[400],
  ];

  @override
  Widget build(BuildContext context) {
    List<Band> bands = widget.bands;
    Map<String, double> dataMap = new Map();
    bands.forEach((band) {
      dataMap.putIfAbsent(band.name, () => band.votes.toDouble());
    });
    return PieChart(
      dataMap: dataMap,
      colorList: colorList,
      animationDuration: Duration(milliseconds: 1000),
      chartType: ChartType.ring,
    );
  }
}
