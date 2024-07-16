import 'package:flutter/material.dart';
import 'package:save2woproj/main.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryTab> {
  List<bool> isSelected = [true, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History of Cage Records', style: TextStyle(color: Colors.black),),
        backgroundColor: const Color(0xffeaf4f7),
      ),
      backgroundColor: const Color(0xffeaf4f7),
      body: Row(
        children: [
          ToggleButtons(
            borderRadius: BorderRadius.circular(30.0),
            fillColor: const Color(0xff088294),
            selectedColor: Colors.white,
            color: Colors.grey,
            constraints: const BoxConstraints(
              minHeight: 40.0,
              minWidth: 70.0,
            ),
            isSelected: isSelected,
            onPressed: (int index) {
              setState(() {
                for (int i = 0; i < isSelected.length; i++) {
                  isSelected[i] = i == index;
                }
              });
            },
            children: const <Widget>[
              Text('All'),
              Text('Cage 1'),
              Text('Cage 2'),
              Text('Cage 3'),
              Text('Cage 4'),
            ],
          ),
        ],
      ),
    );
  }
}
