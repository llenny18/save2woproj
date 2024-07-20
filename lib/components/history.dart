import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:save2woproj/model/model.dart';



class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryTab> {
  List<bool> isSelected = [true, false, false, false, false, false];
  List<History> histories = []; // List to store fetched data
  int selectedCage = 0; // To track the selected cage number

  @override
  void initState() {
    super.initState();
    fetchHistory(); // Fetch data on initialization
  }

  Future<void> fetchHistory() async {
    final response = await http.get(Uri.parse('https://save2wo-api.vercel.app/history'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      setState(() {
        histories = jsonList.map((json) => History.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
  child: Padding(
    padding: EdgeInsets.all(20.0),
    child: Text(
      'History of Cage Records',
      style: TextStyle(
        color: Color(0xff034c57),
        fontFamily: 'Metropolis',
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),
toolbarHeight: 100,
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
                selectedCage = index; // Update selectedCage
              });
            },
            children: const <Widget>[
              Text('All', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Metropolis')),
              Text('Cage 1', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Metropolis')),
              Text('Cage 2', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Metropolis')),
              Text('Cage 3', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Metropolis')),
              Text('Cage 4', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Metropolis')),
              Text('Cage 5', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Metropolis')),
            ],
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: _buildCardList(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCardList() {
    List<History> filteredHistories = _filterHistories();
    return filteredHistories.map((history) {
      return _buildCard(
        _formatDate(history.timestamp),
        'Contamination: ${history.contamination}',
        'Cage No: ${history.cage}',
        _getStatus(history),
        _getIconColor(history),
        _getIcon(history),
      );
    }).toList();
  }

  List<History> _filterHistories() {
    if (selectedCage == 0) {
      return histories; // Show all
    } else {
      // Filter based on selected cage
      return histories.where((history) => history.cage == selectedCage).toList();
    }
  }

  String _formatDate(DateTime dateTime) {
    return DateFormat('MMMM d, yyyy').format(dateTime);
  }

  String _getStatus(History history) {
    // Customize the status based on your needs
    return history.contamination;
  }

  Color _getIconColor(History history) {
    // Customize the icon color based on contamination
    switch (history.contamination) {
      case 'Dissolved Oxygen Spike':
        return Colors.red;
      case 'pH Level Unstable':
        return Colors.orange;
      default:
        return Colors.green;
    }
  }

  IconData _getIcon(History history) {
    // Customize the icon based on contamination
    switch (history.contamination) {
      case 'Dissolved Oxygen Spike':
        return Icons.warning;
      case 'pH Level Unstable':
        return Icons.warning_amber_rounded;
      default:
        return Icons.check_circle;
    }
  }

  static Widget _buildCard(String date, String title, String cage, String status, Color iconColor, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      color: const Color(0xffd7f3fc),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              date,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Color(0xff034c57), fontFamily: 'Metropolis'),
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Icon(icon, color: iconColor, size: 40),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: iconColor,
                          fontFamily: 'Metropolis'
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(cage, style: const TextStyle(fontSize: 17, color: Colors.black, fontFamily: 'Metropolis')),
                      const SizedBox(height: 5),
                      Text('Cage Status: $status', style: const TextStyle(fontSize: 17, color: Colors.black, fontFamily: 'Metropolis')),
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