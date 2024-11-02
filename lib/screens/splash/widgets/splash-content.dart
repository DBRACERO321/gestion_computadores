import 'package:flutter/material.dart';

class SplashContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white60, 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splash_image.png',
              fit: BoxFit.contain,
              width: double.infinity,
            ),
            SizedBox(height: 20),
            Text(
              'BY DARWIN BRACERO',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
