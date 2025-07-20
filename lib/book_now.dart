import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:booking_system2/booking_summary.dart';

class BookingForm extends StatefulWidget {
  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _departureDateController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: null,
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Center(
                  child: Text(
                    'Booking Form',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // First Name and Last Name Row
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _firstNameController,
                        label: 'First Name',
                        hint: 'Enter first name',
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(
                        controller: _lastNameController,
                        label: 'Last Name',
                        hint: 'Enter last name',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Email and Contact Row
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _emailController,
                        label: 'Email Address',
                        hint: 'Enter email address',
                        keyboardType: TextInputType.emailAddress,
                        isEmail: true,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(
                        controller: _contactController,
                        label: 'Contact Number',
                        hint: 'Enter contact number',
                        keyboardType: TextInputType.phone,
                        isContact: true,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),

                // Booking Date Section
                Text(
                  'Booking Date',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 16),

                // Date and Time Row
                Row(
                  children: [
                    Expanded(child: _buildDateField()),
                    SizedBox(width: 16),
                    Expanded(child: _buildDepartureDateField()),
                  ],
                ),
                SizedBox(height: 32),

                // Proceed to Services Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _proceedToServices();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFE91E63),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 3,
                    ),
                    child: Text(
                      'PROCEED TO SERVICES',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    bool isEmail = false,
    bool isContact = false,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: isContact
              ? [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ]
              : inputFormatters,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[500]),
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFFE91E63), width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            if (isEmail) {
              final emailRegex = RegExp(
                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
              );
              if (!emailRegex.hasMatch(value)) {
                return 'Please enter a valid email address';
              }
            }
            if (isContact) {
              final contactRegex = RegExp(r'^\d{11}$');
              if (!contactRegex.hasMatch(value)) {
                return 'Contact number must be exactly 11 digits';
              }
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Arrival Date',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: _dateController,
          readOnly: true,
          decoration: InputDecoration(
            hintText: 'MM/DD/YYYY',
            hintStyle: TextStyle(color: Colors.grey[500]),
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            suffixIcon: Icon(Icons.calendar_today, color: Colors.grey[600]),
          ),
          onTap: () async {
            DateTime? selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2101),
            );
            if (selectedDate != null) {
              setState(() {
                _dateController.text =
                    "${selectedDate.month}/${selectedDate.day}/${selectedDate.year}";
              });
            }
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDepartureDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Departure Date',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: _departureDateController,
          readOnly: true,
          decoration: InputDecoration(
            hintText: 'MM/DD/YYYY',
            hintStyle: TextStyle(color: Colors.grey[500]),
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFFE91E63), width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            suffixIcon: Icon(Icons.calendar_today, color: Colors.grey[600]),
          ),
          onTap: () async {
            DateTime firstDate = DateTime.now();
            if (_dateController.text.isNotEmpty) {
              final parts = _dateController.text.split('/');
              if (parts.length == 3) {
                final arrivalDate = DateTime(
                  int.parse(parts[2]),
                  int.parse(parts[0]),
                  int.parse(parts[1]),
                );
                firstDate = arrivalDate.add(Duration(days: 1));
              }
            }
            DateTime? selectedDate = await showDatePicker(
              context: context,
              initialDate: firstDate,
              firstDate: firstDate,
              lastDate: DateTime(2101),
            );
            if (selectedDate != null) {
              setState(() {
                _departureDateController.text =
                    "${selectedDate.month}/${selectedDate.day}/${selectedDate.year}";
              });
            }
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a departure date';
            }
            return null;
          },
        ),
      ],
    );
  }

  void _proceedToServices() {
    // Collect form data
    Map<String, String> bookingData = {
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      'email': _emailController.text,
      'contact': _contactController.text,
      'date': _dateController.text,
      'departureDate': _departureDateController.text,
    };

    // Navigate to Services Form
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Theme(
          data: Theme.of(context).copyWith(
            textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Roboto'),
          ),
          child: ServicesForm(bookingData: bookingData),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _contactController.dispose();
    _dateController.dispose();
    _departureDateController.dispose();
    super.dispose();
  }
}

class ServicesForm extends StatefulWidget {
  final Map<String, String> bookingData;

  ServicesForm({required this.bookingData});

  @override
  _ServicesFormState createState() => _ServicesFormState();
}

