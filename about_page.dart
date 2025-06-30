import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        backgroundColor: Colors.pink.shade300,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('About This App', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text(
              'This app displays the live value of XRP (Ripple) in Malaysian Ringgit (MYR).\n\n'
                  'It fetches real-time data from an online API.\n\n'
                  'Developer:\n'
                  'NURSYAHIRAH BINTI LUDIN\n'
                  '2023371795\n'
                  'RCDCS2515A',
              style: TextStyle(fontSize: 18, height: 1.6),
            ),
          ],
        ),
      ),
    );
  }
}
