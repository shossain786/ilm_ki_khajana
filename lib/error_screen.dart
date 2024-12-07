import 'package:flutter/material.dart';
import 'package:ilm_ki_khajana/modules/home/home.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Something went wrong!'),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              label: const Text('Go Back to Home'),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}
