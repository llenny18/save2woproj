import 'package:flutter/material.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryTab> {
  List<bool> isSelected = [true, false, false, false, false];

  final List<Widget> cardList = [
    _buildCard('JULY 02', 'Threshold DO High at 8:30 AM', 'Cage No: 1', 'Dissolved Oxygen Spike', Colors.red, Icons.warning),
    _buildCard('JULY 02', 'Threshold Nitrate High at 8:30 AM', 'Cage No: 1', 'Dissolved Oxygen Spike', Colors.red, Icons.warning),
    _buildCard('JULY 09', 'Water Quality is Stable!', 'Cage No: 2', 'No Contamination Spikes', Colors.green, Icons.check_circle),
    _buildCard('JULY 01', 'pH Level is dropping', 'Cage No: 4', 'pH is unstable', Colors.orange, Icons.warning_amber_rounded),
    // Add more cards here as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History of Cage Records', style: TextStyle(color: Colors.black)),
        backgroundColor: const Color(0xffeaf4f7),
      ),
      backgroundColor: const Color(0xffeaf4f7),
      body: Column(
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
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: cardList,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildCard(String date, String title, String cage, String status, Color iconColor, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      color: const Color(0xffe0dcdc),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              date,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Icon(icon, color: iconColor, size: 40),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: iconColor,
                          
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(cage, style: TextStyle(fontSize: 14,  color: Colors.black)),
                      SizedBox(height: 5),
                      Text('Cage Status: $status', style: TextStyle(fontSize: 14,  color: Colors.black)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
