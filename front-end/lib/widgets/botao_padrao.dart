import 'package:flutter/material.dart';

class BotaoPadrao extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData icone;

  const BotaoPadrao({
    super.key,
    required this.label,
    required this.onPressed,
    this.icone = Icons.save,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 56.0,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromARGB(255, 241, 64, 4),
                Color.fromARGB(255, 201, 53, 15),
              ],
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
        
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            onPressed: onPressed,
            icon: Icon(icone, color: Colors.white),
            label: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