class _ServicesFormState extends State<ServicesForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _totalAmountController = TextEditingController();
  final TextEditingController _numTouristsController = TextEditingController();
  final TextEditingController _numDaysController = TextEditingController();
  final TextEditingController _hotelDaysController = TextEditingController();
  final TextEditingController _carRentalTotalController =
      TextEditingController();
  final TextEditingController _combinedTotalController =
      TextEditingController();
  final TextEditingController _hotelTotalController = TextEditingController();

  // Dropdown values
  List<String> _selectedSnorkelingTours = [];
  List<String> _selectedIslandTours = [];
  List<String> _selectedInlandTours = [];
  List<String> _selectedCarRentals = [];
  List<String> _selectedHotels = [];

  // Dropdown options
  final List<String> _snorkelingOptions = [
    'Muelle Bay',
    'Sand Bar Beach',
    'Coral Garden',
    'Giant Clams',
    'Underwater Cave',
  ];
  final List<String> _islandTourOptions = [
    'Heart Beach',
    'Haligi Beach',
    'Long Beach',
    'Starfish Beach',
    'Muelle Bay',
  ];
  final List<String> _inlandTourOptions = [
    'Muelle Heritage Park',
    'Virgin Beach',
    'View Point',
    'Tamarraw Falls',
  ];
  final List<String> _carRentalOptions = [
    'ADV/NMAX',
    'Versys 650',
    'Versys 1000',
    'Tuktuk',
    'Car',
  ];
  final List<String> _hotelOptions = [
    'The Mangyan Grand Hotel',
    'Infinity Hotel',
    'Ilaya',
  ];

  @override
  void initState() {
    super.initState();
    _numTouristsController.addListener(_updateTotalAmount);
    _numDaysController.addListener(_updateTotalAmount);
  }

  int get _calculatedHotelDays {
    try {
      final arrival = widget.bookingData['date'];
      final departure = widget.bookingData['departureDate'];
      if (arrival == null || departure == null) return 0;
      final arrivalDate = DateTime.parse(_convertToIsoDate(arrival));
      final departureDate = DateTime.parse(_convertToIsoDate(departure));
      final days = departureDate.difference(arrivalDate).inDays;
      return days > 0 ? days : 0;
    } catch (_) {
      return 0;
    }
  }

  String _convertToIsoDate(String date) {
    // Expects MM/DD/YYYY, returns YYYY-MM-DD
    final parts = date.split('/');
    if (parts.length == 3) {
      return '${parts[2]}-${parts[0].padLeft(2, '0')}-${parts[1].padLeft(2, '0')}';
    }
    return date;
  }

  double calculatePrice(int numTourists, int numTours) {
    double pricePerTourist;

    if (numTourists == 1) {
      pricePerTourist = 2400;
    } else if (numTourists == 2) {
      pricePerTourist = 1300;
    } else if (numTourists >= 3 && numTourists <= 4) {
      pricePerTourist = 1000;
    } else if (numTourists >= 5 && numTourists <= 6) {
      pricePerTourist = 900;
    } else if (numTourists >= 7) {
      pricePerTourist = 800;
    } else {
      pricePerTourist = 0; // Invalid or zero tourists
    }

    double totalAmount = pricePerTourist * numTourists * numTours;
    return totalAmount;
  }

  double calculateIslandTourTotalAmount(int numTourists) {
    double pricePerTourist;

    if (numTourists == 1) {
      pricePerTourist = 3000;
    } else if (numTourists == 2) {
      pricePerTourist = 1600;
    } else if (numTourists >= 3 && numTourists <= 4) {
      pricePerTourist = 1000;
    } else {
      pricePerTourist = 800;
    }

    return pricePerTourist * numTourists;
  }

  double calculateInlandTourTotalAmount(int numTourists) {
    double pricePerTourist;

    if (numTourists == 2) {
      pricePerTourist = 1500;
    } else if (numTourists == 3) {
      pricePerTourist = 1100;
    } else if (numTourists == 4) {
      pricePerTourist = 800;
    } else if (numTourists >= 5 && numTourists <= 6) {
      pricePerTourist = 700;
    } else if (numTourists >= 7 && numTourists <= 9) {
      pricePerTourist = 600;
    } else if (numTourists >= 10) {
      pricePerTourist = 550;
    } else {
      pricePerTourist = 0; // handles 1 tourist or invalid input
    }

    return pricePerTourist * numTourists;
  }

  double calculateCarMotorRentalTotalAmount(String vehicleType, int days) {
    double pricePerDay;

    if (vehicleType == 'ADV/NMAX') {
      pricePerDay = 1000;
    } else if (vehicleType == 'Versys 650') {
      pricePerDay = 4000;
    } else if (vehicleType == 'Versys 1000') {
      pricePerDay = 4500;
    } else if (vehicleType == 'Tuktuk') {
      pricePerDay = 1500;
    } else if (vehicleType == 'Car') {
      pricePerDay = 3500;
    } else {
      pricePerDay = 0; // for invalid vehicle types
    }

    return pricePerDay * days;
  }

  double calculateHotelTotalAmount(String hotelType, int days) {
    double pricePerNight;

    if (hotelType == 'The Mangyan Grand Hotel') {
      pricePerNight = 3500;
    } else if (hotelType == 'Infinity Hotel') {
      pricePerNight = 5000;
    } else if (hotelType == 'Ilaya') {
      pricePerNight = 2500;
    } else {
      pricePerNight = 0; // for invalid hotel types
    }

    return pricePerNight * days;
  }

  void _updateTotalAmount() {
    int numTourists = int.tryParse(_numTouristsController.text) ?? 0;
    int numSnorkelingTours = _selectedSnorkelingTours.length;
    int numIslandTours = _selectedIslandTours.length;
    int numInlandTours = _selectedInlandTours.length;
    double tourTotal = 0;
    double carRentalTotal = 0;
    double hotelTotal = 0;

    // Calculate tour total
    if (numTourists > 0) {
      if (numSnorkelingTours > 0) {
        tourTotal += calculatePrice(numTourists, 1);
      }
      if (numIslandTours > 0) {
        tourTotal += calculateIslandTourTotalAmount(numTourists);
      }
      if (numInlandTours > 0) {
        tourTotal += calculateInlandTourTotalAmount(numTourists);
      }
    }

    // Calculate car rental total
    if (_selectedCarRentals.isNotEmpty && _numDaysController.text.isNotEmpty) {
      int numDays = int.tryParse(_numDaysController.text) ?? 0;
      if (numDays > 0) {
        // Calculate total for all selected vehicles
        for (String vehicle in _selectedCarRentals) {
          carRentalTotal += calculateCarMotorRentalTotalAmount(
            vehicle,
            numDays,
          );
        }
      }
    }

    // Calculate hotel total
    int hotelDays = _calculatedHotelDays;
    if (_selectedHotels.isNotEmpty && hotelDays > 0) {
      for (String hotel in _selectedHotels) {
        hotelTotal += calculateHotelTotalAmount(hotel, hotelDays);
      }
    }

    // Calculate combined total
    double combinedTotal = tourTotal + carRentalTotal + hotelTotal;

    _totalAmountController.text = (tourTotal > 0)
        ? '${tourTotal.toStringAsFixed(2)}'
        : '';
    _carRentalTotalController.text = (carRentalTotal > 0)
        ? '${carRentalTotal.toStringAsFixed(2)} (${_numDaysController.text} days)'
        : '';
    _hotelTotalController.text = (hotelTotal > 0)
        ? '${hotelTotal.toStringAsFixed(2)} (${_calculatedHotelDays} days)'
        : '';
    _combinedTotalController.text = (combinedTotal > 0)
        ? '${combinedTotal.toStringAsFixed(2)}'
        : '';
  }

  // Helper to check if at least one tour is selected
  bool _hasSelectedAnyTour() {
    return _selectedSnorkelingTours.isNotEmpty ||
        _selectedIslandTours.isNotEmpty ||
        _selectedInlandTours.isNotEmpty ||
        _selectedCarRentals.isNotEmpty ||
        _selectedHotels.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Services Offered'),
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/Background 1.jpg',
              fit: BoxFit.cover,
              color: Colors.white.withOpacity(0.7),
              colorBlendMode: BlendMode.lighten,
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Center(
                      child: Text(
                        'Services Offered',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),

                    // Booking Summary
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue[200]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: Colors.blue[600],
                                size: 20,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Booking Summary',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue[800],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          _buildSummaryRow(
                            'Name',
                            '${widget.bookingData['firstName']} ${widget.bookingData['lastName']}',
                          ),
                          _buildSummaryRow(
                            'Email',
                            widget.bookingData['email']!,
                          ),
                          _buildSummaryRow(
                            'Contact',
                            widget.bookingData['contact']!,
                          ),
                          _buildSummaryRow(
                            'Arrival Date',
                            widget.bookingData['date']!,
                          ),
                          _buildSummaryRow(
                            'Departure Date',
                            widget.bookingData['departureDate']!,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),

                    // Services Selection
                    Text(
                      'Select Services',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 16),

                    // Responsive layout for services dropdowns
                    LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth > 600) {
                          // Wide screen layout (e.g., tablet, desktop)
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildMultiSelectField(
                                      label: 'Snorkeling Tour',
                                      options: _snorkelingOptions,
                                      selectedValues: _selectedSnorkelingTours,
                                      onSelectionChanged: (selected) {
                                        setState(() {
                                          _selectedSnorkelingTours = selected;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: _buildMultiSelectField(
                                      label: 'Island Tour',
                                      options: _islandTourOptions,
                                      selectedValues: _selectedIslandTours,
                                      onSelectionChanged: (selected) {
                                        setState(() {
                                          _selectedIslandTours = selected;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: _buildMultiSelectField(
                                      label: 'Inland Tour',
                                      options: _inlandTourOptions,
                                      selectedValues: _selectedInlandTours,
                                      onSelectionChanged: (selected) {
                                        setState(() {
                                          _selectedInlandTours = selected;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildMultiSelectField(
                                      label: 'Select Hotel (Optional)',
                                      options: _hotelOptions,
                                      selectedValues: _selectedHotels,
                                      onSelectionChanged: (selected) {
                                        setState(() {
                                          _selectedHotels = selected;
                                          _updateTotalAmount();
                                        });
                                      },
                                      showSelectAll: false,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Container(),
                                  ), // Empty space for alignment
                                ],
                              ),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildMultiSelectField(
                                      label:
                                          'Select Car/Motor Rental (Optional)',
                                      options: _carRentalOptions,
                                      selectedValues: _selectedCarRentals,
                                      onSelectionChanged: (selected) {
                                        setState(() {
                                          _selectedCarRentals = selected;
                                          _updateTotalAmount();
                                        });
                                      },
                                      showSelectAll: false,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: _buildTextField(
                                      controller: _numTouristsController,
                                      label: 'Number of Tourists',
                                      hint: 'Enter number of tourists',
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if (_selectedCarRentals.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: _buildTextField(
                                    controller: _numDaysController,
                                    label: 'Number of Days (Car/Motor Rental)',
                                    hint: 'Enter number of days',
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                  ),
                                ),
                            ],
                          );
                        } else {
                          // Narrow screen layout (e.g., phone)
                          return Column(
                            children: [
                              _buildMultiSelectField(
                                label: 'Snorkeling Tour',
                                options: _snorkelingOptions,
                                selectedValues: _selectedSnorkelingTours,
                                onSelectionChanged: (selected) {
                                  setState(() {
                                    _selectedSnorkelingTours = selected;
                                  });
                                },
                              ),
                              SizedBox(height: 16),
                              _buildMultiSelectField(
                                label: 'Island Tour',
                                options: _islandTourOptions,
                                selectedValues: _selectedIslandTours,
                                onSelectionChanged: (selected) {
                                  setState(() {
                                    _selectedIslandTours = selected;
                                  });
                                },
                              ),
                              SizedBox(height: 16),
                              _buildMultiSelectField(
                                label: 'Inland Tour',
                                options: _inlandTourOptions,
                                selectedValues: _selectedInlandTours,
                                onSelectionChanged: (selected) {
                                  setState(() {
                                    _selectedInlandTours = selected;
                                  });
                                },
                              ),
                              SizedBox(height: 16),
                              _buildMultiSelectField(
                                label: 'Hotel',
                                options: _hotelOptions,
                                selectedValues: _selectedHotels,
                                onSelectionChanged: (selected) {
                                  setState(() {
                                    _selectedHotels = selected;
                                    _updateTotalAmount();
                                  });
                                },
                                showSelectAll: false,
                              ),
                              SizedBox(height: 16),
                              _buildMultiSelectField(
                                label: 'Car/Motor Rental',
                                options: _carRentalOptions,
                                selectedValues: _selectedCarRentals,
                                onSelectionChanged: (selected) {
                                  setState(() {
                                    _selectedCarRentals = selected;
                                    _updateTotalAmount();
                                  });
                                },
                                showSelectAll: false,
                              ),
                              SizedBox(height: 16),
                              _buildTextField(
                                controller: _numTouristsController,
                                label: 'Number of Tourists',
                                hint: 'Enter number of tourists',
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                              ),
                              if (_selectedCarRentals.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: _buildTextField(
                                    controller: _numDaysController,
                                    label: 'Number of Days',
                                    hint: 'Enter number of days',
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                  ),
                                ),
                            ],
                          );
                        }
                      },
                    ),
                    SizedBox(height: 24),

                    // Total Amounts
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _totalAmountController,
                            label: 'Total Amount in Services',
                            hint: 'Tour services total',
                            keyboardType: TextInputType.number,
                            readOnly: true,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField(
                            controller: _carRentalTotalController,
                            label: 'Total Amount in Car/Motor Rental',
                            hint: 'Car rental total',
                            keyboardType: TextInputType.number,
                            readOnly: true,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _hotelTotalController,
                            label: 'Total Amount in Hotel',
                            hint: 'Hotel total',
                            keyboardType: TextInputType.number,
                            readOnly: true,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Container(),
                        ), // Empty space for alignment
                      ],
                    ),
                    SizedBox(height: 16),
                    _buildTextField(
                      controller: _combinedTotalController,
                      label: 'Total Amount (Combined)',
                      hint: 'Total of all services',
                      keyboardType: TextInputType.number,
                      readOnly: true,
                    ),
                    SizedBox(height: 32),

                    // Proceed to Payment Button
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (!_hasSelectedAnyTour()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Please select at least one to proceed.',
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }
                          if (_formKey.currentState!.validate()) {
                            // Show loading dialog
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) =>
                                  Center(child: CircularProgressIndicator()),
                            );
                            await Future.delayed(Duration(seconds: 1));
                            Navigator.of(context).pop(); // Dismiss loading
                            // Collect all form data
                            Map<String, dynamic> completeBookingData = {
                              ...widget.bookingData,
                              'snorkelingTour': _selectedSnorkelingTours,
                              'islandTour1': _selectedIslandTours,
                              'inlandTour': _selectedInlandTours,
                              'carRental': _selectedCarRentals,
                              'hotel': _selectedHotels,
                              'numTourists': _numTouristsController.text,
                              'totalAmount': _combinedTotalController.text,
                            };
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Theme(
                                  data: Theme.of(context).copyWith(
                                    textTheme: Theme.of(
                                      context,
                                    ).textTheme.apply(fontFamily: 'Roboto'),
                                  ),
                                  child: BookingSummary(
                                    fullName:
                                        "${completeBookingData['firstName']} ${completeBookingData['lastName']}",
                                    email: completeBookingData['email'] ?? '',
                                    contactNumber:
                                        completeBookingData['contact'] ?? '',
                                    arrivalDate: _parseDate(
                                      completeBookingData['date'],
                                    ),
                                    departureDate: _parseDate(
                                      completeBookingData['departureDate'],
                                    ),
                                    selectedTour: _formatTourSummary(
                                      completeBookingData,
                                    ),
                                    selectedHotel:
                                        (completeBookingData['hotel'] as List)
                                            .join(', '),
                                    selectedRental:
                                        (completeBookingData['carRental']
                                                as List)
                                            .join(', '),
                                    totalAmount:
                                        double.tryParse(
                                          completeBookingData['totalAmount'] ??
                                              '0',
                                        ) ??
                                        0,
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE91E63),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 3,
                        ),
                        child: Text(
                          'PROCEED TO BOOKING SUMMARY',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 60,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.blue[700],
              ),
            ),
          ),
          Expanded(
            child: Text(value, style: TextStyle(color: Colors.black87)),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    bool readOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          readOnly: readOnly,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[500]),
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFFE91E63), width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          validator: (value) {
            if (readOnly) return null; // Skip validation for read-only fields
            if (label == 'Number of Tourists') {
              final digitsOnly = RegExp(r'^\d+');
              if (!digitsOnly.hasMatch(value ?? '')) {
                return 'Please enter a valid number';
              }
              if (int.tryParse(value ?? '') == null ||
                  int.parse(value ?? '0') <= 0) {
                return 'Number must be greater than 0';
              }
            }
            if (label == 'Number of Days' && _selectedCarRentals.isNotEmpty) {
              final digitsOnly = RegExp(r'^\d+');
              if (!digitsOnly.hasMatch(value ?? '')) {
                return 'Please enter a valid number';
              }
              if (int.tryParse(value ?? '') == null ||
                  int.parse(value ?? '0') <= 0) {
                return 'Number of days must be greater than 0';
              }
            }
            return null;
          },
          onChanged: (value) {
            if (label == 'Number of Tourists') {
              _updateTotalAmount();
            }
          },
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    Widget? hint,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(0xFFE91E63), width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      hint:
          hint ?? Text(items.first, style: TextStyle(color: Colors.grey[600])),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item, style: TextStyle(fontSize: 14)),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildMultiSelectField({
    required String label,
    required List<String> options,
    required List<String> selectedValues,
    required ValueChanged<List<String>> onSelectionChanged,
    bool showSelectAll = true,
  }) {
    return GestureDetector(
      onTap: () async {
        final List<String>? results = await showDialog<List<String>>(
          context: context,
          builder: (context) {
            return _MultiSelectDialog(
              title: label,
              options: options,
              initialSelected: selectedValues,
              showSelectAll: showSelectAll,
            );
          },
        );
        if (results != null) {
          onSelectionChanged(results);
          if (label == 'Select Snorkeling Tour' ||
              label == 'Select Island Tour' ||
              label == 'Select Inland Tour') {
            _updateTotalAmount();
          }
        }
      },
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            labelText: label,
            hintText: 'Select $label',
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFFE91E63), width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          controller: TextEditingController(
            text: selectedValues.isEmpty ? '' : selectedValues.join(', '),
          ),
          readOnly: true,
          validator: (value) {
            // Only validate Car/Motor Rental if you want it required
            if (label == 'Car/Motor Rental' && selectedValues.isEmpty) {
              return null; // Allow empty selection for car rental
            }
            // Make hotel selection optional
            if (label == 'Hotel') {
              return null;
            }
            // Do not require selection for Snorkeling, Island, or Inland Tour individually
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildSingleSelectField({
    required String label,
    required List<String> options,
    required String? selectedValue,
    required ValueChanged<String?> onSelectionChanged,
  }) {
    return GestureDetector(
      onTap: () async {
        final String? result = await showDialog<String>(
          context: context,
          builder: (context) {
            return _SingleSelectDialog(
              title: label,
              options: options,
              initialSelected: selectedValue,
            );
          },
        );
        if (result != null) {
          onSelectionChanged(result);
        }
      },
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            labelText: label,
            hintText: 'Select $label',
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFFE91E63), width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          controller: TextEditingController(text: selectedValue ?? ''),
          readOnly: true,
          validator: (value) {
            if (selectedValue == null || selectedValue.isEmpty) {
              return 'Please select an option';
            }
            return null;
          },
        ),
      ),
    );
  }

  void _proceedToPayment() {
    // Collect all form data
    Map<String, dynamic> completeBookingData = {
      ...widget.bookingData,
      'snorkelingTour': _selectedSnorkelingTours,
      'islandTour1': _selectedIslandTours,
      'inlandTour': _selectedInlandTours,
      'carRental': _selectedCarRentals,
      'hotel': _selectedHotels,
      'numTourists': _numTouristsController.text,
      'totalAmount': _combinedTotalController.text,
    };

    // Show payment confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Booking Confirmed'),
          content: Text(
            'Proceeding to payment for ${completeBookingData['firstName']} ${completeBookingData['lastName']}...',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                // Navigate to BookingSummary page with all details
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Theme(
                      data: Theme.of(context).copyWith(
                        textTheme: Theme.of(
                          context,
                        ).textTheme.apply(fontFamily: 'Roboto'),
                      ),
                      child: BookingSummary(
                        fullName:
                            '${completeBookingData['firstName']} ${completeBookingData['lastName']}',
                        email: completeBookingData['email'] ?? '',
                        contactNumber: completeBookingData['contact'] ?? '',
                        arrivalDate: _parseDate(completeBookingData['date']),
                        departureDate: _parseDate(
                          completeBookingData['departureDate'],
                        ),
                        selectedTour: _formatTourSummary(completeBookingData),
                        selectedHotel: (completeBookingData['hotel'] as List)
                            .join(', '),
                        selectedRental:
                            (completeBookingData['carRental'] as List).join(
                              ', ',
                            ),
                        totalAmount:
                            double.tryParse(
                              completeBookingData['totalAmount'] ?? '0',
                            ) ??
                            0,
                      ),
                    ),
                  ),
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  DateTime _parseDate(dynamic dateStr) {
    if (dateStr == null || dateStr.isEmpty) return DateTime.now();
    // Accepts MM/DD/YYYY
    final parts = dateStr.split('/');
    if (parts.length == 3) {
      return DateTime(
        int.parse(parts[2]),
        int.parse(parts[0]),
        int.parse(parts[1]),
      );
    }
    return DateTime.now();
  }

  String _formatTourSummary(Map<String, dynamic> data) {
    final snorkeling = (data['snorkelingTour'] as List).join(', ');
    final island = (data['islandTour1'] as List).join(', ');
    final inland = (data['inlandTour'] as List).join(', ');
    List<String> tours = [];
    if (snorkeling.isNotEmpty) tours.add('Snorkeling: ' + snorkeling);
    if (island.isNotEmpty) tours.add('Island: ' + island);
    if (inland.isNotEmpty) tours.add('Inland: ' + inland);
    return tours.join(' | ');
  }

  @override
  void dispose() {
    _totalAmountController.dispose();
    _numTouristsController.dispose();
    _numDaysController.dispose();
    _carRentalTotalController.dispose();
    _combinedTotalController.dispose();
    _hotelTotalController.dispose();
    super.dispose();
  }
}

