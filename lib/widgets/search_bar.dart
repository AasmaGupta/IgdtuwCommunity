import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9999),
              border: Border.all(
                color: const Color(0xFFD9D9D9),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Search for events...',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Image.asset(
                    'assets/images/search.png',
                    width: 16,
                    height: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 25),
        
      ],
    );
  }
}