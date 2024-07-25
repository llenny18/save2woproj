import 'package:flutter/material.dart';
import 'package:save2woproj/components/table.dart';
import 'package:save2woproj/model/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';




class HistoryList extends StatefulWidget{

@override
State<HistoryList> createState() => StateHistoryList();
}

class StateHistoryList extends State<HistoryList>{
  Future<List<History>?>? history;
  int sum = 0;
  List<History> historyList = [];
  late Map<int, int> values;
  List<String> cages = [];
  final List<String> columns = [
    "Cage Number",
    "Number of Fish Kills",
    "Frequency"
  ];
  @override
  void initState() {
    super.initState();
    history = fetchFishKill();
    values ={};
  }

  Future<List<History>> fetchFishKill() async {
    // you can replace your api link with this link
    var uri = Uri.https('save2wo-api.vercel.app', '/history');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      historyList = jsonData.map((data) => History.fromJson(data)).toList();
      return historyList;
    } else {
      throw Exception("Object is null");
    }
  }

  int aggregateData(int value){
    int count = 0;
    for(var history in historyList){
      if(history.cage == value){
        count += history.deadFish;
        
      }
    }
    sum +=count;
    return count;
  }

 

  void setData() {
      if (historyList.isNotEmpty) {
        for (var data in historyList) {
          if (values.isEmpty) {
            values.addAll({data.cage: aggregateData(data.cage)});
            cages.add('Cage ${data.cage}');
          } else {
            if (!values.containsKey(data.cage)) {
              values.addAll({data.cage: aggregateData(data.cage)});
              cages.add('Cage ${data.cage}');
            }
          }
        }
        
        var sortedEntries = values.entries.toList()
          ..sort((a, b) => a.value.compareTo(b.value));
        
        values = Map.fromEntries(sortedEntries);
      }
    }
     Widget buildText(value)=> Text(
    value,
    style: TextStyle(
      color: Color(0xff2D3436)
    )
  );
Widget buildLinear(value) => LinearProgressIndicator(
        minHeight: 10,
        value: value,
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
      );
  Widget buildDataWidget(context,snapshot,rows)=> ListDataTable(columns: columns, rows: rows);
  @override
  Widget build(BuildContext context) {
   return FutureBuilder<List<History>?>(
      future: history,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.connectionState == ConnectionState.none) {
          return Container();
        } else {
          if (snapshot.hasData) {
            setData();
            final row = {
              columns[0] : [
                 buildText(cages[3].toString()),
                 buildText(cages[4].toString()),
                 buildText(cages[1].toString()),
                 buildText(cages[0].toString()),
                 buildText(cages[2].toString()),
              ],
              columns[1] : [
                buildText(values[3].toString()),
                 buildText(values[5].toString()),
                  buildText(values[1].toString()),
                   buildText(values[2].toString()),
                    buildText(values[4].toString()),
              ],
              columns[2] : [
                buildLinear(values[3]!/sum),
                buildLinear(values[5]!/sum),
                buildLinear(values[1]!/sum),
                buildLinear(values[2]!/sum),
                buildLinear(values[4]!/sum),
              ],
            };
            return buildDataWidget(context, snapshot,row);
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

