import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:save2woproj/data/contaminationcard.dart';
import 'package:save2woproj/data/model.dart';

class ContaminationTable extends StatefulWidget {
  @override
  _ContaminationTableState createState() => _ContaminationTableState();
}

class _ContaminationTableState extends State<ContaminationTable> {
  late Future<List<Contamination>> futureContaminationData;
  bool isCageAscending = true;
  bool isContaminationAscending = true;

  @override
  void initState() {
    super.initState();
    futureContaminationData = fetchContamination();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF5F5F5), // Slightly darker white background
      child: FutureBuilder<List<Contamination>>(
        future: futureContaminationData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Column(
              children: [
                Center(
                  child: const Text(
                    'Contamination Data Records',
                    style: TextStyle(
                      color: Color(0xff034c57),
                      fontFamily: 'Metropolis',
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isCageAscending = !isCageAscending;
                          snapshot.data!.sort((a, b) =>
                              isCageAscending ? a.cage.compareTo(b.cage) : b.cage.compareTo(a.cage));
                        });
                      },
                      child: Text('Sort by Cage'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isContaminationAscending = !isContaminationAscending;
                          snapshot.data!.sort((a, b) => isContaminationAscending
                              ? a.contamination.compareTo(b.contamination)
                              : b.contamination.compareTo(a.contamination));
                        });
                      },
                      child: Text('Sort by Contamination'),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: PaginatedDataTable(
                      header: const Text(''),
                      columns: [
                        DataColumn(
                          label: Container(
                            width: 50, // Adjust width accordingly
                            child: Text('Cage'),
                          ),
                        ),
                        DataColumn(
                          label: Container(
                            width: 200, // Adjust width accordingly
                            child: Text('Contamination'),
                          ),
                        ),
                        DataColumn(
                          label: Container(
                            width: 150, // Adjust width accordingly
                            child: Text('Timestamp'),
                          ),
                        ),
                        DataColumn(
                          label: Container(
                            width: 150, // Adjust width accordingly
                            child: Text('Water Quality - NO2'),
                          ),
                        ),
                        DataColumn(
                          label: Container(
                            width: 150, // Adjust width accordingly
                            child: Text('Water Quality - pH'),
                          ),
                        ),
                        DataColumn(
                          label: Container(
                            width: 150, // Adjust width accordingly
                            child: Text('Water Quality - Temperature'),
                          ),
                        ),
                        DataColumn(
                          label: Container(
                            width: 150, // Adjust width accordingly
                            child: Text('Water Quality - DO'),
                          ),
                        ),
                      ],
                      source: ContaminationDataSource(snapshot.data!),
                      rowsPerPage: 10,
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class ContaminationDataSource extends DataTableSource {
  final List<Contamination> contaminationData;

  ContaminationDataSource(this.contaminationData);

  @override
  DataRow getRow(int index) {
    final contamination = contaminationData[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(contamination.cage.toString())),
        DataCell(Text(contamination.contamination)),
        DataCell(Text(DateFormat('yyyy-MM-dd HH:mm:ss').format(contamination.timestamp))),
        DataCell(Text(contamination.waterQuality.no2.toString())),
        DataCell(Text(contamination.waterQuality.ph.toString())),
        DataCell(Text(contamination.waterQuality.temperature.toString())),
        DataCell(Text(contamination.waterQuality.do2.toString())),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => contaminationData.length;

  @override
  int get selectedRowCount => 0;
}
