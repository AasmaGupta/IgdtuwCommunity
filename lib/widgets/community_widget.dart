import 'package:flutter/material.dart';

class Post {
  final String username;
  final String text;
  int likes;
  final int comments;
  final String postImage;
  final String profileImage;

  Post({
    required this.username,
    required this.text,
    required this.likes,
    required this.comments,
    required this.postImage,
    required this.profileImage,
  });
}

class CommunityWidget extends StatefulWidget {
  const CommunityWidget({Key? key}) : super(key: key);

  @override
  State<CommunityWidget> createState() => _CommunityWidgetState();
}

class _CommunityWidgetState extends State<CommunityWidget> {
  final List<String> postImages = [
    "assets/images/post1.jpg",
    "assets/images/post2.jpg",
    "assets/images/post3.jpg",
    "assets/images/post4.jpg",
    "assets/images/post5.jpg",
  ];

  final List<String> profileImages = [
    "assets/images/user1.jpg",
    "assets/images/user2.jpg",
    "assets/images/user3.jpg",
    "assets/images/user4.jpg",
    "assets/images/user5.jpg",
  ];

  final List<Map<String, String>> stories = [
    {"image": "assets/images/story1.jpg", "name": "Rotaract Club"},
    {"image": "assets/images/story2.jpg", "name": "Hypnotics"},
    {"image": "assets/images/story3.jpg", "name": "Synergy"},
    {"image": "assets/images/story4.jpg", "name": "Zena"},
  ];

  final List<String> userNames = [
    "B.H.A.V",
    "Synergy",
    "Rotaract Club",
    "Google Developers Group",
    "MSC Official",
  ];

  late final List<Post> posts = List.generate(
    5,
    (index) => Post(
      username: userNames[index],
      text:
          "This is a post by ${userNames[index]}. Explore events, insights, and more. Be a part of the conversation!",
      likes: 100 + index * 10,
      comments: 16 + index,
      postImage: postImages[index],
      profileImage: profileImages[index],
    ),
  );

  final List<bool> isExpanded = List.generate(5, (_) => false);
  final List<bool> liked = List.generate(5, (_) => false);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      constraints: const BoxConstraints(maxWidth: 480),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header with Stories
            Container(
              color: const Color.fromRGBO(222, 240, 211, 0.23),
              padding: const EdgeInsets.fromLTRB(3, 51, 3, 0), 
              child: Column(
                children: [
                  const Text(
                    'Community',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'SF Pro Display',
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 22),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        stories.length,
                        (index) => Expanded(
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 40.5,
                                backgroundImage:
                                    AssetImage(stories[index]["image"]!),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                stories[index]["name"]!,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'SF Pro Display',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // User Posts
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDF5E5),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Author Info
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage(post.profileImage),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              post.username,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                fontFamily: 'SF Pro',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Post Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(post.postImage),
                        ),
                        const SizedBox(height: 12),

                        // Like Button
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                liked[index]
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: liked[index]
                                    ? Colors.red
                                    : Colors.grey[600],
                              ),
                              onPressed: () {
                                setState(() {
                                  liked[index] = !liked[index];
                                  liked[index]
                                      ? post.likes++
                                      : post.likes--;
                                });
                              },
                            ),
                            Text(
                              "${post.likes} likes",
                              style: const TextStyle(
                                fontFamily: 'SF Pro',
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),

                        // Expandable Text
                        GestureDetector(
                          onTap: () => setState(() {
                            isExpanded[index] = !isExpanded[index];
                          }),
                          child: RichText(
                            maxLines: isExpanded[index] ? null : 2,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'SF Pro',
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: "${post.username} ",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(text: post.text),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Comments Info
                        Text(
                          "View all ${post.comments} comments",
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'SF Pro',
                            color: Color(0xFF6E6E6E),
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Add Comment UI
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 12,
                              backgroundImage:
                                  AssetImage(profileImages[index]),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Text(
                                  'Add a comment...',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'SF Pro',
                                    color: Color(0xFF6E6E6E),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
