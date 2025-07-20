import 'package:flutter/material.dart';
import 'package:booking_system2/payment.dart';

class BookingSummary extends StatelessWidget {
  final String fullName;
  final String email;
  final String contactNumber;
  final DateTime arrivalDate;
  final DateTime departureDate;
  final String selectedTour;
  final String selectedHotel;
  final String selectedRental;
  final double totalAmount;

  const BookingSummary({
    Key? key,
    required this.fullName,
    required this.email,
    required this.contactNumber,
    required this.arrivalDate,
    required this.departureDate,
    required this.selectedTour,
    required this.selectedHotel,
    required this.selectedRental,
    required this.totalAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Booking Summary')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildSummaryRow('Full Name', fullName),
                _buildSummaryRow('Email', email),
                _buildSummaryRow('Contact Number', contactNumber),
                _buildSummaryRow('Arrival Date', _formatDate(arrivalDate)),
                _buildSummaryRow('Departure Date', _formatDate(departureDate)),
                _buildSummaryRow('Selected Tour', selectedTour),
                _buildSummaryRow('Selected Hotel', selectedHotel),
                _buildSummaryRow('Car/Motor Rental', selectedRental),
                const Divider(height: 32),
                _buildSummaryRow(
                  'Total Amount',
                  '₱${totalAmount.toStringAsFixed(2)}',
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentSelection(),
                        ),
                      );
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
                      'PROCEED TO PAYMENT',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                        fontFamily: 'Roboto',
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

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(fontFamily: 'Roboto'),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }
}
