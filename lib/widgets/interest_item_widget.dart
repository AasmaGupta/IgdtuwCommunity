
import 'package:flutter/material.dart';

class InterestItemWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double topMargin;

  const InterestItemWidget({
    Key? key,
    required this.imageUrl,
    required this.name,
    this.topMargin = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: topMargin),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              imageUrl,
              width: 102,
              height: 94, // Aspect ratio 1.08
              fit: BoxFit.contain,
            ),
          ),
          Text(
            name,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.14,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}