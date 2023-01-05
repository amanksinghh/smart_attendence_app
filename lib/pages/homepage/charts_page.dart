
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
                  legendItemText: "Attendence Data",
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


// class ChartWidget extends StatefulWidget {
//   List<GraphData> graphData;
//
//   ChartWidget({Key? key, required this.graphData}) : super(key: key);
//
//   static const String id = 'ChartWidget';
//
//   @override
//   State<ChartWidget> createState() => _ChartWidgetState();
// }
//
// class _ChartWidgetState extends State<ChartWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         width: MediaQuery.of(context).size.width,
//         height: 300,
//         decoration: BoxDecoration(
//             color: ColorManager.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: kElevationToShadow[4]),
//         child: widget.graphData.isNotEmpty
//             ? SfCartesianChart(
//                 primaryXAxis: CategoryAxis(
//                   majorGridLines: MajorGridLines(width: 0),
//                 ),
//                 primaryYAxis: NumericAxis(
//                   //Hide the gridlines of y-axis
//                   majorGridLines: MajorGridLines(width: 0),
//                   //Hide the axis line of y-axis
//                 ),
//                 // Chart title
//                 title: ChartTitle(
//                     text: StringManager.completedRidesWeekDays,
//                     textStyle: getBoldStyle(
//                         color: ColorManager.darkPrimaryBlue, fontSize: 12)),
//                 legend: Legend(isVisible: true, position: LegendPosition.bottom
//                     //image: AssetImage('images/truck_legend.png'),
//                     ),
//                 series: <ChartSeries>[
//                     // Renders spline chart
//                     SplineAreaSeries<GraphData, String>(
//                         //splineType: SplineType.clamped,
//                         color: ColorManager.purpleCard,
//                         //width: 3,
//                         legendItemText: StringManager.incentive,
//                         opacity: 0.4,
//                         dataSource: widget.graphData,
//                         xValueMapper: (GraphData rides, _) =>
//                             rides.date?.split("-")[2],
//                         yValueMapper: (GraphData rides, _) => rides.count,
//                         // to display label use below code
//                         dataLabelSettings: DataLabelSettings(
//                           // Renders the data label
//                           isVisible: true,
//                           labelAlignment: ChartDataLabelAlignment.top,
//                           useSeriesColor: true,
//                           textStyle: getRegularStyle(
//                               color: ColorManager.white,
//                               fontSize: 13),
//                         ),
//                         markerSettings: MarkerSettings(isVisible: true))
//                   ])
//             : Center(
//                 child: Text(
//                   StringManager.noDataAvailable,
//                   style: getRegularStyle(color: ColorManager.grey),
//                 ),
//               ));
//   }
// }
