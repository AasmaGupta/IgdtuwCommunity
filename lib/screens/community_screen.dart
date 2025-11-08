import 'package:flutter/material.dart';
import '../widgets/community_widget.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false, 
        child: SingleChildScrollView(
          child: Center(
            child: CommunityWidget(),
          ),
        ),
      ),
    );
  }
}
