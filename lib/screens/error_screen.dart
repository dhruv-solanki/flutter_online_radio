import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  ErrorScreen({required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text(
              'Something went wrong!',
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: IconButton(
                icon: Icon(
                  Icons.refresh,
                  size: 50,
                ),
                onPressed: onPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
