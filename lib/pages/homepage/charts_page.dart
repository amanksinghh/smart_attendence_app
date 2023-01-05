
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartsPage extends StatefulWidget {
  const ChartsPage({Key? key}) : super(key: key);

  @override
  State<ChartsPage> createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> {
  List<AttendanceData> data = [
    AttendanceData('Mon', 6),
    AttendanceData('Tues', 9),
    AttendanceData('Wed', 8),
    AttendanceData('Thur', 10),
    AttendanceData('Fri', 6)
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 300,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: kElevationToShadow[4]),
        child: SfCartesianChart(
            plotAreaBorderWidth: 0,
            enableAxisAnimation: true,
            primaryXAxis: CategoryAxis(
               majorGridLines: const MajorGridLines(width: 0),
            ),
            primaryYAxis: NumericAxis(
                //Hide the gridlines of y-axis
                majorGridLines: const MajorGridLines(width: 0),
            ),
            // Chart title
            title: ChartTitle(
              text: "Weekly Attendance data",
            ),
            legend: Legend(isVisible: true, position: LegendPosition.bottom
                //image: AssetImage('images/truck_legend.png'),
                ),
            series: <ChartSeries>[
              // Renders spline chart
              SplineAreaSeries<AttendanceData, String>(
                  //splineType: SplineType.clamped,
                  color: Colors.blue,
                  //width: 3,
                  legendItemText: "Attendance Data",
                  opacity: 0.4,
                  dataSource: data,
                  xValueMapper: (AttendanceData data, _) => data.days,
                  yValueMapper: (AttendanceData data, _) => data.hours,
                  // to display label use below code
                  dataLabelSettings: const DataLabelSettings(
                    // Renders the data label
                    isVisible: true,
                    labelAlignment: ChartDataLabelAlignment.top,
                    useSeriesColor: true,
                  ),
                  markerSettings: const MarkerSettings(isVisible: true))
            ]));
  }
}

class AttendanceData {
  AttendanceData(this.days, this.hours);

  final String days;
  final double hours;
}
