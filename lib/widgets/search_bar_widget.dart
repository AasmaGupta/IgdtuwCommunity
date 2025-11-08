
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 353,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Reddit logo
          Image.network(
            "https://cdn.builder.io/api/v1/image/assets/TEMP/b8447fbf5f59538b16ea72a8d965752185a68b60?placeholderIfAbsent=true",
            width: 39,
            height: 39,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 8),

          // Search input
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.black, width: 1),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 7),
                    child: Image.asset('assets/images/search.jpg',
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Search",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF828282),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Profile icon
            Image.asset('assets/images/avatar.png',
            width: 32,
            height: 36, // Aspect ratio 0.89
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}