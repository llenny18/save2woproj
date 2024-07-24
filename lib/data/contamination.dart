import 'package:save2woproj/model/model.dart';
import 'package:flutter/material.dart';
import 'package:save2woproj/components/table.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



class ContaminationList extends StatefulWidget {
  @override
  State<ContaminationList> createState() => StateContaminationList();
}

class StateContaminationList extends State<ContaminationList> {
  Future<List<Contamination>?>? con;
  List<Contamination> _contamination = [];
  late Map<String, int> _values;
  int sum = 0;
  @override
  void initState() {
    super.initState();
    con = fetchData();
    _values = {};
  }

  final List<String> contaminationLevels = [
    "Dissolved Oxygen Spike",
    "Dissolved Oxygen Low",
    "pH Level Unstable"
  ];
  final List<String> columns = ["Contamination", "Hits", "Frequency"];
  Future<List<Contamination>?> fetchData() async {
    final response = await http.get(Uri.https('save2wo-api.vercel.app', '/contamination'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      _contamination =
          data.map((json) => Contamination.fromJson(json)).toList();
      return _contamination;
    }
  }

  /// Aggregates the data by counting the occurrences of a specific contamination value.
  ///
  /// The [value] parameter specifies the contamination value to count.
  /// Returns the count of occurrences of the specified contamination value.
  int aggregateData(String value) {
    int count = 0;

    _contamination.forEach((element) {
      if (element.contamination == value) {
        count++;
      }
    });
    sum += count;
    return count;
  }
  /// Sets the data for contamination.
  ///
  /// This method iterates over the [_contamination] list and aggregates the data
  /// based on the contamination value. The aggregated data is stored in the [_values] map.
  /// If the [_values] map is empty, a new entry is added for the contamination value.
  /// If the [_values] map already contains an entry for the contamination value, the
  /// existing entry is not modified.
  void setData() {
    if (_contamination.isNotEmpty) {
      for (var data in _contamination) {
        if (_values.isEmpty) {
          _values.addAll({data.contamination: aggregateData(data.contamination)});
        } else {
          if (!_values.containsKey(data.contamination)) {
            _values.addAll({data.contamination: aggregateData(data.contamination)});
          }
        }
      }
    }
  }

  Widget buildLinear(value) => LinearProgressIndicator(
        minHeight: 10,
        value: value,
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
      );
  Widget buildDataWidget(context, snapshot, row) =>
      ListDataTable(columns: columns, rows: row);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Contamination>?>(
      future: con,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.connectionState == ConnectionState.none) {
          return Container();
        } else {
          if (snapshot.hasData) {
            setData();

            /// Creates a map containing information about contamination levels, hits, and frequency.
            ///
            /// The map has the following structure:
            /// {
            ///   "Contamination": [Text, Text, Text],
            ///   "Hits": [Text, Text, Text],
            ///   "Frequency": [Widget, Widget, Widget]
            /// }
            ///
            /// The "Contamination" key holds a list of Text widgets representing the contamination levels.
            /// The "Hits" key holds a list of Text widgets representing the hits for each contamination level.
            /// The "Frequency" key holds a list of Widget objects representing the frequency of each contamination level.
            ///
            /// The values for the "Contamination" and "Hits" keys are obtained from the `contaminationLevels` list and `_values` map.
            /// The values for the "Frequency" key are calculated by dividing the values from the `_values` map by the `sum` variable
            /// and passing them to the `buildLinear` function.
            ///
            /// Example usage:
            /// ```dart
            /// final row = {
            ///   "Contamination": [
            ///     Text(contaminationLevels[0].toString()),
            ///     Text(contaminationLevels[1].toString()),
            ///     Text(contaminationLevels[2].toString())
            ///   ],
            ///   "Hits": [
            ///     Text(_values[contaminationLevels[0]].toString()),
            ///     Text(_values[contaminationLevels[1]].toString()),
            ///     Text(_values[contaminationLevels[2]].toString())
            ///   ],
            ///   "Frequency": [
            ///     buildLinear(_values[contaminationLevels[0]]! / sum),
            ///     buildLinear(_values[contaminationLevels[1]]! / sum),
            ///     buildLinear(_values[contaminationLevels[2]]! / sum)
            ///   ]
            /// };
            /// ```
            final row = {
              "Contamination": [
                Text(contaminationLevels[0].toString()),
                Text(contaminationLevels[1].toString()),
                Text(contaminationLevels[2].toString())
              ],
              "Hits": [
                Text(_values[contaminationLevels[0]].toString()),
                Text(_values[contaminationLevels[1]].toString()),
                Text(_values[contaminationLevels[2]].toString())
              ],
              "Frequency": [
                buildLinear(_values[contaminationLevels[0]]! / sum),
                buildLinear(_values[contaminationLevels[1]]! / sum),
                buildLinear(_values[contaminationLevels[2]]! / sum)
              ]
            };
            return buildDataWidget(context, snapshot, row);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
            return Container();
          }
        }
      },
    );
  }
}
