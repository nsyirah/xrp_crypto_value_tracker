import 'package:flutter/material.dart';
import 'services/api_services.dart';
import 'about_page.dart';
import 'package:intl/intl.dart';

void main() => runApp(XRPApp());

class XRPApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XRP Crypto Value Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Color(0xFFFDECEF),
        fontFamily: 'Poppins',
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 18, color: Colors.pink.shade900),
          titleLarge: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.pink.shade800),
          titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.pink.shade900),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.pink.shade300,
          titleTextStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 6,
          shadowColor: Colors.pink.shade200,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink.shade400,
            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            elevation: 6,
            shadowColor: Colors.pink.shade200,
          ),
        ),
      ),
      home: XRPHomePage(),
    );
  }
}

class XRPHomePage extends StatefulWidget {
  @override
  _XRPHomePageState createState() => _XRPHomePageState();
}

class _XRPHomePageState extends State<XRPHomePage> {
  late Future<double?> xrpValue;
  double? previousValue;
  DateTime? lastUpdated;

  @override
  void initState() {
    super.initState();
    fetchValue();
  }

  void fetchValue() {
    setState(() {
      xrpValue = ApiService.fetchXRPValue().then((value) {
        if (value != null) {
          previousValue = previousValue ?? value;
          lastUpdated = DateTime.now();
        }
        return value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('dd MMM yyyy, hh:mm a');

    return Scaffold(
      appBar: AppBar(
        title: Text('Live XRP Price (MYR)'),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            tooltip: 'About',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AboutPage()),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.pink.shade50,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink.shade200.withOpacity(0.6),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      )
                    ],
                  ),
                  padding: EdgeInsets.all(24),
                  child: Icon(
                    Icons.currency_exchange,
                    size: 90,
                    color: Colors.pink.shade600,
                  ),
                ),
                SizedBox(height: 16),
                Text('XRP TO MYR', style: theme.textTheme.titleLarge),
                SizedBox(height: 32),
                FutureBuilder<double?>(
                  future: xrpValue,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(
                        color: Colors.pink.shade400,
                        strokeWidth: 4,
                      );
                    } else if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
                      return Text(
                        'Error fetching data',
                        style: TextStyle(fontSize: 18, color: Colors.red.shade600),
                      );
                    } else {
                      double current = snapshot.data!;
                      double? diff;
                      double? diffPercent;
                      if (previousValue != null) {
                        diff = current - previousValue!;
                        diffPercent = (diff / previousValue!) * 100;
                      }

                      double boxWidth = MediaQuery.of(context).size.width * 0.85;

                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _infoBox(
                                width: boxWidth / 2 - 12,
                                title: 'Current Price',
                                value: 'MYR ${current.toStringAsFixed(2)}',
                                theme: theme,
                                showIcon: false,
                              ),
                              SizedBox(width: 24),
                              _infoBox(
                                width: boxWidth / 2 - 12,
                                title: 'Last Price',
                                value: previousValue != null
                                    ? 'MYR ${previousValue!.toStringAsFixed(2)}'
                                    : '-',
                                theme: theme,
                                showIcon: false,
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          if (diff != null)
                            _infoBox(
                              width: boxWidth,
                              title: 'Price Change',
                              value: '${diff >= 0 ? '+' : ''}${diff.toStringAsFixed(2)} MYR (${diffPercent!.toStringAsFixed(2)}%)',
                              icon: diff >= 0 ? Icons.arrow_upward : Icons.arrow_downward,
                              iconColor: diff >= 0 ? Colors.green : Colors.red,
                              theme: theme,
                            ),
                          SizedBox(height: 24),
                          if (lastUpdated != null)
                            _infoBox(
                              width: boxWidth,
                              title: 'Last Updated',
                              value: dateFormat.format(lastUpdated!),
                              icon: Icons.access_time,
                              iconColor: Colors.pink.shade600,
                              theme: theme,
                            ),
                        ],
                      );
                    }
                  },
                ),
                SizedBox(height: 40),
                ElevatedButton.icon(
                  onPressed: fetchValue,
                  icon: Icon(Icons.refresh),
                  label: Text("Refresh Price"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoBox({
    required double width,
    required String title,
    required String value,
    IconData? icon,
    Color? iconColor,
    required ThemeData theme,
    bool showIcon = true,
  }) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.pink.shade50,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.shade200.withOpacity(0.5),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.pink.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (showIcon && icon != null) ...[
                Icon(icon, color: iconColor, size: 26),
                SizedBox(width: 8),
              ],
              Text(
                title,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.pink.shade700,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            value,
            style: theme.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}