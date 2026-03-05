import 'package:calories_buddy/widgets/floating_button.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Page'),
      ),
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 150,
            child: InkWell(
              onTap: () {
                
              },
              child: floatingButton(),
            ),
          ),
        ],
      ),
    );
  }
}