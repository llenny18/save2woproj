import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:save2woproj/data/model.dart';


Future<List<Contamination>> fetchContamination() async {
  final response = await http.get(Uri.parse('https://save2wo-api.vercel.app/contamination'));

  if (response.statusCode == 200) {
    List<dynamic> jsonList = json.decode(response.body);
    return jsonList.map((json) => Contamination.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}