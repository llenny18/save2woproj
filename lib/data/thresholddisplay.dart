import 'package:flutter/material.dart';
import 'package:save2woproj/data/model.dart'; 
import 'package:save2woproj/data/thresholdcard.dart';

class ThresholdTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ThresholdListScreen(),
    );
  }
}

class ThresholdListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Threshold List'),
      ),
      body: FutureBuilder<List<ThresholdList>>(
        future: fetchThresholds(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          }

          final thresholds = snapshot.data!;

          return ListView.builder(
            itemCount: thresholds.length,
            itemBuilder: (context, index) {
              final threshold = thresholds[index];
              return ListTile(
                title: Text(threshold.status),
                subtitle: Text(
                  'Cage: ${threshold.cage}, Contamination: ${threshold.contamination}, Timestamp: ${threshold.timestamp}',
                ),
              );
            },
          );
        },
      ),
    );
  }
}
