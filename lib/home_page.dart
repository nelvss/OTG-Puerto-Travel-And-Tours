import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'book_now.dart';
import 'dart:async'; // Added for Timer

/// A simple helper for quickly checking common break‑points.
class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1024;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OTG Puerto Galera Travel And Tours',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        fontFamily: 'Archivo', // Set Archivo as default font
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePageTab(),
    const ContactUsTab(),
    const ServicesTab(),
    // Wrap BookingForm with Theme to override fontFamily
    Theme(
      data: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        fontFamily: 'Roboto', // Use Roboto for Book Now tab and its flow
      ),
      child: BookingForm(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 219, 38, 38),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/Logo.png',
              height: Responsive.isMobile(context) ? 40 : 48,
              width: Responsive.isMobile(context) ? 40 : 48,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.admin_panel_settings,
                  size: Responsive.isMobile(context) ? 40 : 48,
                );
              },
            ),
            const SizedBox(width: 12),
            if (!Responsive.isMobile(context))
              const Expanded(
                child: Text(
                  'OTG Puerto Galera Travel And Tours',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 219, 38, 38),
                Color.fromARGB(255, 243, 33, 33),
              ],
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Center(
                  child: CircleAvatar(
                    radius: Responsive.isMobile(context) ? 45 : 60,
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      'assets/Logo.png',
                      width: Responsive.isMobile(context) ? 60 : 80,
                      height: Responsive.isMobile(context) ? 60 : 80,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.admin_panel_settings,
                          size: Responsive.isMobile(context) ? 60 : 80,
                          color: const Color.fromARGB(255, 219, 38, 38),
                        );
                      },
                    ),
                  ),
                ),
              ),
              _buildDrawerItem(icon: Icons.home, title: 'Home', index: 0),
              _buildDrawerItem(
                icon: Icons.contact_emergency,
                title: 'Contact Us',
                index: 1,
              ),
              _buildDrawerItem(
                icon: Icons.travel_explore,
                title: 'Services',
                index: 2,
              ),
              _buildDrawerItem(
                icon: Icons.book_online,
                title: 'Book Now',
                index: 3,
              ),
            ],
          ),
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(seconds: 1),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: _pages[_selectedIndex],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required int index,
  }) {
    final isSelected = index == _selectedIndex;

    return ListTile(
      leading: Icon(icon, color: isSelected ? Colors.white : Colors.white70),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.white70,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      onTap: () {
        setState(() => _selectedIndex = index);
        Navigator.pop(context);
      },
    );
  }
}

// ================= Home Tab =================
class HomePageTab extends StatefulWidget {
  const HomePageTab({super.key});

  @override
  State<HomePageTab> createState() => _HomePageTabState();
}

class _HomePageTabState extends State<HomePageTab> {
  bool _isLoading = false;
  int _dotCount = 1;
  Timer? _dotTimer;

