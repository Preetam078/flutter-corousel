import 'package:flutter/material.dart';

class DealStatus extends StatelessWidget {
  final int shoppingCount;

  const DealStatus({
    super.key,
    required this.shoppingCount,
  });

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        margin: const EdgeInsets.only(top: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF607D8B).withOpacity(0.1), 
          borderRadius: BorderRadius.circular(30), 
          border: Border.all(
            color: Colors.white.withOpacity(0.2), 
            width: 0.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, -2),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.person,
              color: const Color(0xFFB2FF59),
              size: 14,
            ),
            const SizedBox(width: 8),
            Text(
              _formatNumber(shoppingCount),
              style: const TextStyle(
                color: Color(0xFFB2FF59), // Light green/yellow
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'SHOPPING NOW',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}