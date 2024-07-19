import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:save2woproj/data/model.dart';
import 'package:save2woproj/data/historydisplay.dart';

Future<List<History>> fetchHistory() async {
  final response = await http.get(Uri.parse('https://save2wo-api.vercel.app/history'));

  if (response.statusCode == 200) {
    List<dynamic> jsonList = json.decode(response.body);
    return jsonList.map((json) => History.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}