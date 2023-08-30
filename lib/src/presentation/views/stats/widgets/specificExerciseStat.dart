import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projekt_frontend/src/models/dataPoint.dart';
import 'package:projekt_frontend/src/models/exerciseStats.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ExerciseStatsOverlay extends StatefulWidget {
  final String exerciseName;
  final List<ExerciseStats>? stats;
  const ExerciseStatsOverlay({required this.stats, required this.exerciseName, super.key});

  @override
  State<ExerciseStatsOverlay> createState() => _ExerciseStatsOverlayState();
}

class _ExerciseStatsOverlayState extends State<ExerciseStatsOverlay>
      with SingleTickerProviderStateMixin {

  late List<ExerciseStats>? stats;
  late String exerciseName;

  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    stats = widget.stats;
    exerciseName = widget.exerciseName;

    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {

      });
    });

    controller.forward();
  }


  Table StatsTable() {
    return Table(
      border: const TableBorder(horizontalInside: BorderSide(width: 1, color: Colors.black, style: BorderStyle.solid)),
      children: [
        const TableRow(
            children: [
              Text('setnr'),
              Text('Kilo'),
              Text('Reps'),
              Text('Date')
            ]
        ),
        for(int i = 0; i < stats!.length; i ++)
          TableRow(
            children: [
              Text('${(stats![i].setnr)}'),
              Text('${(stats![i].kilo)}'),
              Text('${(stats![i].reps)}'),
              Text(convertDate(stats![i].createdDate))
            ]
          ),
      ],
    );
  }

  String convertDate(DateTime? date) {
    final dateString = DateFormat('d/M/y').format(date as DateTime);
    return dateString;
  }

  SfCartesianChart statsChart() {
    final Map<DateTime, double> averageKiloByDate = {};
    for (var stat in stats!) {
      if (stat.createdDate != null) {
        final date = stat.createdDate!;
        final kilo = stat.kilo ?? 0;
        if (averageKiloByDate.containsKey(date)) {
          averageKiloByDate[date] = (averageKiloByDate[date]! + kilo) / 2;
        } else {
          averageKiloByDate[date] = kilo.toDouble();
        }
      }
    }

    // Convert the map to a list of DataPoint objects
    final data = averageKiloByDate.entries
        .map((entry) => DataPoint(entry.key, entry.value))
        .toList();

    return SfCartesianChart(
      primaryXAxis: DateTimeAxis(
        dateFormat: DateFormat('d/M/y')
      ),
      series: <ChartSeries>[
        LineSeries<DataPoint, DateTime>(
          dataSource: data,
          xValueMapper: (DataPoint point, _) => point.date,
          yValueMapper: (DataPoint point, _) => point.kilo,
          name: 'Average Kilo',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
            child: Container(
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(15.0),
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: ShapeDecoration(
                color: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)
                )
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(exerciseName),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Exercise history')
                    ],
                  ),
                  const Divider(
                    height: 20,
                    thickness: 2,
                    color: Colors.black,
                  ),
                  SizedBox(
                   height: MediaQuery.of(context).size.height * 0.4,
                   child: SingleChildScrollView(
                       child: StatsTable()
                   ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: statsChart(),
                  )
                ],
              ),
            ),
        ),
      ),
    );
  }
}