import 'package:flutter/material.dart';
import 'package:booking_system2/login_page.dart';
import 'analytics.dart'; // Import analytics page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Inter'),
      home: AdminDashboard(), // Use the dashboard as the home screen
    );
  }
}

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;

  // Add search controller and state
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isSearching = false;

  // Add form controllers for new booking
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _servicesController = TextEditingController();
  final TextEditingController _rentalController = TextEditingController();
  final TextEditingController _arrivalDateController = TextEditingController();
  final TextEditingController _departureDateController =
      TextEditingController();
  final TextEditingController _hotelController = TextEditingController();
  final TextEditingController _noOfPaxController = TextEditingController();
  final TextEditingController _totalPriceController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Remove _isSidebarVisible

  List<BookingData> bookings = [
    BookingData(
      name: "Elizabeth Lopez",
      Services: "Hotel Booking, Car Rental",
      Rental: "Car Rental",
      ArrivalDate: "2023-10-01",
      DepartureDate: "2023-10-05",
      Hotel: "Grand Hotel",
      noOfPax: 2,
      TotalPrice: "\3000",
      ContactNumber: "099-456-7890",
      email: "elopez@yahoo.com",
      status: BookingStatus.pending,
    ),
    BookingData(
      name: "Matthew Martinez",
      Services: "Snorkeling Tour",
      Rental: "None",
      ArrivalDate: "2023-11-01",
      DepartureDate: "2023-11-05",
      Hotel: "Ilaya",
      noOfPax: 3,
      TotalPrice: "\2500",
      ContactNumber: "099-123-4567",
      email: "mmartinez1997@gmail.com",
      status: BookingStatus.pending,
    ),
    BookingData(
      name: "Elizabeth Hall",
      Services: "Island Tour, Car Rental",
      Rental: "Car Rental",
      ArrivalDate: "2023-12-10",
      DepartureDate: "2023-12-15",
      Hotel: "None",
      noOfPax: 4,
      TotalPrice: "\1500",
      ContactNumber: "099-234-5678",
      email: "elizabeth_hall_1998@gmail.com",
      status: BookingStatus.pending,
    ),
    BookingData(
      name: "Maria White",
      Services: "Hotel Booking, Inland Tour",
      Rental: "None",
      ArrivalDate: "2023-09-20",
      DepartureDate: "2023-09-25",
      Hotel: "Infinity Hotel",
      noOfPax: 5,
      TotalPrice: "\4000",
      ContactNumber: "099-345-6789",
      email: "maria_white@hotmail.com",
      status: BookingStatus.pending,
    ),
    BookingData(
      name: "Elizabeth Watson",
      Services: "Hotel Booking, Car Rental",
      Rental: "Car Rental",
      ArrivalDate: "2023-08-05",
      DepartureDate: "2023-08-10",
      Hotel: "Ilaya",
      noOfPax: 6,
      TotalPrice: "\2500",
      ContactNumber: "099-456-7890",
      email: "ewatson@yahoo.com",
      status: BookingStatus.pending,
    ),
    BookingData(
      name: "Elizabeth Allen",
      Services: "Hotel Booking",
      Rental: "None",
      ArrivalDate: "2023-07-15",
      DepartureDate: "2023-07-20",
      Hotel: "Grand Hotel",
      noOfPax: 7,
      TotalPrice: "\2000",
      ContactNumber: "099-567-8901",
      email: "eallen@gmail.com",
      status: BookingStatus.pending,
    ),
    BookingData(
      name: "Caleb Jones",
      Services: "Car Rental",
      Rental: "Car Rental",
      ArrivalDate: "2023-06-10",
      DepartureDate: "2023-06-15",
      Hotel: "None",
      noOfPax: 8,
      TotalPrice: "\1500",
      ContactNumber: "099-678-9012",
      email: "calebjones@gmail.com",
      status: BookingStatus.pending,
    ),
  ];

  // Add filtered bookings getter
  List<BookingData> get filteredBookings {
    if (_searchQuery.isEmpty) return bookings;
    return bookings
        .where((b) => b.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  int get totalBookings => bookings.length;
  int get pendingBookings =>
      bookings.where((b) => b.status == BookingStatus.pending).length;
  int get confirmedBookings =>
      bookings.where((b) => b.status == BookingStatus.confirmed).length;
  int get cancelledBookings =>
      bookings.where((b) => b.status == BookingStatus.cancelled).length;

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
          // AppBar
          Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
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
                  if (_isSearching)
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'Search by name...',
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                      ),
                    )
                  else
                    Text(
                      _getPageTitle(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  Spacer(),
                  if (_isSearching)
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.grey),
                      onPressed: () {
                        setState(() {
                          _isSearching = false;
                          _searchQuery = '';
                          _searchController.clear();
                        });
                      },
                    )
                  else
                    IconButton(
                      icon: Icon(Icons.search, color: Colors.grey),
                      onPressed: () {
                        setState(() {
                          _isSearching = true;
                        });
                      },
                    ),
                  IconButton(
                    icon: Icon(
                      Icons.notifications_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.help_outline, color: Colors.grey),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),

          // Page Content
          Expanded(child: _buildPageContent()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddBookingDialog,
        backgroundColor: Colors.orange,
        child: Icon(Icons.add, color: Colors.white),
        tooltip: 'Add New Booking',
      ),
    );
  }

  Widget _buildSidebarItem(int index, IconData icon, String title) {
    bool isSelected = _selectedIndex == index;

    return Container(
      margin: EdgeInsets.only(bottom: 4),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? Colors.orange : Colors.grey[600],
          size: 20,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.orange : Colors.grey[700],
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        selected: isSelected,
        selectedTileColor: Colors.orange.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });

          // Navigate to analytics page when Analytics is clicked
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AnalyticsPage()),
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

  String _getPageTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'Dashboard';
      case 1:
        return 'Analytics';
      default:
        return 'Dashboard';
    }
  }

  Widget _buildPageContent() {
    switch (_selectedIndex) {
      case 0:
      case 1:
        return _buildDashboardContent();
      default:
        return Center(
          child: Text(
            'Coming Soon...',
            style: TextStyle(fontSize: 24, color: Colors.grey[600]),
          ),
        );
    }
  }

  Widget _buildDashboardContent() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Add New Booking button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Booking Management',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              ElevatedButton.icon(
                onPressed: _showAddBookingDialog,
                icon: Icon(Icons.add, color: Colors.white),
                label: Text(
                  'Add New Booking',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          // Statistics Cards
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  totalBookings.toString(),
                  'Total Bookings',
                  Colors.blue[50]!,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  pendingBookings.toString(),
                  'Pending Bookings',
                  Colors.orange[50]!,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  confirmedBookings.toString(),
                  'Confirmed Booking',
                  Colors.green[50]!,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  cancelledBookings.toString(),
                  'Cancelled Booking',
                  Colors.red[50]!,
                ),
              ),
            ],
          ),
          SizedBox(height: 32),
          // Bookings Table
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Table Header + Rows in one Table
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Table(
                        columnWidths: const <int, TableColumnWidth>{
                          0: FlexColumnWidth(1), // NAME
                          1: FlexColumnWidth(1), // Services
                          2: FlexColumnWidth(1), // Rental
                          3: FlexColumnWidth(1), // Arrival Date
                          4: FlexColumnWidth(1), // Departure Date
                          5: FlexColumnWidth(1), // Hotel
                          6: FlexColumnWidth(1), // No. of Pax
                          7: FlexColumnWidth(1), // Total Price
                          8: FlexColumnWidth(1), // Contact Number
                          9: FlexColumnWidth(2), // EMAIL (wider)
                          10: FlexColumnWidth(2), // ACTION (wider)
                        },
                        border: TableBorder(
                          horizontalInside: BorderSide(
                            color: Colors.grey[200]!,
                          ),
                        ),
                        children: [
                          TableRow(
                            decoration: BoxDecoration(color: Colors.grey[50]),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('NAME', style: _headerStyle()),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Services', style: _headerStyle()),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Rental', style: _headerStyle()),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Arrival Date',
                                  style: _headerStyle(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Departure Date',
                                  style: _headerStyle(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Hotel', style: _headerStyle()),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'No. of Pax',
                                  style: _headerStyle(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Total Price',
                                  style: _headerStyle(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Contact Number',
                                  style: _headerStyle(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('EMAIL', style: _headerStyle()),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('ACTION', style: _headerStyle()),
                              ),
                            ],
                          ),
                          ...filteredBookings.map((booking) {
                            return TableRow(
                              decoration: BoxDecoration(color: Colors.white),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 8,
                                  ),
                                  child: Text(
                                    booking.name,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 8,
                                  ),
                                  child: Text(
                                    booking.Services,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 8,
                                  ),
                                  child: Text(
                                    booking.Rental,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 8,
                                  ),
                                  child: Text(
                                    booking.ArrivalDate,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 8,
                                  ),
                                  child: Text(
                                    booking.DepartureDate,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 8,
                                  ),
                                  child: Text(
                                    booking.Hotel,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 8,
                                  ),
                                  child: Text(
                                    booking.noOfPax.toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 8,
                                  ),
                                  child: Text(
                                    booking.TotalPrice,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 8,
                                  ),
                                  child: Text(
                                    booking.ContactNumber,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 8,
                                  ),
                                  child: Text(
                                    booking.email,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      // Add pencil icon for adding new booking
                                      IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                          size: 20,
                                        ),
                                        onPressed: () =>
                                            _showAddBookingDialog(),
                                        tooltip: 'Add New Booking',
                                      ),
                                      SizedBox(width: 8),
                                      if (booking.status ==
                                          BookingStatus.pending) ...[
                                        _buildActionButton(
                                          'Confirm',
                                          Colors.green,
                                          () => _confirmBooking(
                                            bookings.indexOf(booking),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        _buildActionButton(
                                          'Cancel',
                                          Colors.red,
                                          () => _cancelBooking(
                                            bookings.indexOf(booking),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        _buildActionButton(
                                          'Reschedule',
                                          Colors.orange,
                                          () => _rescheduleBooking(
                                            bookings.indexOf(booking),
                                          ),
                                        ),
                                      ] else ...[
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _getStatusColor(
                                              booking.status,
                                            ).withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                          child: Text(
                                            _getStatusText(booking.status),
                                            style: TextStyle(
                                              color: _getStatusColor(
                                                booking.status,
                                              ),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ],
                      ),
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

  Widget _buildStatCard(String number, String label, Color backgroundColor) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildBookingRow(BookingData booking, int index) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              booking.name,
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              booking.Services,
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              booking.Rental,
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              booking.ArrivalDate,
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              booking.DepartureDate,
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              booking.Hotel,
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              booking.TotalPrice,
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              booking.ContactNumber,
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              booking.email,
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                if (booking.status == BookingStatus.pending) ...[
                  _buildActionButton(
                    'Confirm',
                    Colors.green,
                    () => _confirmBooking(index),
                  ),
                  SizedBox(width: 8),
                  _buildActionButton(
                    'Cancel',
                    Colors.red,
                    () => _cancelBooking(index),
                  ),
                  SizedBox(width: 8),
                  _buildActionButton(
                    'Reschedule',
                    Colors.orange,
                    () => _rescheduleBooking(index),
                  ),
                ] else ...[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getStatusColor(booking.status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      _getStatusText(booking.status),
                      style: TextStyle(
                        color: _getStatusColor(booking.status),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, Color color, VoidCallback onPressed) {
    return Container(
      height: 32,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color.withOpacity(0.1),
          foregroundColor: color,
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Color _getStatusColor(BookingStatus status) {
    switch (status) {
      case BookingStatus.confirmed:
        return Colors.green;
      case BookingStatus.cancelled:
        return Colors.red;
      case BookingStatus.rescheduled:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(BookingStatus status) {
    switch (status) {
      case BookingStatus.confirmed:
        return 'Confirmed';
      case BookingStatus.cancelled:
        return 'Cancelled';
      case BookingStatus.rescheduled:
        return 'Rescheduled';
      default:
        return 'Pending';
    }
  }

  TextStyle _headerStyle() {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: Colors.grey[600],
      letterSpacing: 0.5,
    );
  }

  void _confirmBooking(int index) {
    setState(() {
      bookings[index].status = BookingStatus.confirmed;
    });
    _showSnackBar(
      'Booking confirmed for ${bookings[index].name}',
      Colors.green,
    );
  }

  void _cancelBooking(int index) {
    setState(() {
      bookings[index].status = BookingStatus.cancelled;
    });
    _showSnackBar('Booking cancelled for ${bookings[index].name}', Colors.red);
  }

  void _rescheduleBooking(int index) {
    _showRescheduleDialog(index);
  }

  void _showRescheduleDialog(int index) {
    DateTime? selectedDate;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Reschedule Booking'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Reschedule booking for ${bookings[index].name}?'),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      DateTime now = DateTime.now();
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: now,
                        firstDate: now,
                        lastDate: DateTime(now.year + 2),
                      );
                      if (picked != null) {
                        setState(() {
                          selectedDate = picked;
                        });
                      }
                    },
                    child: Text(
                      selectedDate == null
                          ? 'Pick New Date'
                          : 'New Date: ${selectedDate!.toLocal().toString().split(' ')[0]}',
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: selectedDate == null
                      ? null
                      : () {
                          setState(() {
                            bookings[index].status = BookingStatus.rescheduled;
                            bookings[index].ArrivalDate = selectedDate!
                                .toLocal()
                                .toString()
                                .split(' ')[0];
                          });
                          Navigator.of(context).pop();
                          _showSnackBar(
                            'Booking rescheduled for ${bookings[index].name} to ${selectedDate!.toLocal().toString().split(' ')[0]}',
                            Colors.orange,
                          );
                        },
                  child: Text('Reschedule'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showAddBookingDialog() {
    // Clear previous form data
    _nameController.clear();
    _servicesController.clear();
    _rentalController.clear();
    _arrivalDateController.clear();
    _departureDateController.clear();
    _hotelController.clear();
    _noOfPaxController.clear();
    _totalPriceController.clear();
    _contactNumberController.clear();
    _emailController.clear();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Booking'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _servicesController,
                  decoration: InputDecoration(
                    labelText: 'Services',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _rentalController,
                  decoration: InputDecoration(
                    labelText: 'Rental',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _arrivalDateController,
                  decoration: InputDecoration(
                    labelText: 'Arrival Date (YYYY-MM-DD)',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _departureDateController,
                  decoration: InputDecoration(
                    labelText: 'Departure Date (YYYY-MM-DD)',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _hotelController,
                  decoration: InputDecoration(
                    labelText: 'Hotel',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _noOfPaxController,
                  decoration: InputDecoration(
                    labelText: 'Number of Pax',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _totalPriceController,
                  decoration: InputDecoration(
                    labelText: 'Total Price',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _contactNumberController,
                  decoration: InputDecoration(
                    labelText: 'Contact Number',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => _addNewBooking(),
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addNewBooking() {
    // Validate required fields
    if (_nameController.text.isEmpty ||
        _servicesController.text.isEmpty ||
        _arrivalDateController.text.isEmpty ||
        _departureDateController.text.isEmpty ||
        _noOfPaxController.text.isEmpty ||
        _totalPriceController.text.isEmpty ||
        _contactNumberController.text.isEmpty ||
        _emailController.text.isEmpty) {
      _showSnackBar('Please fill in all required fields', Colors.red);
      return;
    }

    // Parse number of pax
    int? noOfPax = int.tryParse(_noOfPaxController.text);
    if (noOfPax == null) {
      _showSnackBar(
        'Please enter a valid number for Number of Pax',
        Colors.red,
      );
      return;
    }

    // Create new booking
    BookingData newBooking = BookingData(
      name: _nameController.text,
      Services: _servicesController.text,
      Rental: _rentalController.text.isEmpty ? 'None' : _rentalController.text,
      ArrivalDate: _arrivalDateController.text,
      DepartureDate: _departureDateController.text,
      Hotel: _hotelController.text.isEmpty ? 'None' : _hotelController.text,
      noOfPax: noOfPax,
      TotalPrice: _totalPriceController.text,
      ContactNumber: _contactNumberController.text,
      email: _emailController.text,
      status: BookingStatus.pending,
    );

    // Add to bookings list
    setState(() {
      bookings.add(newBooking);
    });

    // Close dialog
    Navigator.of(context).pop();

    // Show success message
    _showSnackBar('New booking added successfully!', Colors.green);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _nameController.dispose();
    _servicesController.dispose();
    _rentalController.dispose();
    _arrivalDateController.dispose();
    _departureDateController.dispose();
    _hotelController.dispose();
    _noOfPaxController.dispose();
    _totalPriceController.dispose();
    _contactNumberController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}

class BookingData {
  final String name;
  final String Services;
  final String Rental;
  String ArrivalDate;
  final String DepartureDate;
  final String Hotel;
  final int noOfPax;
  final String TotalPrice;
  final String ContactNumber;
  final String email;
  BookingStatus status;

  BookingData({
    required this.name,
    required this.Services,
    required this.Rental,
    required this.ArrivalDate,
    required this.DepartureDate,
    required this.Hotel,
    required this.noOfPax,
    required this.TotalPrice,
    required this.ContactNumber,
    required this.email,
    required this.status,
  });
}

enum BookingStatus { pending, confirmed, cancelled, rescheduled }
