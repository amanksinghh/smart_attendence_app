
import 'package:flutter/material.dart';
import 'package:smart_attendence_app/api_models/responses/user_by_id_response.dart';
import 'package:smart_attendence_app/theme/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartsPage extends StatefulWidget {

  List<Logs> graphData;
  ChartsPage({Key? key, required this.graphData}) : super(key: key);


  @override
  State<ChartsPage> createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 300,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: kElevationToShadow[4]),

        child: widget.graphData.isNotEmpty
            ? SfCartesianChart(
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
              SplineAreaSeries<Logs, String>(
                  //splineType: SplineType.clamped,
                  color: Colors.blue,
                  //width: 3,
                  legendItemText: "Attendance Data",
                  opacity: 0.4,
                  dataSource: widget.graphData,
                  xValueMapper: (Logs data, _) => data.date
                            ?.replaceAll("/2023", "")
                            .replaceAll("/2022", ""),
                        yValueMapper: (Logs data, _) => data.workingHours,
                  // to display label use below code
                  dataLabelSettings: const DataLabelSettings(
                    // Renders the data label
                    isVisible: true,
                    labelAlignment: ChartDataLabelAlignment.top,
                    useSeriesColor: true,
                  ),
                  markerSettings: const MarkerSettings(isVisible: true))
            ])
            : const Center(
                child: Text(
                  "No Data Available",
                  style: TextStyle(color: grey),
                ),
              ));
  }
}