// Dialog classes must be at the end of the file
class _MultiSelectDialog extends StatefulWidget {
  final String title;
  final List<String> options;
  final List<String> initialSelected;
  final bool showSelectAll;

  const _MultiSelectDialog({
    required this.title,
    required this.options,
    required this.initialSelected,
    this.showSelectAll = true,
  });

  @override
  State<_MultiSelectDialog> createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<_MultiSelectDialog> {
  late List<String> _tempSelected;
  bool _selectAll = false;

  @override
  void initState() {
    super.initState();
    _tempSelected = List<String>.from(widget.initialSelected);
    _selectAll =
        widget.showSelectAll && _tempSelected.length == widget.options.length;
  }

  void _onSelectAllChanged(bool? value) {
    setState(() {
      _selectAll = value ?? false;
      if (_selectAll) {
        _tempSelected = List<String>.from(widget.options);
      } else {
        _tempSelected.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select ${widget.title}'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.showSelectAll) ...[
              CheckboxListTile(
                value: _selectAll,
                onChanged: _onSelectAllChanged,
                title: Text('Select All'),
              ),
              Divider(),
            ],
            ...widget.options.map(
              (option) => CheckboxListTile(
                value: _tempSelected.contains(option),
                onChanged: (checked) {
                  setState(() {
                    if (checked == true) {
                      _tempSelected.add(option);
                      if (widget.showSelectAll &&
                          _tempSelected.length == widget.options.length) {
                        _selectAll = true;
                      }
                    } else {
                      _tempSelected.remove(option);
                      _selectAll = false;
                    }
                  });
                },
                title: Text(option),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('CANCEL'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(_tempSelected),
          child: Text('OK'),
        ),
      ],
    );
  }
}

class _SingleSelectDialog extends StatefulWidget {
  final String title;
  final List<String> options;
  final String? initialSelected;

  const _SingleSelectDialog({
    required this.title,
    required this.options,
    required this.initialSelected,
  });

  @override
  State<_SingleSelectDialog> createState() => _SingleSelectDialogState();
}

class _SingleSelectDialogState extends State<_SingleSelectDialog> {
  String? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialSelected;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select  ${widget.title}'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: widget.options
              .map(
                (option) => RadioListTile<String>(
                  value: option,
                  groupValue: _selected,
                  onChanged: (value) {
                    setState(() {
                      _selected = value;
                    });
                  },
                  title: Text(option),
                ),
              )
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('CANCEL'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(_selected),
          child: Text('OK'),
        ),
      ],
    );
  }
}
