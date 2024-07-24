import 'package:save2woproj/data/model.dart';
import 'package:flutter/material.dart';
import 'package:save2woproj/data/contaminationcard.dart';



class ContaminationListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Record Table')),
        body: ContaminationList(),
      ),
    );
  }
}

class ContaminationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Contamination>>(
      future: fetchContamination(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available'));
        } else {
          List<Contamination> contaminations = snapshot.data!;
          return ListView.builder(
            itemCount: contaminations.length,
            itemBuilder: (context, index) {
              Contamination contamination = contaminations[index];
              return ListTile(
                title: Text('Cage: ${contamination.cage}'),
                subtitle: Text(
                  'Contamination: ${contamination.contamination}\n'
                  'Timestamp: ${contamination.timestamp}\n'
                  'Water Quality - NO2: ${contamination.waterQuality.no2}\n'
                  'pH: ${contamination.waterQuality.ph}\n'
                  'Temperature: ${contamination.waterQuality.temperature}\n'
                  'DO: ${contamination.waterQuality.do2}',
                ),
              );
            },
          );
        }
      },
    );
  }
}