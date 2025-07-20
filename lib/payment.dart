import 'package:booking_system2/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Add this import for kIsWeb
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() => runApp(MaterialApp(home: PaymentSelection()));

class PaymentSelection extends StatefulWidget {
  @override
  _PaymentSelectionState createState() => _PaymentSelectionState();
}

class _PaymentSelectionState extends State<PaymentSelection> {
  String? _selectedPaymentMethod;
  File? _receiptImage;
  final ImagePicker _picker = ImagePicker();

  final Map<String, String> _paymentMethods = {
    'GCash': 'assets/images/gcash.png',
    'Maya': 'assets/images/maya.png',
    'E-Banking': 'assets/images/ebanking.png',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Payment Method'),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Center(
                child: Text(
                  'Select Payment Method',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(height: 30),

              // Payment Methods
              ..._paymentMethods.keys
                  .map((method) => _buildPaymentOption(method))
                  .toList(),

              SizedBox(height: 32),

              // Pay Now Button
              Center(
                child: ElevatedButton(
                  onPressed: _selectedPaymentMethod != null
                      ? () => _showPaymentImage()
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE91E63),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 3,
                  ),
                  child: Text(
                    'PAY NOW',
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
    );
  }

  Widget _buildPaymentOption(String method) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(
          color: _selectedPaymentMethod == method
              ? Color(0xFFE91E63)
              : Colors.grey[300]!,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: RadioListTile<String>(
        title: Text(
          method,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        value: method,
        groupValue: _selectedPaymentMethod,
        onChanged: (value) {
          setState(() {
            _selectedPaymentMethod = value;
          });
        },
        activeColor: Color(0xFFE91E63),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  void _showPaymentImage() {
    if (_selectedPaymentMethod == null) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                Text(
                  'Pay with $_selectedPaymentMethod',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 20),

                // Payment Image
                Image.asset(
                  'assets/qr.jpg',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),

                SizedBox(height: 20),

                // Instructions
                Text(
                  'Scan the QR code above to complete your payment',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                SizedBox(height: 20),

                // Close Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _showReceiptUpload();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFE91E63),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Payment Done'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showReceiptUpload() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text(
                'Upload Receipt',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Please attach a picture of your payment receipt to complete the booking.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                  SizedBox(height: 20),

                  // Receipt Image Preview
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[50],
                    ),
                    child: _receiptImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: kIsWeb
                                ? Image.network(
                                    _receiptImage!.path,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.check_circle,
                                            size: 40,
                                            color: Colors.green,
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            'Receipt selected',
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                : Image.file(_receiptImage!, fit: BoxFit.cover),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.receipt_long,
                                size: 40,
                                color: Colors.grey[400],
                              ),
                              SizedBox(height: 8),
                              Text(
                                'No receipt selected',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                  ),

                  SizedBox(height: 16),

                  // Upload Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () =>
                              _pickImage(ImageSource.camera, setState),
                          icon: Icon(Icons.camera_alt),
                          label: Text('Camera'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Color(0xFFE91E63),
                            side: BorderSide(color: Color(0xFFE91E63)),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () =>
                              _pickImage(ImageSource.gallery, setState),
                          icon: Icon(Icons.photo_library),
                          label: Text('Gallery'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Color(0xFFE91E63),
                            side: BorderSide(color: Color(0xFFE91E63)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _receiptImage = null;
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                ElevatedButton(
                  onPressed: _receiptImage != null
                      ? () {
                          Navigator.pop(context);
                          _showPaymentSuccess();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE91E63),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Submit'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source, StateSetter setState) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _receiptImage = File(image.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showPaymentSuccess() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 60),
              SizedBox(height: 16),
              Text(
                'Payment Successful!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Your booking has been confirmed.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFE91E63),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('OK'),
              ),
            ),
          ],
        );
      },
    );
  }
}
