import 'package:flutter/material.dart';

class PostCardWidget extends StatelessWidget {
  final String profileImage;
  final String postContent;
  final String tagName;
  final String upvotes;
  final String comments;
  final String timePosted;
  final String upvoteIcon;
  final String commentIcon;

  const PostCardWidget({
    Key? key,
    required this.profileImage,
    required this.postContent,
    required this.tagName,
    required this.upvotes,
    required this.comments,
    required this.timePosted,
    required this.upvoteIcon,
    required this.commentIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 355,
      padding: const EdgeInsets.fromLTRB(17, 9, 17, 9),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFDEF0D3),
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side - post content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile image and post content
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    profileImage,
                    width: 38,
                    height: 39, // Aspect ratio ~0.97
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 7),
                  Text(
                    postContent,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              // Tag
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.fromLTRB(9, 0, 9, 10),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(0, 0, 0, 0.09),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Text(
                  tagName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6E6E6E),
                  ),
                ),
              ),

              // Upvotes and comments
              Padding(
                padding: const EdgeInsets.only(top: 13),
                child: Row(
                  children: [
                    Image.network(
                      upvoteIcon,
                      width: 26,
                      height: 23, // Aspect ratio ~1.13
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      upvotes,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Image.network(
                      commentIcon,
                      width: 26,
                      height: 23, // Aspect ratio ~1.13
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      comments,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Right side - options and time
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                "...",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6E6E6E),
                ),
              ),
              Text(
                timePosted,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6E6E6E),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}