  @override
  void dispose() {
    _dotTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Background 1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(97, 255, 255, 255).withOpacity(0.6),
                    const Color.fromARGB(118, 255, 255, 255),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double screenWidth = constraints.maxWidth;
                    double titleFontSize = screenWidth > 1200
                        ? 48
                        : screenWidth > 800
                        ? 40
                        : 32;
                    double buttonFontSize = screenWidth > 1200
                        ? 40
                        : screenWidth > 800
                        ? 32
                        : 24;
                    double horizontalPadding = screenWidth > 800 ? 35.0 : 24.0;
                    double verticalPadding = screenWidth > 800 ? 25.0 : 20.0;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LayoutBuilder(
                          builder: (context, constraints) {
                            double screenWidth = constraints.maxWidth;
                            double titleFontSize = screenWidth > 1200
                                ? 48
                                : screenWidth > 800
                                ? 40
                                : 32;

                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32.0,
                                vertical: 16.0,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Welcome to OTG Puerto Galera Travel and Tours',
                                style: TextStyle(
                                  height: 1.2,
                                  fontSize: titleFontSize,
                                  fontFamily: 'Archivo',
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          },
                        ),

                        Container(
                          constraints: const BoxConstraints(maxWidth: 800),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32.0,
                            vertical: 16.0,
                          ),
                          child: const Text(
                            'Discover, explore, and share unforgettable adventures with us! Whether you\'re dreaming of tropical beaches or cultural escapes, we\'ve got the perfect tour package for you. Start your journey today—book with ease and travel with confidence!',
                            style: TextStyle(
                              fontSize: 25,
                              height: 1.6,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              fontFamily: 'Archivo',
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),

                        ElevatedButton(
                          onPressed: _isLoading
                              ? null
                              : () async {
                                  setState(() {
                                    _isLoading = true;
                                    _dotCount = 1;
                                  });
                                  _dotTimer = Timer.periodic(
                                    Duration(milliseconds: 400),
                                    (timer) {
                                      setState(() {
                                        _dotCount = _dotCount % 3 + 1;
                                      });
                                    },
                                  );
                                  await Future.delayed(Duration(seconds: 2));
                                  _dotTimer?.cancel();
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookingForm(),
                                    ),
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              219,
                              38,
                              38,
                            ),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding,
                              vertical: verticalPadding,
                            ),
                            textStyle: TextStyle(
                              fontSize: buttonFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: _isLoading
                              ? BouncingBallLoader(
                                  ballSize: buttonFontSize * 0.7,
                                )
                              : Text(
                                  'Book Now',
                                  style: TextStyle(
                                    fontSize: buttonFontSize,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Archivo',
                                  ),
                                ),
                        ),

                        const SizedBox(height: 20),

                        screenWidth > 800
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: buildInfoCard(
                                      'Mission',
                                      'To provide exceptional travel experiences, promote sustainable tourism practices, and showcase the beauty and culture of Puerto Galera to travelers around the world. It aims to create unforgettable journeys while respecting the local environment and supporting the community.',
                                      titleFontSize,
                                    ),
                                  ),
                                  const SizedBox(width: 40),
                                  Expanded(
                                    child: buildInfoCard(
                                      'Vision',
                                      'To ensure that our clients have memorable experiences and fulfill their dreams and goals through travel. We want our clients to remember their trips with us for a lifetime.',
                                      titleFontSize,
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  buildInfoCard(
                                    'Mission',
                                    'To provide exceptional travel experiences, promote sustainable tourism practices, and showcase the beauty and culture of Puerto Galera to travelers around the world. It aims to create unforgettable journeys while respecting the local environment and supporting the community.',
                                    titleFontSize,
                                  ),
                                  const SizedBox(height: 20),
                                  buildInfoCard(
                                    'Vision',
                                    'To ensure that our clients have memorable experiences and fulfill their dreams and goals through travel. We want our clients to remember their trips with us for a lifetime.',
                                    titleFontSize,
                                  ),
                                ],
                              ),

                        const SizedBox(height: 60),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoCard(String title, String content, double fontSize) {
    return Container(
      constraints: const BoxConstraints(minHeight: 300),
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              height: 1.2,
              color: const Color.fromARGB(255, 219, 38, 38),
              fontFamily: 'Archivo',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            content,
            style: const TextStyle(
              fontSize: 25,
              height: 1.6,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              fontFamily: 'Archivo',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ================= Contact Us Tab ================
class ContactUsTab extends StatefulWidget {
  const ContactUsTab({super.key});

  @override
  State<ContactUsTab> createState() => _ContactUsTabState();
}

class _ContactUsTabState extends State<ContactUsTab> {
  final TextEditingController _messageController = TextEditingController();
  bool _isSubmitting = false;

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _submitForm() async {
    setState(() {
      _isSubmitting = true;
    });
    // Simulate a network request or form submission delay
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isSubmitting = false;
    });
    // Optionally clear the message or show a dialog/snackbar
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Message sent!')));
    _messageController.clear();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Background 1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(color: Colors.white.withOpacity(0.6)),
            ),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Wrap(
                      spacing: 30,
                      runSpacing: 30,
                      alignment: WrapAlignment.center,
                      children: [
                        ContactCard(
                          icon: Icons.facebook,
                          label: 'Message us on Facebook',
                          onPressed: () => _launchURL(
                            'https://www.facebook.com/share/1CMUtLrMxZ/?mibextid=wwXIfr',
                          ),
                        ),
                        ContactCard(
                          icon: Icons.camera_alt,
                          label: 'Message us on Instagram',
                          onPressed: () => _launchURL(
                            'https://www.instagram.com/otgpuertogalera?igsh=MXJibjlodnFweWhxMA==',
                          ),
                        ),
                        ContactCard(
                          icon: Icons.phone,
                          label: 'Call us on our Globe Sim',
                          onPressed: () => _launchURL('tel:09778200028'),
                        ),
                        ContactCard(
                          icon: Icons.email,
                          label: 'Message us on Email',
                          onPressed: () =>
                              _launchURL('mailto:merlynreyes54@gmail.com'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: Responsive.isMobile(context) ? 500 : 600,
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _messageController,
                            decoration: InputDecoration(
                              labelText: 'Message/Feedback',
                              hintText:
                                  'Enter your message or feedback here...',
                              prefixIcon: Icon(Icons.message),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.grey[50],
                            ),
                            maxLines: 5,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your message';
                              }
                              if (value.length < 10) {
                                return 'Message must be at least 10 characters long';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 24),

                          // Submit Button with GestureDetector for onLongPress
                          GestureDetector(
                            onLongPress: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Form Information'),
                                    content: Text(
                                      'This form collects your name, email, and message for feedback purposes.',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: ElevatedButton(
                              onPressed: _isSubmitting ? null : _submitForm,
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  250,
                                  73,
                                  2,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: _isSubmitting
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                  Colors.white,
                                                ),
                                          ),
                                        ),
                                        SizedBox(width: 12),
                                        Text('Submitting...'),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.send, color: Colors.white),
                                        SizedBox(width: 8),
                                        Text(
                                          'Send Message',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const ContactCard({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bool mobile = Responsive.isMobile(context);
    return SizedBox(
      width: mobile ? 160 : 220,
      child: Card(
        color: Colors.white.withOpacity(0.95),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: mobile ? 36 : 48),
              const SizedBox(height: 16),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 247, 4, 4),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Contact Us'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================ Services Tab =========
class ServicesTab extends StatelessWidget {
  const ServicesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth < 600 ? 1 : 2; // Reduced from 2:3 to 1:2
    // Increased aspect ratio to make boxes much taller
    double aspectRatio = screenWidth < 600
        ? 0.7
        : 0.8; // Increased from 0.5:1.0
    final double basePadding = screenWidth < 600
        ? 15.0
        : 30.0; // Increased padding
    final double titleFontSize = screenWidth < 600
        ? 28
        : 36; // Increased font size

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/Background 1.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(basePadding),
        child: Column(
          children: [
            SizedBox(height: basePadding * 1),
            Text(
              'Services Offered',
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: const [
                  Shadow(
                    offset: Offset(2.0, 2.0),
                    blurRadius: 4.0,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
            SizedBox(height: basePadding * 1.5),
            Expanded(
              child: GridView.count(
                crossAxisCount: crossAxisCount,
                // Reduced spacing but increased card size
                crossAxisSpacing: basePadding * 2,
                mainAxisSpacing: basePadding * 2,
                childAspectRatio: aspectRatio,
                children: [
                  _buildTourCard(
                    context,
                    'assets/1.jpg',
                    'Inland Tour',
                    () => _showImageDialog(
                      context,
                      'assets/1.jpg',
                      'Inland Tour',
                    ),
                  ),
                  _buildTourCard(
                    context,
                    'assets/3.jpg',
                    'Island Tour',
                    () => _showImageDialog(
                      context,
                      'assets/3.jpg',
                      'Island Tour',
                    ),
                  ),
                  _buildTourCard(
                    context,
                    'assets/4.jpg',
                    'Resort Experience',
                    () => _showImageDialog(
                      context,
                      'assets/4.jpg',
                      'Resort Experience',
                    ),
                  ),
                  _buildTourCard(
                    context,
                    'assets/2.jpg',
                    'Van Rental',
                    () => _showImageDialog(
                      context,
                      'assets/2.jpg',
                      'Car & Motor Rental',
                    ),
                  ),

                  _buildTourCard(
                    context,
                    'assets/car.jpg',
                    'Car & Motor Rental',
                    () => _showImageDialog(
                      context,
                      'assets/car.jpg',
                      'Car & Motor Rental',
                    ),
                  ),
                  _buildTourCard(
                    context,
                    'assets/hotel.jpg',
                    'Mangyan Grand Hotel',
                    () => _showImageDialog(
                      context,
                      'assets/hotel.jpg',
                      'Mangyan Grand Hotel',
                    ),
                  ),
                  _buildTourCard(
                    context,
                    'assets/infinity.jpg',
                    'Infinity Resort',
                    () => _showImageDialog(
                      context,
                      'assets/infinity.jpg',
                      'Infinity Resort',
                    ),
                  ),
                  _buildTourCard(
                    context,
                    'assets/casa.jpg',
                    'Casa Mia Resort',
                    () => _showImageDialog(
                      context,
                      'assets/casa.jpg',
                      'Casa Mia Resort',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTourCard(
    BuildContext context,
    String imagePath,
    String title,
    VoidCallback onViewTap,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Much larger font size
    // ignore: unused_local_variable
    final double fontSize = screenWidth < 600 ? 28 : 42; // Increased from 24:36
    return Card(
      // Increased elevation for more prominent appearance
      elevation: 12, // Increased from 8
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Increased from 15
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Expanded(
              // Full space for image since no text
              flex: 1,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), // Full card rounded
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                    onError: (exception, stackTrace) {},
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black.withOpacity(0.08),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showImageDialog(BuildContext context, String imagePath, String title) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final double dialogWidth = screenWidth < 600 ? screenWidth * 0.8 : 400;
    final double dialogHeight = screenHeight < 600 ? screenHeight * 0.4 : 350;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: dialogWidth,
              maxHeight: dialogHeight,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: dialogHeight * 2,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14),
                    ),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                      onError: (exception, stackTrace) {},
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[700],
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 6),
                          ),
                          child: const Text(
                            'Close',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Add AnimatedDots widget at the end of the file
class AnimatedDots extends StatelessWidget {
  final int dotCount;
  final double fontSize;
  const AnimatedDots({Key? key, required this.dotCount, required this.fontSize})
    : super(key: key);
  @override
  Widget build(BuildContext context) {
    String dots = List.generate(dotCount, (_) => '•').join(' ');
    return Text(
      dots,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 2,
      ),
    );
  }
}

// Add BouncingBallLoader widget at the end of the file
class BouncingBallLoader extends StatefulWidget {
  final double ballSize;
  const BouncingBallLoader({Key? key, this.ballSize = 24}) : super(key: key);

  @override
  State<BouncingBallLoader> createState() => _BouncingBallLoaderState();
}

class _BouncingBallLoaderState extends State<BouncingBallLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat(reverse: true);
    _animation = Tween<double>(
      begin: 0,
      end: -18,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.ballSize * 2,
      width: widget.ballSize * 2,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _animation.value),
            child: child,
          );
        },
        child: Container(
          width: widget.ballSize,
          height: widget.ballSize,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
