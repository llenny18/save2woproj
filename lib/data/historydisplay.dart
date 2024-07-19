import 'dart:convert';
import 'package:save2woproj/data/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:save2woproj/data/historycard.dart';
import 'package:save2woproj/data/model.dart';



class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('History Data')),
        body: HistoryList(),
      ),
    );
  }
}

class HistoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<History>>(
      future: fetchHistory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available'));
        } else {
          List<History> histories = snapshot.data!;
          return ListView.builder(
            itemCount: histories.length,
            itemBuilder: (context, index) {
              History history = histories[index];
              return ListTile(
                title: Text('Cage: ${history.cage}'),
                subtitle: Text(
                  'Dead Fish: ${history.deadFish}\n'
                  'Contamination: ${history.contamination}\n'
                  'Timestamp: ${history.timestamp}\n'
                  'Water Quality - NO2: ${history.waterQuality.no2}\n'
                  'pH: ${history.waterQuality.ph}\n'
                  'Temperature: ${history.waterQuality.temperature}\n'
                  'DO: ${history.waterQuality.do2}',
                ),
              );
            },
          );
        }
      },
    );
  }
}