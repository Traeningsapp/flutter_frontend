import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projekt_frontend/src/models/dataPoint.dart';
import 'package:projekt_frontend/src/models/exerciseStats.dart';
import 'package:projekt_frontend/src/services/DatabaseService.dart';
import 'package:projekt_frontend/src/utils/globalVariables.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ExerciseStatsOverlay extends StatefulWidget {
  final String userId;
  final String exerciseName;
  final int exerciseId;
  const ExerciseStatsOverlay({required this.exerciseId, required this.exerciseName, required this.userId, super.key});

  @override
  State<ExerciseStatsOverlay> createState() => _ExerciseStatsOverlayState();
}

class _ExerciseStatsOverlayState extends State<ExerciseStatsOverlay>
      with SingleTickerProviderStateMixin {

  DatabaseService _dbService = DatabaseService();

  late Future<List<ExerciseStats>?> stats;
  late List<ExerciseStats>? statsList = [];

  late String userId;
  late int exerciseId;
  late String exerciseName;

  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    _initRetrieval();
    _setupControllerAndAnimation();
  }

  Future<void> _initRetrieval() async {
    userId = widget.userId;
    exerciseId = widget.exerciseId;
    exerciseName = widget.exerciseName;

    statsList = await _dbService.getExerciseStats(userId, exerciseId);
  }

  void _setupControllerAndAnimation() {
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {

      });
    });

    controller.forward();
  }

  Table statsTable() {
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
        for(int i = 0; i < statsList!.length; i++)
          TableRow(
            children: [
              Text('${(statsList![i].setnr)}'),
              Text('${(statsList![i].kilo)}'),
              Text('${(statsList![i].reps)}'),
              Text(convertDate(statsList![i].createdDate))
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
    final Map<String, double> sumKilosByDate = {};
    final Map<String, int> countByDate = {};
    final dateFormat = DateFormat('yyyy-MM-dd');

    for (var stat in statsList!) {
      if (stat.createdDate != null) {
        final date = dateFormat.format(stat.createdDate!);
        final kilo = stat.kilo ?? 0;

        // Update sum and count maps
        sumKilosByDate[date] = (sumKilosByDate[date] ?? 0) + kilo;
        countByDate[date] = (countByDate[date] ?? 0) + 1;
      }
    }

    // Compute the average for each date
    final Map<String, double> averageKiloByDate = {};
    sumKilosByDate.forEach((date, totalKilo) {
      averageKiloByDate[date] = totalKilo / (countByDate[date] ?? 1);
    });

    // Convert the map to a list of DataPoint objects
    final data = averageKiloByDate.entries
        .map((entry) => DataPoint(DateTime.parse(entry.key), entry.value))
        .toList();

    return SfCartesianChart(
      primaryXAxis: DateTimeAxis(
          labelStyle: TextStyle(
            color: SelectedTextColor,
          ),
        dateFormat: DateFormat('d/M/y'),
        title: AxisTitle(
          text: 'Time period'
        )
      ),
      primaryYAxis: NumericAxis(
        labelStyle: TextStyle(
          color: SelectedTextColor,
        ),
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
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.all(15.0),
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
                   height: MediaQuery.of(context).size.height * 0.38,
                   child: SingleChildScrollView(
                       child: statsTable()
                   ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
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