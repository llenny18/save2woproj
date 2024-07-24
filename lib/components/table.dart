import 'package:flutter/material.dart';



/// A widget that displays tabular data in a list format.
class ListDataTable extends StatefulWidget {
  final List<String> columns;
  final Map<String, List<Widget>> rows;

  /// Creates a [ListDataTable] widget.
  ///
  /// The [columns] parameter is a list of column names for the table.
  /// The [rows] parameter is a map where the keys are the row names and the values are lists of widgets representing the row data.
  const ListDataTable({
    super.key,
    required this.columns,
    required this.rows,
  });

  @override
  State<ListDataTable> createState() => StateListDataTable();
}
/// A stateful widget that displays a data table with the given columns and rows.
class StateListDataTable extends State<ListDataTable> {
  @override
  Widget build(BuildContext context) {
    final columns = widget.columns;
    final rows = widget.rows;
    return LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth),
                child: DataTable(
                  columnSpacing: 20.0,
                  columns: List<DataColumn>.generate(
                      columns.length,
                      (index) => DataColumn(
                              label: Text(
                            columns[index],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ))),
                  rows: List<DataRow>.generate(
                    rows[columns[0]]!.length,
                    (index) => DataRow(
                      cells: List<DataCell>.generate(
                        /// Hi, maybe you are wondering...
                        /// How tf does this work?!
                        /// 
                        /// So this is the explaination:
                        /*
                          So above we have two List<dynamic> generators,
                          first is the [List<DataRow>.generate] which is basically the row of the table,
                          it will generate based on the length of [rows].
                          So if we only have two items in [row] it will only iterate twice.

                          then inside of the [List<DataRow>.generate],
                          we have another generator for [DataCell].
                          So maybe you are wondering how did the datacell got its data.

                          The [rows] is a [Map] so there are keys and their value
                          How it was indexed is by getting the value based on Columns[_index] returning the string of the column name.
                          Then, that same column name is used as a key to index the [rows] returning a
                          List of widget.

                          That List of widget was indexed by getting the [index] of the DataRow which can be found above not below. above nga eh tas hahanapin mo sa baba
                          hence returning a widget that is now inside of [DataCell]

                          Please refer to the example after this Class
                         */
                        columns.length,
                        (_index)=> DataCell(rows[columns[_index]]![index])
                    ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
  }
}


/*

```dart
final col = [
  "Contamination",
  "Hits",
  "Frequency"
];

final row = {
  "Contamination" : [
    Text("DO Spike"),
    Text("pH Level Unstable"),
    Text("DO LOW")
  ],
  "Hits" : [
    Text("1"),
    Text("2"),
    Text("3")
    ],
   "Frequency" : [
    LinearProgressIndicator(minHeight:  5,
        value: 0.17,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
        ),
        LinearProgressIndicator(minHeight:  5,
        value: 0.33,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
        ),
        LinearProgressIndicator(minHeight:  5,
        value: 0.5,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
        ),
   ]
};
```


```dart
class DevMode extends StatelessWidget {
  const DevMode({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, 
    home: Scaffold (
      body: ListDataTable(columns: col, rows: row)
    )
    );
  }
}
```
*/
