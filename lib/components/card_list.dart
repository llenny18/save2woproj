import 'package:flutter/material.dart';

class CardList extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      body: 
      
      ListView(
        
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          _buildCard('JULY 02', 'Threshold DO High at 8:30 AM', 'Cage No: 1', 'Dissolved Oxygen Spike', Colors.red, Icons.warning),
          _buildCard('JULY 02', 'Threshold Nitrate High at 8:30 AM', 'Cage No: 1', 'Dissolved Oxygen Spike', Colors.red, Icons.warning),
          _buildCard('JULY 09', 'Water Quality is Stable!', 'Cage No: 2', 'No Contamination Spikes', Colors.green, Icons.check_circle),
          _buildCard('JULY 01', 'pH Level is dropping', 'Cage No: 4', 'pH is unstable', Colors.orange, Icons.warning_amber_rounded),
          // Add more cards here as needed
        ],
      ),
    );
  }

  Widget _buildCard(String date, String title, String cage, String status, Color iconColor, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              date,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      Text(cage, style: TextStyle(fontSize: 14)),
                      SizedBox(height: 5),
                      Text('Cage Status: $status', style: TextStyle(fontSize: 14)),
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
