import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:save2woproj/data/model.dart';




// Define the  ThresholdData class
class  ThresholdData {
  final String time;
  final double contaminationValue;

   ThresholdData(this.time, this.contaminationValue);
}

class ThresholdChart extends StatefulWidget {
  const ThresholdChart({super.key});
  @override
  _SampleChartState createState() => _SampleChartState();
}

class _SampleChartState extends State<ThresholdChart> {
  List< ThresholdData> _data = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final response = await http.get(Uri.parse('https://save2wo-api.vercel.app/threshold'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final thresholds = data.map((json) => ThresholdList.fromJson(json)).toList();

        // Sort thresholds by timestamp
        thresholds.sort((a, b) => a.timestamp.compareTo(b.timestamp));

        setState(() {
          _data = thresholds.map((threshold) {
            final contaminationValue = _getContaminationValue(threshold.contamination);
            final formattedDate = '${threshold.timestamp.month}/${threshold.timestamp.day}';
            return  ThresholdData(formattedDate, contaminationValue);
          }).toList();
        });
      } else {
        throw Exception('Failed to load thresholds');
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  double _getContaminationValue(String contamination) {
    switch (contamination) {
      case 'Low Dissolved Oxygen':
        return 1.0;
      case 'Dissolved Oxygen Spike':
        return 2.0;
      default:
        return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Threshold Records Chart', style: TextStyle( fontWeight: FontWeight.bold,  fontFamily: 'Metropolis')),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            series: <LineSeries< ThresholdData, String>>[
              LineSeries< ThresholdData, String>(
                dataSource: _data,
                xValueMapper: ( ThresholdData sales, _) => sales.time,
                yValueMapper: ( ThresholdData sales, _) => sales.contaminationValue,
                color: Colors.blue,
              ),
            ],
            tooltipBehavior: TooltipBehavior(enable: true),
          ),
        ),
      ),
    );
  }
}