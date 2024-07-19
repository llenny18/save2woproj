import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:save2woproj/data/model.dart';

Future<List<ThresholdList>> fetchThresholds() async {
  final response = await http.get(Uri.parse('https://save2wo-api.vercel.app/threshold'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => ThresholdList.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load thresholds');
  }
}
