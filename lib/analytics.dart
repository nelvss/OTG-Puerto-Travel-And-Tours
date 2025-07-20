import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'admin_dashboard.dart'; // Import admin dashboard
import 'login_page.dart'; // Import login page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Booking System',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true, fontFamily: 'Inter'),
      initialRoute: '/analytics',
      routes: {
        '/analytics': (context) => AnalyticsPage(),
        '/admin': (context) => AdminDashboard(),
        '/login': (context) => LoginPage(),
      },
    );
  }
}

class AnalyticsData {
  final int totalSales;
  final int totalBookings;
  final List<BarChartGroupData> barGroups;
  final List<PieChartSectionData> pieSections;
  final List<PieChartSectionData> donutSections;
  final String feedbackSummary;

  AnalyticsData({
    required this.totalSales,
    required this.totalBookings,
    required this.barGroups,
    required this.pieSections,
    required this.donutSections,
    required this.feedbackSummary,
  });
}

class AnalyticsPage extends StatefulWidget {
  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  String selectedPeriod = '7 D';
  int selectedIndex = 1; // Analytics is selected by default

  // Demo data for each period
  final Map<String, AnalyticsData> analyticsDataByPeriod = {
    'Today': AnalyticsData(
      totalSales: 12000,
      totalBookings: 32,
      barGroups: [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(toY: 25, color: Colors.red[700]!, width: 30),
            BarChartRodData(toY: 7, color: Colors.red[500]!, width: 30),
          ],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(toY: 32, color: Colors.red[700]!, width: 30),
            BarChartRodData(toY: 4, color: Colors.red[500]!, width: 30),
          ],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(toY: 30, color: Colors.red[700]!, width: 30),
            BarChartRodData(toY: 38, color: Colors.red[500]!, width: 30),
            BarChartRodData(toY: 15, color: Colors.red[300]!, width: 30),
          ],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(toY: 32, color: Colors.red[700]!, width: 30),
            BarChartRodData(toY: 40, color: Colors.red[500]!, width: 30),
            BarChartRodData(toY: 42, color: Colors.red[300]!, width: 30),
          ],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(toY: 48, color: Colors.red[700]!, width: 30),
            BarChartRodData(toY: 50, color: Colors.red[500]!, width: 30),
            BarChartRodData(toY: 21, color: Colors.red[300]!, width: 30),
          ],
        ),
      ],
      pieSections: [
        PieChartSectionData(value: 10, color: Colors.red[700]!, radius: 50),
        PieChartSectionData(value: 15, color: Colors.red[500]!, radius: 50),
        PieChartSectionData(value: 7, color: Colors.red[300]!, radius: 50),
      ],
      donutSections: [
        PieChartSectionData(value: 12, color: Colors.red[700]!, radius: 40),
        PieChartSectionData(value: 10, color: Colors.red[500]!, radius: 40),
        PieChartSectionData(value: 10, color: Colors.red[300]!, radius: 40),
      ],
      feedbackSummary:
          'Fresh from Puerto Galera 😌 Huge thank you to Otg for helping us with our 3-day trip. Super accommodating and considerate. Will surely recommend them for your travel to Puerto Galera 😊😊',
    ),
    'Yesterday': AnalyticsData(
      totalSales: 15000,
      totalBookings: 40,
      barGroups: [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(toY: 30, color: Colors.red[700]!, width: 30),
            BarChartRodData(toY: 10, color: Colors.red[500]!, width: 30),
          ],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(toY: 35, color: Colors.red[700]!, width: 30),
            BarChartRodData(toY: 8, color: Colors.red[500]!, width: 30),
          ],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(toY: 33, color: Colors.red[700]!, width: 30),
            BarChartRodData(toY: 40, color: Colors.red[500]!, width: 30),
            BarChartRodData(toY: 18, color: Colors.red[300]!, width: 30),
          ],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(toY: 36, color: Colors.red[700]!, width: 30),
            BarChartRodData(toY: 44, color: Colors.red[500]!, width: 30),
            BarChartRodData(toY: 45, color: Colors.red[300]!, width: 30),
          ],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(toY: 50, color: Colors.red[700]!, width: 30),
            BarChartRodData(toY: 55, color: Colors.red[500]!, width: 30),
            BarChartRodData(toY: 25, color: Colors.red[300]!, width: 30),
          ],
        ),
      ],
      pieSections: [
        PieChartSectionData(value: 12, color: Colors.red[700]!, radius: 50),
        PieChartSectionData(value: 10, color: Colors.red[500]!, radius: 50),
        PieChartSectionData(value: 18, color: Colors.red[300]!, radius: 50),
      ],
      donutSections: [
        PieChartSectionData(value: 14, color: Colors.red[700]!, radius: 40),
        PieChartSectionData(value: 13, color: Colors.red[500]!, radius: 40),
        PieChartSectionData(value: 13, color: Colors.red[300]!, radius: 40),
      ],
      feedbackSummary:
          'What we paid for here was super worth it 😭 It was so much fun and their customer service is really amazing. Everything you need, they will provide. And they are really kind too ❤️ This is the place for you guys. 👌 Thank you so much Maam Camille and OTG ❤️🥰',
    ),
    '7 D': AnalyticsData(
      totalSales: 120000,
      totalBookings: 320,
      barGroups: [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(toY: 250, color: Colors.red[700]!, width: 30),
            BarChartRodData(toY: 70, color: Colors.red[500]!, width: 30),
          ],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(toY: 320, color: Colors.red[700]!, width: 30),
            BarChartRodData(toY: 40, color: Colors.red[500]!, width: 30),
          ],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(toY: 300, color: Colors.red[700]!, width: 30),
            BarChartRodData(toY: 380, color: Colors.red[500]!, width: 30),
            BarChartRodData(toY: 150, color: Colors.red[300]!, width: 30),
          ],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(toY: 320, color: Colors.red[700]!, width: 30),
            BarChartRodData(toY: 400, color: Colors.red[500]!, width: 30),
            BarChartRodData(toY: 420, color: Colors.red[300]!, width: 30),
          ],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(toY: 480, color: Colors.red[700]!, width: 30),
            BarChartRodData(toY: 500, color: Colors.red[500]!, width: 30),
            BarChartRodData(toY: 210, color: Colors.red[300]!, width: 30),
          ],
        ),
      ],
      pieSections: [
        PieChartSectionData(value: 35, color: Colors.red[700]!, radius: 50),
        PieChartSectionData(value: 25, color: Colors.red[500]!, radius: 50),
        PieChartSectionData(value: 40, color: Colors.red[300]!, radius: 50),
      ],
      donutSections: [
        PieChartSectionData(value: 40, color: Colors.red[700]!, radius: 40),
        PieChartSectionData(value: 30, color: Colors.red[500]!, radius: 40),
        PieChartSectionData(value: 30, color: Colors.red[300]!, radius: 40),
      ],
      feedbackSummary:
          'Thank you so much OTG Travel and Tours 💜🍀 for making our first fam trip smooth and enjoyable!',
    ),
    '30 D': AnalyticsData(
      totalSales: 480000,
      totalBookings: 1200,
      barGroups: [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(toY: 900, color: Colors.red[700]!, width: 30),
            BarChartRodData(toY: 300, color: Colors.red[500]!, width: 30),
          ],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(toY: 1000, color: Colors.red[700]!, width: 30),
            BarChartRodData(toY: 200, color: Colors.red[500]!, width: 30),
          ],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(toY: 800, color: Colors.red[700]!, width: 30),
            BarChartRodData(toY: 1200, color: Colors.red[500]!, width: 30),
            BarChartRodData(toY: 500, color: Colors.red[300]!, width: 30),
          ],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(toY: 1100, color: Colors.red[700]!, width: 30),
            BarChartRodData(toY: 900, color: Colors.red[500]!, width: 30),
            BarChartRodData(toY: 800, color: Colors.red[300]!, width: 30),
          ],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(toY: 1200, color: Colors.red[700]!, width: 30),
            BarChartRodData(toY: 1000, color: Colors.red[500]!, width: 30),
            BarChartRodData(toY: 700, color: Colors.red[300]!, width: 30),
          ],
        ),
      ],
      pieSections: [
        PieChartSectionData(value: 120, color: Colors.red[700]!, radius: 50),
        PieChartSectionData(value: 80, color: Colors.red[500]!, radius: 50),
        PieChartSectionData(value: 100, color: Colors.red[300]!, radius: 50),
      ],
      donutSections: [
        PieChartSectionData(value: 140, color: Colors.red[700]!, radius: 40),
        PieChartSectionData(value: 120, color: Colors.red[500]!, radius: 40),
        PieChartSectionData(value: 120, color: Colors.red[300]!, radius: 40),
      ],
      feedbackSummary:
          'Super accommodating ng mga staff nila. They will really help you with your travel plans. Thank you so much OTG Travel and Tours for making our trip to Puerto Galera a memorable one! Highly recommended! 💯',
    ),
    '3 M': AnalyticsData(
      totalSales: 1200000,
      totalBookings: 3200,
      barGroups: [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(toY: 900, color: Colors.red[700]!, width: 30),
            BarChartRodData(toY: 700, color: Colors.red[500]!, width: 30),
          ],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(toY: 1200, color: Colors.red[700]!, width: 30),
            BarChartRodData(toY: 800, color: Colors.red[500]!, width: 30),
          ],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(toY: 1300, color: Colors.red[700]!, width: 30),
            BarChartRodData(toY: 1380, color: Colors.red[500]!, width: 30),
            BarChartRodData(toY: 1150, color: Colors.red[300]!, width: 30),
          ],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(toY: 1320, color: Colors.red[700]!, width: 30),
            BarChartRodData(toY: 1400, color: Colors.red[500]!, width: 30),
            BarChartRodData(toY: 1420, color: Colors.red[300]!, width: 30),
          ],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(toY: 1480, color: Colors.red[700]!, width: 30),
            BarChartRodData(toY: 1500, color: Colors.red[500]!, width: 30),
            BarChartRodData(toY: 1210, color: Colors.red[300]!, width: 30),
          ],
        ),
      ],
      pieSections: [
        PieChartSectionData(value: 350, color: Colors.red[700]!, radius: 50),
        PieChartSectionData(value: 250, color: Colors.red[500]!, radius: 50),
        PieChartSectionData(value: 400, color: Colors.red[300]!, radius: 50),
      ],
      donutSections: [
        PieChartSectionData(value: 400, color: Colors.red[700]!, radius: 40),
        PieChartSectionData(value: 300, color: Colors.red[500]!, radius: 40),
        PieChartSectionData(value: 300, color: Colors.red[300]!, radius: 40),
      ],
      feedbackSummary:
          'Grabe yung vacation sa Puerto Galera. Super worth it ng trip namin. Thank you OTG Travel and Tours for the amazing experience! Highly recommended for your travel needs.',
    ),
    '6 M': AnalyticsData(
      totalSales: 2200000,
      totalBookings: 6200,
      barGroups: [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(toY: 1900, color: Colors.red[700]!, width: 30),
            BarChartRodData(toY: 1700, color: Colors.red[500]!, width: 30),
          ],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(toY: 2200, color: Colors.red[700]!, width: 30),
            BarChartRodData(toY: 1800, color: Colors.red[500]!, width: 30),
          ],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(toY: 2300, color: Colors.red[700]!, width: 30),
            BarChartRodData(toY: 2380, color: Colors.red[500]!, width: 30),
            BarChartRodData(toY: 2150, color: Colors.red[300]!, width: 30),
          ],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(toY: 2320, color: Colors.red[700]!, width: 30),
            BarChartRodData(toY: 2400, color: Colors.red[500]!, width: 30),
            BarChartRodData(toY: 2420, color: Colors.red[300]!, width: 30),
          ],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(toY: 2480, color: Colors.red[700]!, width: 30),
            BarChartRodData(toY: 2500, color: Colors.red[500]!, width: 30),
            BarChartRodData(toY: 2210, color: Colors.red[300]!, width: 30),
          ],
        ),
      ],
      pieSections: [
        PieChartSectionData(value: 650, color: Colors.red[700]!, radius: 50),
        PieChartSectionData(value: 550, color: Colors.red[500]!, radius: 50),
        PieChartSectionData(value: 800, color: Colors.red[300]!, radius: 50),
      ],
      donutSections: [
        PieChartSectionData(value: 800, color: Colors.red[700]!, radius: 40),
        PieChartSectionData(value: 600, color: Colors.red[500]!, radius: 40),
        PieChartSectionData(value: 600, color: Colors.red[300]!, radius: 40),
      ],
      feedbackSummary:
          'back to Puerto Galera with OTG Travel and Tours! They made our trip unforgettable. Highly recommend their services for a hassle-free vacation.',
    ),
    '12 M': AnalyticsData(
      totalSales: 4200000,
      totalBookings: 12200,
      barGroups: [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(toY: 3900, color: Colors.red[700]!, width: 30),
            BarChartRodData(toY: 3700, color: Colors.red[500]!, width: 30),
          ],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(toY: 4200, color: Colors.red[700]!, width: 30),
            BarChartRodData(toY: 3800, color: Colors.red[500]!, width: 30),
          ],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(toY: 4300, color: Colors.red[700]!, width: 30),
            BarChartRodData(toY: 4380, color: Colors.red[500]!, width: 30),
            BarChartRodData(toY: 4150, color: Colors.red[300]!, width: 30),
          ],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(toY: 4320, color: Colors.red[700]!, width: 30),
            BarChartRodData(toY: 4400, color: Colors.red[500]!, width: 30),
            BarChartRodData(toY: 4420, color: Colors.red[300]!, width: 30),
          ],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(toY: 4480, color: Colors.red[700]!, width: 30),
            BarChartRodData(toY: 4500, color: Colors.red[500]!, width: 30),
            BarChartRodData(toY: 4210, color: Colors.red[300]!, width: 30),
          ],
        ),
      ],
      pieSections: [
        PieChartSectionData(value: 1350, color: Colors.red[700]!, radius: 50),
        PieChartSectionData(value: 1250, color: Colors.red[500]!, radius: 50),
        PieChartSectionData(value: 1400, color: Colors.red[300]!, radius: 50),
      ],
      donutSections: [
        PieChartSectionData(value: 1400, color: Colors.red[700]!, radius: 40),
        PieChartSectionData(value: 1300, color: Colors.red[500]!, radius: 40),
        PieChartSectionData(value: 1300, color: Colors.red[300]!, radius: 40),
      ],
      feedbackSummary:
          'OTG Travel and Tours made our trip more memorable! Highly recommend their services for a hassle-free vacation.',
    ),
  };

  AnalyticsData get currentData =>
      analyticsDataByPeriod[selectedPeriod] ?? analyticsDataByPeriod['7 D']!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      drawer: Drawer(
        child: Column(
          children: [
            // Logo/Header
            Container(
              padding: EdgeInsets.all(24),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.travel_explore,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Travel Admin',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            // Navigation Items
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildSidebarItem(0, Icons.dashboard, 'Dashboard'),
                  _buildSidebarItem(1, Icons.analytics, 'Analytics'),
                  SizedBox(height: 24),
                  Divider(color: Colors.grey[300]),
                  SizedBox(height: 16),
                  _buildSidebarItem(2, Icons.logout, 'Logout'),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Custom AppBar
          Container(
            height: 70,
            padding: EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Burger icon for Drawer
                Builder(
                  builder: (context) => IconButton(
                    icon: Icon(Icons.menu, color: Colors.grey),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
                Text(
                  'Analytics Dashboard',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildPeriodSelector(),
              ],
            ),
          ),
          // Dashboard Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(child: _buildTotalSalesCard()),
                            SizedBox(width: 16),
                            Expanded(child: _buildTotalBookingsCard()),
                          ],
                        ),
                        SizedBox(height: 16),
                        Expanded(child: _buildStatisticsCard()),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        _buildPieChart(),
                        SizedBox(height: 16),
                        _buildDonutChart(),
                        SizedBox(height: 16),
                        _buildFeedbackSummaryCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(int index, IconData icon, String title) {
    bool isSelected = selectedIndex == index;
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? Colors.orange : Colors.grey[600],
          size: 22,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.orange : Colors.grey[700],
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 15,
          ),
        ),
        selected: isSelected,
        selectedTileColor: Colors.orange.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onTap: () {
          setState(() {
            selectedIndex = index;
          });

          // Navigate to dashboard when Dashboard is clicked
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AdminDashboard()),
            );
          }

          // Handle logout
          if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          }
        },
      ),
    );
  }

  Widget _buildPeriodSelector() {
    List<String> periods = [
      'Today',
      'Yesterday',
      '7 D',
      '30 D',
      '3 M',
      '6 M',
      '12 M',
    ];

    return Container(
      child: Row(
        children: periods
            .map(
              (period) => GestureDetector(
                onTap: () => setState(() => selectedPeriod = period),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  margin: EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                    color: selectedPeriod == period
                        ? Colors.grey[800]
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    period,
                    style: TextStyle(
                      color: selectedPeriod == period
                          ? Colors.white
                          : Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildStatisticsCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Statistics',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'View all',
                  style: TextStyle(color: Colors.blue, fontSize: 14),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY:
                      currentData.barGroups
                          .map(
                            (g) => g.barRods
                                .map((r) => r.toY)
                                .reduce((a, b) => a > b ? a : b),
                          )
                          .reduce((a, b) => a > b ? a : b) +
                      20,
                  barGroups: currentData.barGroups,
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          List<String> categories = [
                            'Category 1',
                            'Category 2',
                            'Category 3',
                            'Category 4',
                            'Category 5',
                          ];
                          if (value.toInt() >= 0 &&
                              value.toInt() < categories.length) {
                            return Text(
                              categories[value.toInt()],
                              style: TextStyle(fontSize: 12),
                            );
                          }
                          return Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 100,
                        getTitlesWidget: (value, meta) => Text(
                          '${value.toInt()}',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: unused_element
  List<BarChartGroupData> _buildBarGroups() {
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(toY: 250, color: Colors.grey[600]!, width: 30),
          BarChartRodData(toY: 70, color: Colors.grey[400]!, width: 30),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(toY: 320, color: Colors.grey[600]!, width: 30),
          BarChartRodData(toY: 40, color: Colors.grey[400]!, width: 30),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(toY: 300, color: Colors.grey[600]!, width: 30),
          BarChartRodData(toY: 380, color: Colors.grey[400]!, width: 30),
          BarChartRodData(toY: 150, color: Colors.grey[300]!, width: 30),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(toY: 320, color: Colors.grey[600]!, width: 30),
          BarChartRodData(toY: 400, color: Colors.grey[400]!, width: 30),
          BarChartRodData(toY: 420, color: Colors.grey[300]!, width: 30),
        ],
      ),
      BarChartGroupData(
        x: 4,
        barRods: [
          BarChartRodData(toY: 480, color: Colors.grey[600]!, width: 30),
          BarChartRodData(toY: 500, color: Colors.grey[400]!, width: 30),
          BarChartRodData(toY: 210, color: Colors.grey[300]!, width: 30),
        ],
      ),
    ];
  }

  Widget _buildPieChart() {
    return Card(
      elevation: 2,
      child: Container(
        height: 200,
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: currentData.pieSections,
                  centerSpaceRadius: 0,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLegendItem('Label 1', Colors.grey[700]!),
                _buildLegendItem('Label 2', Colors.grey[500]!),
                _buildLegendItem('Label 3', Colors.grey[300]!),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDonutChart() {
    return Card(
      elevation: 2,
      child: Container(
        height: 200,
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: currentData.donutSections,
                  centerSpaceRadius: 30,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLegendItem('Segment A', Colors.grey[700]!),
                _buildLegendItem('Segment B', Colors.grey[500]!),
                _buildLegendItem('Segment C', Colors.grey[300]!),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: 8),
          Text(label, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  // Card for Total Sales
  Widget _buildTotalSalesCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Sales',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '₱ ${currentData.totalSales.toString()}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Card for Total Bookings
  Widget _buildTotalBookingsCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Bookings',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '${currentData.totalBookings}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Card for Feedback Summary
  Widget _buildFeedbackSummaryCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Feedback Summary',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              currentData.feedbackSummary,
              style: TextStyle(fontSize: 14, color: Colors.grey[800]),
            ),
          ],
        ),
      ),
    );
  }
}
