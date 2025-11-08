import 'package:flutter/material.dart';

class RedditScreen extends StatelessWidget {
  RedditScreen({super.key});

  final List<Map<String, dynamic>> posts = [
    {
      "user": "user1",
      "avatar": "assets/images/avatar.png",
      "text": "I wanna leave rahnuma, it is toxic.",
      "tag": "Rahnuma",
      "likes": 14,
      "comments": 52,
      "time": "Today"
    },
    {
      "user": "user2",
      "avatar": "assets/images/avatar.png",
      "text": "Should I join enactus, is it active? is it fun?",
      "tag": "Enactus",
      "likes": 14,
      "comments": 52,
      "time": "Yesterday"
    }
  ];

  final List<Map<String, String>> interests = [
    {"title": "Rotaract", "image": "assets/images/story1.jpg"},
    {"title": "GDG", "image": "assets/images/user4.jpg"},
    {"title": "B.H.A.V", "image": "assets/images/user1.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // App Bar
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage("assets/images/avatar.png"),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                          ),
                          child: Row(
                            children: const [
                              ImageIcon(AssetImage("assets/images/search.png"), size: 20),
                              SizedBox(width: 8),
                              Text("Search", style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const ImageIcon(AssetImage("assets/images/bell.png"), size: 24),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Tabs
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: ["Popular", "My posts", "Following", "Saved"]
                        .map(
                          (e) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: e == "Popular" ? Colors.green : const Color(0xFFF0F2EC),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              e,
                              style: TextStyle(color: e == "Popular" ? Colors.white : Colors.black),
                            ),
                          ),
                        )
                        .toList(),
                  ),

                  const SizedBox(height: 16),

                  // Posts
                  Column(
                    children: posts.map((post) {
                      return _buildPostCard(post);
                    }).toList(),
                  ),

                  // Interests
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Interests", style: Theme.of(context).textTheme.titleLarge),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: interests.length,
                      itemBuilder: (context, index) {
                        final item = interests[index];
                        return Container(
                          margin: const EdgeInsets.only(right: 12),
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage(item["image"]!),
                              fit: BoxFit.cover,
                            ),
                          ),
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
                            ),
                            child: Text(
                              item["title"]!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Extra post below interests
                  _buildPostCard({
                    "user": "user3",
                    "avatar": "assets/images/avatar.png",
                    "text": "Any events coming up in Rotaract this month?",
                    "tag": "Rotaract",
                    "likes": 8,
                    "comments": 20,
                    "time": "Today"
                  }),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),

          // Floating "New Post" button
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text("New Post"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(backgroundImage: AssetImage(post["avatar"])),
              const SizedBox(width: 8),
              Text(post["time"], style: const TextStyle(color: Colors.grey)),
              const Spacer(),
              const Text("...", style: TextStyle(fontSize: 20)),
            ],
          ),
          const SizedBox(height: 8),
          Text(post["text"]),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFE8E8E8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(post["tag"]),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const ImageIcon(AssetImage("assets/images/heart.png"), size: 20),
              const SizedBox(width: 4),
              Text("${post["likes"]}"),
              const SizedBox(width: 16),
              const ImageIcon(AssetImage("assets/images/comment.png"), size: 20),
              const SizedBox(width: 4),
              Text("${post["comments"]}"),
            ],
          )
        ],
      ),
    );
  }
}